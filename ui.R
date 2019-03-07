
library("shiny")
library("shinydashboard")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Introduction", tabName = "Introduction", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("Original Codes", icon = icon("file-code-o"), 
             href = "https://github.com/rstudio/shinydashboard/")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Introduction",
            h2("Introduction tab content"),
            h6("Episode IV", align = "center"),
            h6("A NEW HOPE", align = "center"),
            h5("It is a period of civil war.", align = "center"),
            h4("Rebel spaceships, striking", align = "center"),
            h3("from a hidden base, have won", align = "center"),
            h2("their first victory against the", align = "center"),
            h1("evil Galactic Empire.", align = "center"),
            sliderInput("obs",
                        "Number of observations:",
                        min = 0,
                        max = 1000,
                        value = 500),
            fluidRow(
              box( h2("BOX  content"),
                   solidHeader = TRUE,
                   collapsible = TRUE,
                   title = "Histogram", status = "primary"),
              
              box(
                "Box content here", br(), "More box content",
                sliderInput("slider", "Slider input:", 1, 100, 50),
                textInput("text", "Text input:")
              )
            )
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
    )
  )
)


## ui code starts here
ui <- fluidPage(
  dashboardPage(
    dashboardHeader(title = "Final Project"),
    sidebar,
    body
  )
)
