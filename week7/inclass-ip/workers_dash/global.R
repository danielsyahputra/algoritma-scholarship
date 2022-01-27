library(shinydashboard)
library(shiny)
library(tidyverse)
library(glue)
library(plotly)
library(DT)
library(ggthemes)

# Data wrangling
workers <- read.csv("jobs_gender.csv")

workers_clean <- workers %>% 
  mutate_if(is.character, as.factor) %>% 
  mutate(year = as.factor(year))

head(workers_clean)

workers_clean <- workers_clean %>% 
  select(-wage_percent_of_male) %>% 
  drop_na(total_earnings_male, total_earnings_female) %>% 
  mutate(gap_earning = total_earnings_male - total_earnings_female)