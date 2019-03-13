library("shiny")
library("shinydashboard")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction", tabName = "Introduction", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("Original Codes", icon = icon("file-code-o"), 
             href = "https://github.com/rstudio/shinydashboard/"),
    menuItem("Age", tabName = "Age", icon = icon("th"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Introduction",
            h2("The Facts on Suicide"),
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
            plotlyOutput("bargraph"),
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
            tags$a(href = "https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016",
                   "Where we acquire the data: Click here!")
        
            
    ),
    tabItem(tabName = "widgets",
            h2("Widgets tab content"),
            p("p creates a paragraph of text."),
            p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-si16pt"),
            strong("strong() makes bold text."),
            em("em() creates italicized (i.e, emphasized) text."),
            br(),
            code("code displays your text similar to computer code"),
            div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
            br(),
            p("span does the same thing as div, but it works with",
              span("groups of words", style = "color:blue"),
              "that appear inside a paragraph."),
            selectInput("select_state", label = h3("Select box"),
                        choices = list("Illinoise" = 1, "Michigan" = 2, "Indiana" = 3,
                                       "Wisconsin" = 4, "Ohio" = 5),
                        selected = 1),

            hr(),
            fluidRow(column(3, verbatimTextOutput("value")))
    ),
    # Rita
    tabItem(tabName = "Age",
            h2("The "),
            p("m.hshtamh"),
            selectInput("sex", 
                        label = "Sex",
                        choices = list("female", "male"),
                        selected = "female"),
            selectInput("year",
                        label = "Year",
                        choices = c(1987 : 2016),
                        selected = "1987"),
            plotOutput("mapPlot"),
            
            ##age change trend during years
            selectInput("age",
                        label = "Age Group",
                        choices = list("5-14 years","15-24 years", "25-34 years", 
                                       "35-54 years", "55-74 years", "75+ years"),
                        selected = "5-14 years"),
            plotOutput("barPlot")
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

