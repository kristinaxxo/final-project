library(dplyr)
library(ggplot2)
library(shiny)
library(plotly)
library(reshape2)
library(lintr)
source("analysis.R")
source("yinan.R")

server <- function(input, output) {
  output$bargraph <- renderPlotly({
    overview
  })

  output$bar_plot <- renderPlot({
    age_group <- age_function(input$age)
    age_group
  })

  output$map_plot <- renderPlot({
    map <- map_datata(input$sex, input$year)
    map
    })

  #------------------------------
  #Yinan's Code Start From here
  #-----------------------------
  output$animated <- renderImage({
    #Idea of using temp Image file to save animated
    #image as a temp file came from stack overflow
    #since normal renderplot would not work for animated graph
    #It would return an error in lintr, but its the only usable method
    #that can be found online
    outfile <- tempfile(fileext = ".gif")
    p <- plot_animated (input$x_axis_animated, input$y_axis_animated,
                        input$facet)
    anim_save("outfile.gif", animate(p))
    list(src = "outfile.gif",
         contentType = "image/gif",
         width = 400,
         height = 380,
         alt = ""
    )
    }
    , deleteFile = TRUE)
  #output regression model summary
  output$model_summary <- renderPrint({
    summary(model2)
  })
  #output suicide box
  output$killed_box <- renderValueBox({
    predicted_num <- convert_input(input$gdp_per_capita,
                                   input$gdp_for_year,
                                   input$select_age, input$select_sex,
                                   input$input_year, input$input_population)
    valueBox(
      predicted_num, "Peop Suicide",
      icon = icon("skull"),
      color = "purple"
    )
  })

  #------------------------------
  #Yinan's Code End
  #-----------------------------

  #Badmaarag
  output$hdi.chart <- renderPlotly({
    plot_ly(suicide_data, x = ~country,  y = ~`suicides/100k pop`,
            type = "scatter", mode = "markers",
            color = ~`HDI for year`, size = ~`suicides/100k pop`,
            text = ~paste(year,
                          "</br>", "HDI for year: ", `HDI for year`)) %>%
      layout(xaxis = list(title = "", tickangle = 45),
             yaxis = list(title = "Suicides per 100k of population"),
             title = "Comparison between HDI and Suicide worldwide")
  })
  filtered <- reactive({
    suicide_data %>%
      filter(country == input$country_name) %>%
      group_by(country, year) %>%
      summarize(
        sum(suicides_no)
      )
  })

  output$linechart <- renderPlot ({
    ggplot(data = filtered(), mapping = aes_string(
      x = filtered()$year,
      y = filtered()$`sum(suicides_no)`
    ), shape = cyl) +
      geom_point(colour = "blue", shape = 18, size = 2) +
      stat_smooth(method = "lm", col = "yellow") +
      ggtitle("Change in the number suicide
              people over years in the chosen country") +
      xlab("year") +
      ylab("Number of suicide people")
})
  p <- reactive({
    suicide_data %>%
      filter(country == input$country_name) %>%
      group_by(year, `gdp_per_capita ($)`) %>%
      summarize(mean(`gdp_per_capita ($)`)) %>%
      select(year, `gdp_per_capita ($)`)
  })
    output$gdpchart <- renderPlot({
    ggplot(data = p(), mapping = aes_string(
      x = p()$year, y = p()$`gdp_per_capita ($)`)
    ) +
      geom_point(colour = "blue", shape = 23, size = 2) +
      geom_smooth(method = "lm", colour = "red") +
      ggtitle("Change in GDP per capita over years in the chosen country") +
      xlab("year") +
      ylab("GDP per capita")
  })
}