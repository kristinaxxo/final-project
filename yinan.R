# Yinan Guo
# Info 201
# This is my code for final project. Hope you don't lost by my comments
# I comment out some codes for normalization, dataset seperation, and
# different model since they are not used in this project.

library(ggplot2)
library(tibble)
library(readr)
library(dplyr)
library(gganimate)
library(countrycode)

# Question: based on the information form past x years, can you predict
# the suicide number in next y years?
suicide_data <- read_csv("data/master.csv")
#suicide <- read.csv("data/master.csv", stringsAsFactors = FALSE)


# predict the number of suiside that may happen with diferent input
# input gdp, population,gdp per capita
country_year_group <- suicide_data %>%
  group_by(country, year) %>%
  summarise(
    suicides_no = sum(suicides_no),
    `suicides/100k pop` = sum(`suicides/100k pop`),
    `gdp_for_year ($)` = mean(`gdp_for_year ($)`),
    `gdp_per_capita ($)` = mean(`gdp_per_capita ($)`),
    population = mean(population)
  )

df11 <- data.frame(country = country_year_group$country)

df11$continent <- countrycode(
  sourcevar = df11[, "country"],
  origin = "country.name",
  destination = "continent"
)
country_year_group$continent <- df11$continent


country_data <- function(df, country_name) {
  df[df$country == country_name, ]
}


# Seperate Training and testing Data set

df2 <- suicide_data
# seperate training and testing set
p <- 0.8
# create a list of 80% of the rows in the original dataset we can
# use for training
index <- round(nrow(df2) * p, 0)
# select 20% of the data for validation
training <- head(df2, index)
# use the remaining 80% of data to training and testing the models
testing <- tail(df2, nrow(df2) - index)


# Different models
# model1<-lm(data=training,formula =suicides_no~  population +`gdp_per_capita ($)`
# )
#
# model3 <- lm(data= suicide_data, formula = suicides_no~  `gdp_per_capita ($)`+
#                `gdp_for_year ($)` + age + sex)

model2 <- lm(data = suicide_data, formula = suicides_no ~ `gdp_per_capita ($)` +
  `gdp_for_year ($)` + age + sex + year + population)


# See how model run
distPred <- predict(model2, testing) # predict number
actuals_preds <- data.frame(cbind(
  actuals = testing$suicides_no,
  predicteds = distPred
))
correlation_accuracy <- cor(actuals_preds) # 80.2%
head(actuals_preds)
min_max_accuracy <- mean(apply(actuals_preds, 1, min) /
  apply(actuals_preds, 1, max))

# MAPE Calculation
# mape <- mean(abs((actuals_preds$predicteds - actuals_preds$actuals))
#              /actuals_preds$actuals)

tested <- head(testing, 1)
tested <- select(
  tested, `gdp_per_capita ($)`, `gdp_for_year ($)`,
  age, sex, year, population
)
convert_input <- function(gdp_per_capita, gdp_for_year, input_age, input_sex,
                          input_year, input_population) {
  gdp_per_capita <- as.numeric(gdp_per_capita)
  gdp_for_year <- as.numeric(gdp_for_year)
  input_population <- as.numeric(input_population)

  tested$`gdp_per_capita ($)` <- gdp_per_capita
  tested$`gdp_for_year ($)` <- gdp_for_year
  tested$age <- input_age
  tested$sex <- input_sex
  tested$year <- input_year
  tested$populuation <- input_population
  tested
  prediction <- predict(model2, tested)
  rounded_num <- round(prediction[[1]], 0)
  rounded_num
}



#### Plot animated graph



plot_animated <- function(x_axis = "gdp_per_capita ($)",
                          y_axis = "suicides_no", facet = FALSE) {
  x1 <- country_year_group[[x_axis]]
  y1 <- country_year_group[[y_axis]]

  if (facet == FALSE) {
    p_nofacet <- ggplot(
      country_year_group,
      aes(x = x1, y = y1, size = population, colour = country)
    ) +
      geom_point(show.legend = FALSE, alpha = 0.7) +
      scale_color_viridis_d() +
      scale_size(range = c(2, 12)) +
      scale_x_log10() +
      labs(x = x_axis, y = y_axis) +
      transition_time(year) +
      labs(title = "Year: {frame_time}") +
      shadow_wake(wake_length = 0.1, alpha = FALSE)
    p_nofacet
  } else {
    p <- ggplot(
      country_year_group,
      aes(x = x1, y = y1, size = population, colour = country)
    ) +
      geom_point(show.legend = FALSE, alpha = 0.7) +
      scale_color_viridis_d() +
      scale_size(range = c(2, 12)) +
      scale_x_log10() +
      labs(x = x_axis, y = y_axis) +
      facet_wrap(~continent) +
      transition_time(year) +
      labs(title = "Year: {frame_time}") +
      shadow_wake(wake_length = 0.1, alpha = FALSE)
    p
  }
}
