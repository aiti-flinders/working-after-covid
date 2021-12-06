## code to prepare `industry_of_employment` dataset goes here
library(readxl)
library(dplyr)
library(purrr)
library(tidyr)

path <- "data-raw/AGE10P - Age in Ten Year Groups and SEXP Sex by INDP - 1 Digit Level by STATE (POW).xlsx"

read_industry <- function(sheet, age, sex) {
  read_xlsx(path = path,
            sheet = {{sheet}},
            range = "B12:M34",
            col_names = c("indp",
                          strayr::clean_state(1:9, to = "state_name"),
                          "POW not applicable",
                          "Australia")) %>%
    pivot_longer(cols = 2:length(.),
                 names_to = "state",
                 values_to = "value") %>%
    mutate(age = {{age}}, 
           sex = {{sex}}) %>%
    filter(indp != "Total") 
  }


industry_of_employment <- pmap_df(.l = tb_helper(path), 
                                  .f = function(sheet, age, sex) read_industry(sheet, age, sex)) %>%
  group_by(state, age, sex) %>%
  mutate(share = value/sum(value, na.rm = TRUE)) %>%
  ungroup() 

usethis::use_data(industry_of_employment, overwrite = TRUE)
