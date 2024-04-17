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

not_questions <- c(
  "catid", "breedgroup", "sex", "age_behaviour", "other_cats",
  "problematic_behavior", "fearfulness", "human_aggression",
  "activity_playfulness", "cat_sociability", "human_sociability",
  "litterbox_issues", "excessive_grooming_2"
)

cat_survey <- cat_survey |>
  mutate(across(c(everything(), -any_of(not_questions)), as.integer)) |>
  glimpse()

usethis::use_data(cat_survey, overwrite = TRUE)
