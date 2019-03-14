library("shiny")
library("shinydashboard")
library("plotly")


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction", tabName = "Introduction", icon = icon("dashboard")),
    menuItem("Widgets",
      icon = icon("th"), tabName = "widgets"),
    menuItem("Animation and Prediction", icon = icon("chart-line"),
             tabName = "yinan"),
    menuItem("Age", tabName = "Age", icon = icon("th")),
    menuItem("Original Codes",
         icon = icon("file-code-o"),
         href = "https://github.com/rstudio/shinydashboard/"
)
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
      tabName = "Age",
      h2("The "),
      p("m.hshtamh"),
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

      ## age change trend during years
      selectInput("age",
        label = "Age Group",
        choices = list(
          "5-14 years", "15-24 years", "25-34 years",
          "35-54 years", "55-74 years", "75+ years"
        ),
        selected = "5-14 years"
      ),
     plotOutput("barPlot")
    ),
    
    tabItem(tabName = "yinan",
            fluidRow(
              div(class = "yinan-head", h1("Create Your Own Graph"),
                  p(class = "yinan-head-body",
                     "How have the relationship Between GDP and Suiside
                     Number changed over time?", br(),"How have GDP of countries
                     grew over time by continent?", br(), "What is the one question
                     that you want to ask?", br(), "Explore the datasetand create Your 
                     own Animated Graph!")
                  ),
              box( h2("Animated Graph"),
                   p("This may take a minute to load 
                     (Facet will take even longer)"),
                   
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   plotOutput("animated"),
                   p(class="comment2","Each dot here represents a county,
                     and its radius is its population."),
                   title = "", status = "primary"),
              
              box(
                h2("Inputs"),status = "warning",
                br(),
                #`suicides_no`,"gdp_per_capita ($)"
                
                selectInput("x_axis_animated",
                            label = h3("Chose a column for X"),
                            choices = list(
                              "GDP Per Capita" = "gdp_per_capita ($)",
                              "GDP For Year" = "gdp_for_year ($)",
                              "Suicide Number" = "suicides_no",
                              "Suicide Every 100k Peop" = "suicides/100k pop",
                              "Population" = "population"
                            ),
                            selected = "gdp_per_capita ($)"
                ),
                selectInput("y_axis_animated",
                            label = h3("Chose a column for Y"),
                            choices = list(
                              "GDP Per Capita" = "gdp_per_capita ($)",
                              "GDP For Year" = "gdp_for_year ($)",
                              "Suicide Number" = "suicides_no",
                              "Suicide Every 100k Peop" = "suicides/100k pop",
                              "Population" = "population"
                            ),
                            selected = "suicides_no"
                ),
                checkboxInput("facet", "Facet by Continent", value = FALSE)
              )
                   ),
            h2("Predicting with Multivariable Regression Analysis"),
            h2("What is Multivariable Regression Analysis"),
            p(class = "explain",
              "Multivariable Regression Analysis is the study of
              the relationship between several independent or
              predictor variables and a dependent or criterion variable.
              It would produce a multidimensional regression line(also known
              as the line of best fit) base off of the input.              
              We will use this model to predict the Suicide number of a country
              based on the GDP, the age group, sex, year number, and many other
              columns of interest. Compare to the more advanced model 
              such as LSTM 
              or Attention model for prediction, this model is chosen due 
              to its simplicity and limitation of our dataset. 
              We decided to use Multivariable Linear Regression other than
              Multivariable Logistic regression because most of our data 
              is continuous other than binary."),
            br(),
            fluidRow(
              box(h2("Predicting Result"),
                  solidHeader = TRUE,
                  collapsible = TRUE,
                  title = "Predicting Result", status = "primary",
                  valueBoxOutput("progressBox"),
                  br(),
                  p(class = "comment", "Scroll around and try different 
                    input to see how the prediction have changed")
                  ),
              box(title = "Selections", status = "warning",
                  br(),
                  textInput("gdp_per_capita", "GDP Per Capita", 
                            value = "8142"),
                  textInput("gdp_for_year", "Yearly GDP", 
                            value = "1.913830e+10"),
                  p(class = "comment2", "Highest GDP Per Capita so
                    far is 93053$"),
                  sliderInput("input_year", "Year:", 1985, 2100, 2019),
                  textInput("input_population", "Population",
                            value = "266700"),
                  selectInput("select_sex",
                              label = h3("Sex"),
                              choices = list(
                                "male" = "male",
                                "female" = "female"
                              ),
                              selected = "male"
                  ),
                  
                  selectInput("select_age",
                              label = h3("select a age group"),
                              choices = list(
                                "5-14 years" = "5-14 years",
                                "15-24 years" = "15-24 years",
                                "25-34 years" = "25-34 years",
                                "35-54 years" = "35-54 years",
                                "55-74 years" = "55-74 years",
                                "75+ years" = "75+ years"
                              ),
                              selected = "25-34 years"
                  )
              )
              ),
            br(),
            h1("More Information For These Graphs"),
            fluidRow(
              tabBox(
                id = "tabset1",
                title = "Model Summary",
                tabPanel("Model Stats", 
                         h4("Just to show this model is
                            Statistically Significant"),
                         verbatimTextOutput(outputId = "modelSummary")),
                tabPanel("Model Graph", img(src = "residual_plot.png"))
                )),
            h2("Myth Buster"),
            fluidRow(
              box(
                solidHeader = TRUE,
                collapsible = TRUE,
                h3("1. Being Poor/Rich caused suiside?"),
                br(),
                h4("Short answer? NO!"),
                tabPanel("Model Graph", img(src = "outfile.gif")),
                p("
                  According to our graph, most countriess moved horizontally in
                  the graph, showing only signs of increase in GDP, but
                  no sign in increase of Suicide Number. Inadditional,
                  there are some countries that shows a lower/higher
                  suicide number based on their GDP, so we may
                  conclude that GDP do not cause suicide")
                ),
              box(
                solidHeader = TRUE,
                collapsible = TRUE,
                h3("2. Asian have a higher Suicide Number?"),
                br(),
                h4("NO!"),
                tabPanel("Model Graph", img(src = "facet1.gif")),
                p("Some people think many Asian Countries are negligent
                  to mental health issues, so Asian counties will have more
                  suiside happening. 
                  Which is not the fact.
                  ")
                )
            )
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