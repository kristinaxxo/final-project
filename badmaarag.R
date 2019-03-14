library("shiny")
library("shinydashboard")
library("dplyr")
library("plotly")
library("ggplot2")



suicide_data <- read_csv("data/master.csv")

year_range <- range(suicide_data$year)

selected_value <- suicide_data$year

ui <- tabPanel(
  h1("HDI and GDP"),
  h3("The correlation between GDP and Suicide rate"),
  p("Suicides can be caused by many factors and in this section of the report, we will look into 
    the relationship between suicide rate and GDP per capita of countries.
    The plots below display the suicide rate and GDP per capita of a country of your 
    choice over the years between 1985 to 2016."),
  selectInput("country_name", label = "select a country", choices = suicide_data$country,
              selected = 1),
  mainPanel(
    plotOutput("linechart"),
    plotOutput("gdpchart")
  ),
  br(),
  p("If we observe the plots, the correlation between GDP per capita and suicide rates of countries all differ, 
  they are either positive or negative, which further suggests that economic status is 
  not the only factor that contributes to suicide."),
  h3("The correlation between HDI and Suicide rate"),
  p("According to United Nation's Development Programme, 
    Human Development Index (HDI) is created to measure the development of countries, 
    not based solely on their economic growth, 
    but human development, which further 
    contributes to questioning the government policy priorities of countries. 
    HDI is calculated based on three criterias which are a long, 
    healthy life, education level and standard of living."),
  p("The plot below shows the trend for HDI for each country between 1985 to 2016. 
    If we carefully observe the plot, it occurs that the lighter the color of HDI,
    the lesser the number of suicide. In other words, countries with higher HDI 
    have lower rate of suicide, therefore, their governments prioritize not only their 
    economic status, but also focus on their health care and education field."),
  br(),
  plotlyOutput("hdi.chart"),
  br(),
  h3("Conclusion"),
  p("In conclusion, based on the analysis of the relationships between suicide rate and GDP per capita,
    suicide rate and HDI, economic status does not have a major impact on suicide rate. Therefore, as the relationship 
    between HDI and suicide rate mostly shows a negative correlation among the countries, it wouldn't be wrong 
    to conclude that it is important for any country to focus on improving and developing their health care and education system 
    as much as how they focus on their economic growth, to prevent suicide." )
)


server <- function(input, output){
  
   output$hdi.chart <- renderPlotly({
     plot_ly(suicide_data, x = ~country,  y = ~`suicides/100k pop`, type = 'scatter',
             color = ~`HDI for year`, size = ~`suicides/100k pop`,
             text = ~paste(year,
                           "</br>", "HDI for year: ",`HDI for year`)) %>% 
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
       geom_point(colour = 'blue', shape = 18, size = 2) +
       stat_smooth(method = "lm", col = "yellow") +
       ggtitle("Change in the number suicide people over years in the chosen country") +
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
       geom_point(colour = 'blue', shape = 23, size = 2) +
       geom_smooth(method = "lm", colour = 'red') +
       ggtitle("Change in GDP per capita over years in the chosen country") +
       xlab("year") +
       ylab("GDP per capita")
   })
}


shinyApp(ui = ui, server = server)

