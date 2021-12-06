## code to prepare `distance_to_work` dataset goes here
library(readxl)
library(dplyr)
library(tidyr)
library(purrr)

path <- "data-raw/AGE10P - Age in Ten Year Groups and SEXP Sex by DTWP - 1 Digit Level by STATE (POW).xlsx"

dtwp_sheets <- excel_sheets(path)

read_dtwp <- function(sheet, age, sex) {
  read_xlsx(path,
            sheet = {{sheet}},
            range = "B12:M20",
            col_names = c("dtwp",
                          strayr::clean_state(1:9, to = "state_name"),
                          "POW not applicable",
                          "Australia")) %>%
    pivot_longer(cols = 2:length(.),
                 names_to = "state",
                 values_to = "value") %>%
    mutate(age = {{age}},
           sex = {{sex}}) %>%
    filter(dtwp != "Total")
    
}

distance_to_work <- pmap_dfr(.l = tb_helper(), .f = function(sheet, age, sex) read_dtwp(sheet, age, sex)) %>%
  group_by(state, age, sex) %>%
  mutate(share = value/sum(value, na.rm = TRUE)) %>%
  ungroup()

usethis::use_data(distance_to_work, overwrite = TRUE)
