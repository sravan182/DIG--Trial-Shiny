library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(survival)
library(DT)

# Load dataset
dig_raw <- read.csv("DIG.csv")

# Clean and label variables (consistent with DIG codebook)
dig_df <- dig_raw %>%
  select(ID, TRTMT, AGE, SEX, BMI, KLEVEL, CREAT, DIABP, SYSBP,
         HYPERTEN, CVD, WHF, DIG, HOSP, HOSPDAYS, DEATH, DEATHDAY) %>%
  mutate(
    TRTMT = factor(TRTMT, levels = c(0, 1), labels = c("Placebo", "Digoxin")),
    SEX = factor(SEX, levels = c(1, 2), labels = c("Male", "Female")),
    HYPERTEN = factor(HYPERTEN, levels = c(0, 1), labels = c("No", "Yes")),
    CVD = factor(CVD, levels = c(0, 1), labels = c("No", "Yes")),
    WHF = factor(WHF, levels = c(0, 1), labels = c("No", "Yes")),
    HOSP = factor(HOSP, levels = c(0, 1), labels = c("No", "Yes")),
    DEATH_num = as.numeric(DEATH),
    DEATH = factor(DEATH, levels = c(0, 1), labels = c("Alive", "Death")),
    Month = round(DEATHDAY / 30)
  )

# Friendly labels for dropdown menus
cont_vars <- c(
  "Age (years)" = "AGE",
  "Body Mass Index (BMI)" = "BMI",
  "Systolic BP (mmHg)" = "SYSBP",
  "Diastolic BP (mmHg)" = "DIABP",
  "Serum Creatinine (mg/dL)" = "CREAT",
  "Serum Potassium (mEq/L)" = "KLEVEL",
  "Follow-up Time (Months)" = "Month"
)

