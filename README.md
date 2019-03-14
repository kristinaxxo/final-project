# Final Project Proposal

## Project Description
Link to shinyApp: https://kristinaxxo.shinyapps.io/final-project/

1. What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be?

    &nbsp;&nbsp;&nbsp;&nbsp;The dataset we will be working with is **Suicide Rates Overview 1985 to 2016**. [Rusty](https://www.kaggle.com/russellyates88) collected this dataset. It was accessed through [kaggle](https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016), which is an open online datasets platform.The person who created this dataset used references from [United Nations Development Program](http://hdr.undp.org/en/indicators/137506), [World Bank](http://databank.worldbank.org/data/source/world-development-indicators#), [Suicide in the Twenty-First Century](https://www.kaggle.com/szamil/suicide-in-the-twenty-first-century/notebook) and [World Health Organization](http://www.who.int/mental_health/suicide-prevention/en/). The collection of data has the intention to prevent future suicide.

2. Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.

  &nbsp;&nbsp;&nbsp;&nbsp;The ultimate purpose of analyzing this dataset is to **prevent future suicide**. Hence, our main target audience would be any _non-profit organizations_ that have the goal of reducing suicide rates, _mentors_ at school and _therapies_ who specialize on this subject.

3. What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.

 - Question 1: How does the **change in GDP per capita** affect the suicide rates? Do developed countries and developing countries tend to have the same relationship between GDP per capita and suicide rates.

 - Question 2: How have the **suicide rate** in different **country/age group/generation/etc** changed over time

 - Question 3: How **age groups contributes** the suicide rate differently in the each **state** ? We might use the pie chart to show the suicide rate by different age group and it will change by different state you select.

 - Question 4: What can we _assume_ about **mental health care** development of the countries based on the relationship between **suicide rate** and **gdp per capita** or **human development index**?


## Technical Description
4. How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?

 &nbsp;&nbsp;&nbsp;&nbsp;We would download our dataset from [kaggle](https://www.kaggle.com/russellyates88/suicide-rates-overview-1985-to-2016) as a .csv file. So we would read in a static .csv file for this project

5. What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?

 &nbsp;&nbsp;&nbsp;&nbsp;Since the dataset we obtained is relatively clean and organized, all that we need to do for this data set is reformatting, reshaping, and regrouping. After that, we should be good to go.

6. What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as ```dplyr```
 ```
 library(tidyverse)
 library(psych)
 library(effsize)
 library(ggplot2)
 library(ggiraph)
 library(leaflet)
 library(gganimate)
 library(highcharter)
 library(sunburstR)
 ```


7. What major challenges do you anticipate?

 &nbsp;&nbsp;&nbsp;&nbsp;We might have merge conflicts and be not very comfortable with the new libraries. Also, when making charts, we might have difficulties in finding the proper or correct correlations while analyzing the data.
