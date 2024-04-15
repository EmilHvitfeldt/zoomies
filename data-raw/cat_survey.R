## code to prepare `cat_survey` dataset goes here

library(tidyverse)
library(readxl)
library(janitor)

cat_survey <- read_xlsx("data-raw/Feline_dataset.xlsx", sheet = 2) |>
  clean_names() |>
  mutate(
    other_cats = tolower(other_cats),
    other_cats = fct(other_cats, c("no", "yes"), "unknown"),
    problematic_behavior = tolower(problematic_behavior),
    problematic_behavior = fct(problematic_behavior, na = "unknown")
  )

usethis::use_data(cat_survey, overwrite = TRUE)
