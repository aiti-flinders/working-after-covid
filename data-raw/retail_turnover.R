## code to prepare `retail_turnover` dataset goes here
library(readabs)
library(dplyr)
library(lubridate)

retail_turnover <- read_abs("8501.0", tables = "4") %>%
  separate_series(column_names = c("indicator", "state", "industry")) %>%
  mutate(state = ifelse(state == "Total (State)", "Australia", state), 
         year = year(date), 
         month = month(date, abbr = FALSE, label = TRUE), 
         gender = "Persons", 
         age = "Total (age)") %>%   
  select(date, year, month, gender, age, state, series_type, unit, indicator, value)

usethis::use_data(retail_turnover, overwrite = TRUE)
