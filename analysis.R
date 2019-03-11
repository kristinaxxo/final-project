library(dplyr)
library(plotly)

suicide <- read.csv("data/master.csv", stringsAsFactors = FALSE)

overview_analysis <- suicide %>%
  group_by(country) %>%
  summarize(
    sum(suicides_no)
  )
overview <- plot_ly(overview_analysis,
                    x = ~ country, y = ~ `sum(suicides_no)`, type = "bar",
                    marker = list(color = "pink")
) %>%
  layout(
    title = "The total number of people who commit suicide from 1985 to 2016
    worldwide",
    xaxis = list(title = "Country"), yaxis = list(title = "Number of People")
  )