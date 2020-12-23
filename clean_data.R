

library(tidyverse)


SP_index <- read.csv("MULTPL-SP500_INFLADJ_QUARTER.csv")

SP_index_cleaned <- SP_index %>%
  mutate(DATE = as.Date(Date) + 1) %>%
  mutate(DATE = as.character(DATE)) %>%
  select(DATE, Value)


real_gdp_per_capita <- read.csv("A939RX0Q048SBEA.csv")

unemployment_rate <- read.csv("LRUN64TTUSQ156S.csv")


weekly_median_income <- read.csv("LES1252881600Q.csv")


real_gdp <- read.csv("GDPC1.csv")


quarterly_data <- full_join(SP_index_cleaned, real_gdp_per_capita, by = "DATE")
quarterly_data <- full_join(quarterly_data, unemployment_rate, by = "DATE")
quarterly_data <- full_join(quarterly_data, weekly_median_income, by = "DATE")
quarterly_data <- full_join(quarterly_data, real_gdp)

quarterly_data_cleaned <- quarterly_data %>%
  rename(SP_index = Value) %>%
  rename(GDP_per_capita = A939RX0Q048SBEA) %>%
  rename(unemployment_rate = LRUN64TTUSQ156S) %>%
  rename(weekly_median_income = LES1252881600Q) %>%
  rename(GDP = GDPC1)

write.csv(quarterly_data_cleaned, "quarterly_data_cleaned.csv")



