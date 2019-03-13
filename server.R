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
  
  output$barPlot <- renderPlot({
    ageGroup <- ageFunction(input$age)
    ageGroup
  })
  
  output$mapPlot <- renderPlot({
    map <- mapData(input$sex, input$year)
    map
  })
}