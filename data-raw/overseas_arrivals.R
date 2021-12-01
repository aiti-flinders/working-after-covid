## code to prepare `overseas_arrivals` dataset goes here
library(readabs)
library(readxl)
library(dplyr)
library(tidyr)
library(lubridate)
library(strayr)

short_term_returning <- read_abs("3401.0", tables = "12") %>%
  separate_series(column_names = c("number_of_movements", "indicator", "state")) %>%
  mutate(year = year(date),
         month = month(date, label = TRUE, abbr = FALSE),
         gender = "Persons",
         age = "Total (age)",
         state = clean_state(state, to = "state_name")) %>%
  select(date, year, month, gender, age, state, series_type, unit, indicator, value)

total_arrivals_path <- download_abs_data_cube("overseas-arrivals-and-departures-australia", 
                                              cube = "3401013.xlsx",
                                              path = "data-raw")

arrivals_departures <- function(path, sheet, range, indicator) {
  
  read_xlsx(path = {{path}},
            sheet = {{sheet}},
            range = {{range}}) %>%
    mutate(date = as.Date(Month),
           indicator = {{indicator}}) %>%
    pivot_longer(cols = 2:10,
                 names_to = "state",
                 values_to = "value") %>%
    mutate(state = clean_state(state, to = "state_name"),
           gender = "Persons",
           age = "Total (age)",
           year = year(date),
           age = "Total (age)",
           series_type = "Original",
           unit = "Number",
           month = month(date, label = TRUE, abbr = FALSE)) %>%
    select(date, year, month, gender, state, indicator, value)
}

total_arrivals <- arrivals_departures(total_arrivals_path,
                                      sheet = "Table 1.1",
                                      range = "A12:J381",
                                      indicator = "Arrivals (Overseas)")

total_departures <- arrivals_departures(total_arrivals_path,
                                        sheet = "Table 1.2",
                                        range = "A12:J381",
                                        indicator = "Departures (Overseas)")


overseas_arrivals <- bind_rows(short_term_returning,
                               total_arrivals,
                               total_departures)

usethis::use_data(overseas_arrivals, compress = "xz", overwrite = TRUE)
