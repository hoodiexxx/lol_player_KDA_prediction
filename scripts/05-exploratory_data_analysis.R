#### Preamble ####
# Purpose: Models exploration
# Author: Colin Sihan Yang
# Date: 21 November 2024
# Contact: colinsihan.yang@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)
library(brms)
library(ggplot2)


#### Read data ####
cleaned_data = read_parquet("data/02-analysis_data/cleaned_lol_data.parquet")

### Model data ####
model_data = cleaned_data

model_data$result = as.factor(model_data$result)

# Bayesian logistic regression model
bayesian_model <- stan_glm(
  result ~ total.cs + kills,   # Formula
  data = model_data,             # Data
  family = binomial(link = "logit"), # Logistic regression
  prior = normal(0, 2),        # Prior for coefficients
  prior_intercept = normal(0, 2), # Prior for intercept
  chains = 4,                  # Number of MCMC chains
  iter = 2000,                 # Number of iterations per chain
  seed = 123                   # For reproducibility
)

# View summary of the model
summary(bayesian_model)

# Predict probabilities
predicted_probabilities <- posterior_predict(bayesian_model, newdata = model_data)

# Calculate mean probabilities for each observation
mean_probabilities <- colMeans(predicted_probabilities)

# Classify predictions
predicted_classes <- ifelse(mean_probabilities > 0.5, 1, 0)


# Calculate accuracy
accuracy <- mean(predicted_classes == as.numeric(as.character(model_data$result)))
print(paste("Accuracy:", accuracy))

# plot(bayesian_model, prob = 0.95)



# model_data$predicted_prob <- mean_probabilities

# ggplot(model_data, aes(x = predicted_prob, y = as.numeric(as.character(result)))) +
#   geom_point(alpha = 0.6) +
#   stat_smooth(method = "glm", method.args = list(family = "binomial"), se = FALSE) +
#   labs(title = "Predicted Probabilities vs Actual Results", x = "Predicted Probability", y = "Actual Result") +
#   theme_minimal()

model_data$predicted_class <- as.factor(predicted_classes)  # Add predicted class
model_data$actual_class <- as.factor(as.numeric(as.character(model_data$result)))  # Convert actual class to factor

model_data$combined_label <- with(model_data, ifelse(
  actual_class == predicted_class & actual_class == "1", "Win - Correct",
  ifelse(actual_class != predicted_class & actual_class == "1", "Win - Incorrect",
    ifelse(actual_class == predicted_class & actual_class == "0", "Lose - Correct", "Lose - Incorrect")
  )
))

# Plot the combined labels with different colors
ggplot(model_data, aes(x = total.cs, y = kills, color = combined_label)) +
  geom_point(size = 3, alpha = 0.8) +  # Scatter plot points
  scale_color_manual(
    values = c(
      "Win - Correct" = "blue",
      "Win - Incorrect" = "lightblue",
      "Lose - Correct" = "green",
      "Lose - Incorrect" = "red"
    )
  ) +
  labs(
    title = "Prediction Results: Win/Lose and Accuracy",
    x = "Total CS",
    y = "Kills",
    color = "Prediction Result"
  ) +
  theme_minimal() +
  theme(legend.position = "right")






### Save model ####
saveRDS(
  bayesian_model,
  file = "models/first_win_rate_prediction_model.rds"
)


