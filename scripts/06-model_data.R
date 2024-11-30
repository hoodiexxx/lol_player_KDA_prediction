#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(here)
library(arrow)

set.seed(123)
#### Read data ####
cleaned_lol_data <- read_parquet(here("data/02-analysis_data/cleaned_lol_data.parquet"))

### Model data ####
# Main effect, random effect
set.seed(123)
formula = KDA ~ visionscore + totalgold + total.cs + damagetochampions + (1 | side) + + (1 | gamelength) + (1 | position)
priors = normal(0, 2.5, autoscale = TRUE)

bayesian_model_1 <- stan_glmer(
  formula = formula,
  data = cleaned_lol_data,
  family = gaussian(),
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  cores = 4,
  adapt_delta = 0.95
)

#### Save model ####
saveRDS(
  bayesian_model_1,
  file = "models/bayesian_model_1.rds"
)

train_indices = sample(seq_len(nrow(cleaned_lol_data)), size = 0.7 * nrow(cleaned_lol_data))

train_data = cleaned_lol_data[train_indices, ]
test_data = cleaned_lol_data[-train_indices, ]
write_parquet(train_data, "data/02-analysis_data/train_data.parquet")
write_parquet(test_data, "data/02-analysis_data/test_data.parquet")

bayesian_model_train <- stan_glmer(
  formula = formula,
  data = train_data,
  family = gaussian(),
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  cores = 4,
  adapt_delta = 0.95
)


#### Save model ####
saveRDS(
  bayesian_model_1,
  file = "models/bayesian_model_train.rds"
)




