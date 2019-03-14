library("shiny")
library("shinydashboard")
library("dplyr")
library("plotly")
library("ggplot2")

suicide_data <- read_csv("data/master.csv")

year_range <- range(suicide_data$year)

selected_value <- suicide_data$year


