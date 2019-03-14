source("yinan.R")
source("analysis.R")
library(dplyr)
library(ggplot2)
library(shiny)
library(plotly)
library(reshape2)

server <- function(input, output) {
  output$bargraph <- renderPlotly({
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
  
  #------------------------------
  #Yinan's Code Start From here
  #-----------------------------
  output$animated <- renderImage({
    #Idea of using render Image to save animated 
    #image as a temp file came from stack overflow
    #since normal renderplot would not work for animated graph
    outfile <- tempfile(fileext='.gif')
    p <- plot_animated (input$x_axis_animated, input$y_axis_animated,
                        input$facet)
    anim_save("outfile.gif", animate(p))
    list(src = "outfile.gif",
         contentType = 'image/gif',
         width = 400,
         height = 380,
         alt = ""
    )}, deleteFile = TRUE)
  
  #output regression model summary
  output$modelSummary <- renderPrint({
    summary(model2)
  })
  
  #output suicide box
  output$progressBox <- renderValueBox({
    predicted_num <- convert_input(input$gdp_per_capita,
                                   input$gdp_for_year,
                                   input$select_age, input$select_sex,
                                   input$input_year,input$input_population)
    valueBox(
      predicted_num, "Peop Suicide",
      icon = icon("skull"),
      color = "purple"
    )
  })
  
  #------------------------------
  #Yinan's Code End 
  #-----------------------------
}