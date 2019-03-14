library("shiny")
library("shinydashboard")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction", tabName = "Introduction", icon = icon("dashboard")),
    menuItem("Widgets",
             icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green"
    ),
    menuItem("Original Codes",
             icon = icon("file-code-o"),
             href = "https://github.com/rstudio/shinydashboard/"
    ),
    menuItem("Quantity", tabName = "Quantity", icon = icon("th"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "Introduction",
      h2("Facts of Suicide"),
      p("The action of sucide typically involves strong emotional repercussions not
        only affecting victims themsevles but also affecting surrounding people.
        It is reported that approximately one million people die from suicide by 
        The World Health Organisation(WHO) and it is considered as one of the three
        leading causes of death worldwide. The cause for suicide varies including 
        xxx, and certain groups tend to commit suicide more frequent than others."),
      h2("Insight of suicide worldwide"),
      p("In every country, the number of people who commit suicides are
        substantial. The bar graph below gives a general overivew on the
        total number of people died from suicide from 1985 to 2016 in each
        country where the data could be collected."),
      plotOutput("bargraph"),
      br(),
      h2("What is our purpose?"),
      p("The ultimate purpose of analyzing this dataset is to prevent
        future suicide by finding out the cause to suicide based on the
        dataset we used. Alternatively, we also provide a prediction on
        the suicide rate with respect to given conditions."),
      h2("Analysis Overview"),
      h4("Data Overview"),
      tags$ul(
        tags$li("first aspect"),
        tags$li("Second list item"),
        tags$li("Third list item")
      ),
      h3("Who Are We?"),
      p("This project was made by Yinan Guo, Song Xue, Rita Wu,
        Badmaarag Batjargal as the final project for the course Info 201."),
      tags$a(
        href = "https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016",
        "Source of data: Click here!"
      )
      ),
    tabItem(
      tabName = "widgets",
      h2("Widgets tab content"),
      p("p creates a paragraph of text."),
      p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
      strong("strong() makes bold text."),
      em("em() creates italicized (i.e, emphasized) text."),
      br(),
      code("code displays your text similar to computer code"),
      div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
      br(),
      p(
        "span does the same thing as div, but it works with",
        span("groups of words", style = "color:blue"),
        "that appear inside a paragraph."
      ),
      selectInput("select_state",
                  label = h3("Select box"),
                  choices = list(
                    "Illinoise" = 1, "Michigan" = 2, "Indiana" = 3,
                    "Wisconsin" = 4, "Ohio" = 5
                  ),
                  selected = 1
      ),
      
      hr(),
      fluidRow(column(3, verbatimTextOutput("value")))
    ),
    
    # Rita
    tabItem(
      tabName = "Quantity",
      h2("The big numbers about suicide"),
      p("Close to 800 000 people die due to suicide every year, which is one person every 40 seconds. 
        Suicide is a global phenomenon and occurs throughout the lifespan. Effective and evidence-based 
        interventions can be implemented at population, sub-population and individual levels to prevent 
        suicide and suicide attempts. There are indications that for each adult who died by suicide there 
        may have been more than 20 others attempting suicide."),
      h2("Worldwide suicide rates for men and women over the past 30 years"),
      p("The maps shows the suicide amount of countries from 1987 to 2016 which divided by gender. The color more
        darker means more people chose suicide during that year."),
      br(),
      p("(Some of countries's suicide amount undefined.)"),
      selectInput("sex",
                  label = "Sex",
                  choices = list("female", "male"),
                  selected = "female"
      ),
      selectInput("year",
                  label = "Year",
                  choices = c(1987:2016),
                  selected = "1987"
      ),
      plotOutput("mapPlot"),
      
      
      h2("The suicide rate by different age groups"),
      p("The chart shows how the different age groups' suicide rate changed during 30 years. 
      Suicide occurs throughout the lifespan and is the second leading cause of death among 15-29 year olds globally."),
      ## age change trend during years
      selectInput("age",
                  label = "Age Group",
                  choices = list(
                    "5-14 years", "15-24 years", "25-34 years",
                    "35-54 years", "55-74 years", "75+ years"
                  ),
                  selected = "5-14 years"
      ),
      plotOutput("barPlot"),
      
      h2("The information we know"),
      h4("From geographic position"),
      tags$ul(
        tags$li("In Europe, USA, Russia are the highest suicide rates are reported for both men and women."),
        tags$li("The Eastern Mediterranean Region and Central Asia republics have the lowest suicide rates."),
        tags$li("There are not major different about suicide number for each year.")),
      h4("From age group."),
      tags$ul(
        tags$li("suicide rates have traditionally been highest amongst elderly males, rates among young people have been increasing 
              a lot."),
        tags$li("Males are four times more likely to die from suicide than are females."),
        tags$li("Although suicide is a serious problem among the young and adults, death rates continue to be highest among older adults ages 75 years and over."))
      )
    )
    )


## ui code starts here
ui <- fluidPage(
  includeCSS("custom.css"),
  dashboardPage(
    dashboardHeader(title = "Suicide Analysis"),
    sidebar,
    body
  )
)

library(dplyr)
library(plotly)
library("shiny")
library("ggplot2")
library("rsconnect")
library("ggiraph")
library("colormap")
library("styler")
library("lintr")
library(ggthemes)

# Read in dataset from local desktop
suicide <- read.csv("data/master.csv", stringsAsFactors = FALSE)

# Graph of total suicide people country for introduction
overview_analysis <- suicide %>%
  group_by(country) %>%
  summarize(
    sum(suicides_no)
  )
overview <- plot_ly(overview_analysis,
                    x = ~country, y = ~`sum(suicides_no)`, type = "bar",
                    marker = list(color = "pink")
) %>%
  layout(
    title = "The total number of people who commit suicide from 1985 to 2016
    worldwide",
    xaxis = list(title = "Country"), yaxis = list(title = "Number of People")
  )

###### bar chart########

# get general data for the bar chart about age group
generalAge <- suicide[c(2, 3, 4, 5)]

# get the function that choose age for the bar chart
ageFunction <- function(inputAge) {
  ageGroup <- generalAge[generalAge$age == inputAge, ]
  
  # get the suicide number of that age group for 30 years
  ageSum <- ageGroup %>%
    group_by(year, sex) %>%
    summarise(
      suicides_no = sum(suicides_no)
    )
  
  # create the bar chart by age and have both sex
  age <- ggplot(data = ageSum) +
    aes(x = year, y = `suicides_no`, fill = factor(sex)) +
    geom_bar(stat = "identity", position = "dodge") +
    xlab("Year") + ylab("Suicide total number")
  age
}


###### map #####

# get general the data for the world map
general <- suicide[c(1, 2, 3, 5)]

# get the world map
map_world <- map_data("world")

# the function for filter the sex
mapData <- function(inputSex, inputYear) {
  sexData <- function(inputSex) {
    s <- general %>% filter(sex == inputSex)
  }
  
  sInput <- sexData(inputSex)
  
  # the function for choose year
  yearData <- function(inputYear) {
    yearNum <- sInput %>%
      group_by(country, year = inputYear) %>%
      summarise(
        suicideSum = sum(suicides_no)
      )
  }
  mapDf <- yearData(inputYear)
  
  # find the different name and correct it
  mapsNames <- unique(unname(unlist(map_data("world")["region"])))
  dataNames <- mapDf$country
  setdiff(x = dataNames, y = mapsNames)
  mapDf$country <- recode(mapDf$country,'United States' = 'USA', 'United Kingdom' = 'UK', "Republic of Korea" = "South Korea",
                          "Russian Federation" = "Russia", "Antigua and Barbuda" = "Antigua", "Antigua and Barbuda" = "Antigua",
                          "Cabo Verde" = "Cape Verde", "Macau" = "China", "Saint Vincent and Grenadines" = "Saint Vincent",
                          "Saint Vincent and Grenadines" = "Saint Vincent"
  )
  
  # combine the chart
  map_world_join <- left_join(map_world, mapDf, by = c("region" = "country"))
  # View(map.world)
  # View(map.world_join)
  map_world_join <- map_world_join %>% mutate(fill_flg = ifelse(is.na(suicideSum), F, T))
  # View(map.world_join)
  #df_country_points <- data.frame(country = mapDf$country, stringsAsFactors = F)
  # glimpse(df.country_points)
  
  # create the map
  # interactive
  g <- ggplot(map_world_join) +
    geom_polygon_interactive(
      color = "GRAY",
      aes(long, lat,
          group = group, fill = suicideSum,
          tooltip = paste(region, "<br/>", suicideSum)
      )
    ) +
    hrbrthemes::theme_ipsum() +
    colormap::scale_fill_colormap(
      colormap = colormap::colormaps$copper, reverse = T
    ) +
    labs(
      title = "The Suicide Number Around World", 
      caption = "number of people"
    )
  g
}  
