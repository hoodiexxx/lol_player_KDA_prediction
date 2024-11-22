#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 26 September 2024 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(testthat)

cleaned_data = read_parquet("data/02-analysis_data/cleaned_lol_data.parquet")


# Check if the dataset has 5 rows
if (nrow(cleaned_data) == 470) {
  message("Test Passed: The dataset has 5 rows.")
} else {
  stop("Test Failed: The dataset does not have 5 rows.")
}

# Check if the dataset has 3 columns
if (ncol(cleaned_data) == 20) {
  message("Test Passed: The dataset has 20 columns.")
} else {
  stop("Test Failed: The dataset does not have 20 columns.")
}

# Check if all values in the 'division' column are unique
# if (n_distinct(cleaned_data$division) == nrow(cleaned_data)) {
#   message("Test Passed: All values in 'division' are unique.")
# } else {
#   stop("Test Failed: The 'division' column contains duplicate values.")
# }

# Check if the 'state' column contains only valid Australian state names
valid_positions <- c("jng", "sup", "top", "mid", "bot")

if (all(cleaned_data$position %in% valid_positions)) {
  message("Test Passed: The 'position' column contains only valid league of legend position.")
} else {
  stop("Test Failed: The 'position' column contains invalid league of legend position.")
}

valid_sides <- c("Blue", "Red")

if (all(cleaned_data$side %in% valid_sides)) {
  message("Test Passed: The 'party' column contains only valid party names.")
} else {
  stop("Test Failed: The 'party' column contains invalid party names.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(cleaned_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in 'division', 'state', and 'party' columns
if (all(cleaned_data$teamname != "" & cleaned_data$playername != "" & cleaned_data$champion != "")) {
  message("Test Passed: There are no empty strings in 'teamname', 'playername', or 'champion'.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}



# Check if the 'party' column has at least two unique values
if (n_distinct(cleaned_data$position) == 5) {
  message("Test Passed: The 'party' column contains at least two unique values.")
} else {
  stop("Test Failed: The 'party' column contains less than two unique values.")
}