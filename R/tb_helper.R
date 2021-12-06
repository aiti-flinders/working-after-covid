#' Help for reading table builder files with 10 Year Groups and Sex
#'
#' @return
#' @export
#'
#' @examples
tb_helper <- function(path) {
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
    sheet = readxl::excel_sheets(path),
    age = age, 
    sex = sex
  )
  
  return(l)
}