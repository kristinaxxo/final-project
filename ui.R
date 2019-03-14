library("shiny")
library("shinydashboard")
library("plotly")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      "Introduction", tabName = "Introduction", icon = icon("dashboard")
             ),
    menuItem("Age and Area", tabName = "Age", icon = icon("globe-asia")),
    menuItem(
      "HDI and GDP", tabName = "HDI_and_GDP", icon = icon("dollar-sign")
             ),
    menuItem("Animation and Prediction",
      icon = icon("chart-line"),
      tabName = "yinan"
    ),
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
      p("The action of sucide typically involves strong emotional repercussionsnot
        only affecting victims themsevles but also affecting surrounding people.
        It is reported that approximately one million people die from suicide by 
        The World Health Organisation(WHO) and it is considered as one of the three
        leading causes of death worldwide. The cause for suicide varies including 
        xxx, and certain groups tend to commit suicide more frequent than others."),
      h2("Insight of suicide worldwide"),
      p("In every country, the number of people who commit suicides are
        substantial. The bar graph below gives a", strong("general overivew"), "on the
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
      p("This project was made by",
strong(class = "name", "Yinan Guo, Song Xue, Rita Wu,
                                           Badmaarag Batjargal"),
"as the final project for the course Info 201."),
      tags$a(
        href = "https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016",
        "Source of data: Click here!"
      )
    ),
    # Rita
# Rita
tabItem(
  tabName = "Age",
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
  ),

    # Badmaarag
    tabItem(
      tabName = "HDI_and_GDP",
      h1("HDI and GDP"),
      h3("The correlation between GDP and Suicide rate"),
      p("Suicides can be caused by many factors and in this section of the report, we will look into 
        the relationship between suicide rate and GDP per capita of countries.
        The plots below display the suicide rate and GDP per capita of a country of your 
        choice over the years between 1985 to 2016."),
      selectInput("country_name",
        label = "select a country", choices = suicide_data$country,
        selected = 1
      ),
      plotOutput("linechart"),
      br(),
      plotOutput("gdpchart"),
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
        as much as how they focus on their economic growth, to prevent suicide.")
    ),

    # Yinan
    tabItem(
      tabName = "yinan",
      fluidRow(
        div(
          class = "yinan-head", h1("Create Your Own Graph"),
          p(
            class = "yinan-head-body",
            "How have the relationship Between GDP and Suiside
                     Number changed over time?", br(), "How have GDP of countries
                     grew over time by continent?", br(), "What is the one question
                     that you want to ask?", br(), "Explore the datasetand create Your 
                     own Animated Graph!"
          )
        ),
        box(h2("Animated Graph"),
          p("This may take a minute to load 
                     (Facet will take even longer)"),
          solidHeader = TRUE,
          collapsible = TRUE,
          plotOutput("animated"),
          p(class = "comment2", "Each dot here represents a county,
                     and its radius is its population."),
          title = "", status = "primary"
        ),

        box(
          h2("Inputs"),
          status = "warning",
          br(),
          # `suicides_no`,"gdp_per_capita ($)"

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
      p(
        class = "explain",
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
              is continuous other than binary."
      ),
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
        box(
          title = "Selections", status = "warning",
          br(),
          textInput("gdp_per_capita", "GDP Per Capita",
            value = "8142"
          ),
          textInput("gdp_for_year", "Yearly GDP",
            value = "1.913830e+10"
          ),
          p(class = "comment2", "Highest GDP Per Capita so
                    far is 93053$"),
          sliderInput("input_year", "Year:", 1985, 2100, 2019),
          textInput("input_population", "Population",
            value = "266700"
          ),
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
          tabPanel(
            "Model Stats",
            h4("Just to show this model is
                            Statistically Significant"),
            verbatimTextOutput(outputId = "modelSummary")
          ),
          tabPanel("Model Graph", img(src = "residual_plot.png"))
        )
      ),
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