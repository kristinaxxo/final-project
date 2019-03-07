#dir.create("~/Downloads/jena_climate", recursive = TRUE)
#download.file(
#  "https://s3.amazonaws.com/keras-datasets/jena_climate_2009_2016.csv.zip",
#  "~/Downloads/jena_climate/jena_climate_2009_2016.csv.zip"
#)
#unzip(
#  "~/Downloads/jena_climate/jena_climate_2009_2016.csv.zip",
#  exdir = "~/Downloads/jena_climate"
#)

library(ggplot2)
library(tibble)
library(readr)
library(dplyr)
country_name = "United States"

suicide_data <- read_csv("data/master.csv")
#question, based on the information form past x years, can you predict
#the suicide number in next y years? 

#predict the number of suiside that may happen with diferent input
#input gdp, population,gdp per capita
sum(is.na(suicide_data$`HDI for year`))
suicide_data$have_HDI <- !is.na(suicide_data$`HDI for year`)
country_year_group <- suicide_data%>%
  group_by(country,year)  %>% 
  summarise(
    suicides_no = sum(suicides_no),
    `suicides/100k pop` = sum(`suicides/100k pop`),
    `gdp_for_year ($)` = mean(`gdp_for_year ($)`),
    `gdp_per_capita ($)` = mean(`gdp_per_capita ($)`),
    population = mean(population)
    #  `HDI for year` = mean (`HDI for year`)
  )

#max-min normalizaton
#normalize <- function(x) {
#  ((x - min(x)) / (max(x) - min(x)))
#}

country_data <- function (df,country_name){
  df[df$country == country_name,]
}


##normalize all columns
#country_year_group$suicides_no <- normalize(country_year_group$suicides_no)
#country_year_group$`suicides/100k pop` <-
#  normalize(country_year_group$`suicides/100k pop`)
#country_year_group$`gdp_for_year ($)` <-
#  normalize(country_year_group$`gdp_for_year ($)`)
#country_year_group$`gdp_per_capita ($)` <-
#  normalize(country_year_group$`gdp_per_capita ($)`)
#country_year_group$population <-
#  normalize(country_year_group$population)
#country_year_group <- country_year_group[!is.na(country_year_group$`suicides/100k pop`),]
#


#country_data_table <- country_data(country_year_group,country_name)
input_data <-country_year_group %>% 
  select(country,year,suicides_no,population,`suicides/100k pop`,`gdp_for_year ($)`,`gdp_per_capita ($)`)
#ggplot(data = country_data_table, aes(x= year, y = `suicides/100k pop`))+geom_line()

##ML From Here
get_class_1 <- function (num, seq){
  a<- 0
  for (i in 1:length(seq)){
    if (seq[i] <= num & num < seq[i+1]) {
      a <- i
    }
  }
  a
}
#seq1 <- seq(from = 0.00, to = 1.05, by = 0.05)


#add_class_col<- function (df){
#  seq1 <- seq(from = 0.00, to = 1, by = 0.05)
#  df$suicide_class <- sapply(df$`suicides/100k pop`, get_class_1, seq = seq1)
#}


#add_class_col(input_data)
#a <- sapply(input_data$`suicides/100k pop`,get_class_1,seq = seq1)
#input_data$suicide_class <- a
#hist(input_data$suicide_class)
#input <- select(data = input_data, year, population, suicides_no,`gdp_for_year ($)`,`gdp_per_capita ($)`)

df2 <- country_year_group[sample(nrow(country_year_group)),]
#seperate training and testing set
p=0.8
# create a list of 80% of the rows in the original dataset we can use for training
index <- round(nrow(df2) *p , 0)
# select 20% of the data for validation
training <- head(df2, index)
# use the remaining 80% of data to training and testing the models
testing <- tail(df2, nrow(df2)-index)
#year ++`gdp_per_capita ($)`
model1<-lm(data=training,formula =suicides_no~  population +`gdp_per_capita ($)`
)
distPred <- predict(model1, testing)  # predict distance
actuals_preds <- data.frame(cbind(actuals=testing$suicides_no, predicteds=distPred))  # make actuals_predicteds dataframe.
correlation_accuracy <- cor(actuals_preds)  # 80.2%
head(actuals_preds)
min_max_accuracy <- mean(apply(actuals_preds, 1, min) / apply(actuals_preds, 1, max))  
# => 38.00%, min_max accuracy

# MAPE Calculation
mape <- mean(abs((actuals_preds$predicteds - actuals_preds$actuals))/actuals_preds$actuals)  