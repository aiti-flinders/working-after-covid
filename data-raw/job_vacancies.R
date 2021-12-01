## code to prepare `job_vacancies` dataset goes here

library(readabs)
library(dplyr)
library(lubridate)

job_vacancies <- read_abs("6354.0", tables = "4") %>%
  separate_series(column_names = c("indicator", "industry")) %>%
  mutate(year = year(date),
         month = month(date, label = TRUE, abbr = FALSE), 
         gender = "Persons", 
         age = "Total (age)", 
         state = "Australia")  %>% 
  select(date, year, month, gender, age, state, series_type, unit, indicator, value)

usethis::use_data(job_vacancies, compress = "xz", overwrite = TRUE)
