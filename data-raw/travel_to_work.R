## code to prepare `travel_to_work` dataset goes here
library(purrr)
library(dplyr)
library(tidyr)
library(readxl)

mtwp_sheets <- excel_sheets(path = "data-raw/AGE10P - Age in Ten Year Groups and SEXP Sex by MTW15P Method of Travel to Work (15 travel modes) and INDP - 1 Digit Level by STATE (POW).xlsx")

age <- c("15-19 years",
          "20-29 years",
          "30-39 years",
          "40-49 years",
          "50-59 years",
          "60-69 years",
          "70-79 years",
          "80-89 years",
          "90-99 years",
          "100 years and over",
          "Total")

sex <- c("Male", "Female")

l <- data.frame(
  sheet = mtwp_sheets,
  age = age, 
  sex = sex
)


read_mtwp <- function(sheet, age, sex) {
  
  read_xlsx("data-raw/AGE10P - Age in Ten Year Groups and SEXP Sex by MTW15P Method of Travel to Work (15 travel modes) and INDP - 1 Digit Level by STATE (POW).xlsx",
            sheet = {{sheet}},
            range = "B12:N402",
            col_names = c("mtwp",
                          "indp1",
                          strayr::clean_state(1:9),
                          "POW not applicable",
                          "Aus")) %>% 
    fill(mtwp, .direction = "down") %>%
    pivot_longer(cols = 3:length(.),
                 names_to = "state",
                 values_to = "value") %>%
    mutate(age = {{age}},
           sex = {{sex}}) %>%
    filter(mtwp != "Total")
}

travel_to_work <- pmap_dfr(.l = l, .f = function(sheet, age, sex) read_mtwp(sheet = sheet, age = age, sex = sex)) %>%
  group_by(indp1, state, age, sex) %>%
  mutate(share = value/sum(value, na.rm = TRUE),
         state = strayr::clean_state(state, to = "state_name", fuzzy_match = FALSE)) %>%
  ungroup()

usethis::use_data(travel_to_work, overwrite = TRUE)

