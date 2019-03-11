library(dplyr)
library(ggplot2)
source("analysis.R") 
library(shiny)
library(plotly)
library(reshape2)

server <- function(input, output) {
  output$bargraph<- renderPlotly({
    overview
  })
}