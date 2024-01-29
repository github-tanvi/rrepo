#week 4 exercise

#To complete the following exercises, you will need to copy and paste the code below into your R Studio session. 
#This should create a data frame named `adsl` in your environment. 

#helping notes: check data manipulations functions, data types and formats, data merging topics from previous workshops
#(these materials are available in our ODA Hyderabad TEAMS channel and also @ github-tanvi)

# load following packages or install first if not installed earlier------------------------------------------
library(dplyr)
library(forcats)

set.seed(1)

adsl <- data.frame(SUBJIDN  = 1:200,
                   SEX      = sample(c('M','F', NA), 200, replace = T, prob = c(.8,.15,.05)),
                   AGE      = runif(200, min=20, max=59) %>% round(),
                   TRTP     = sample(c('DRUG','PLACEBO'), 200, replace = T),
                   SAFFL    = sample(c('Y','N', NA), 200, replace = T, prob = c(.9,.07,.03)),
                   COUNTRY  = sample(c('AMERICA','INDIA','EU','CHINA','CANADA'), 200, replace = T),
                   stringsAsFactors = F)

glimpse(adsl)

###-------------------------------------------------------------------------------------
#Q1. Convert all character variable types to factors. Use `glimpse(adsl)` to confirm your changes. 
###--------------------------------------------------------------------------------------

###-------------------------------------------------------------------------------------
#Q2. Group the `AGE` variable into buckets of 10 years (e.g. 20-29, ..., 50-59), and order them accordingly. 
#The transformed `AGE` variable should be an ordered factor.
###-------------------------------------------------------------------------------------

###-------------------------------------------------------------------------------------
#Q3. There were some input mistakes in the `COUNTRY` field. `EU` should be modified to `GERMANY`, and `AMERICA` changed to `USA`. 
###-------------------------------------------------------------------------------------

###-------------------------------------------------------------------------------------
#Q4. Sort the `COUNTRY` levels according to their population size, from smallest to largest.
###-------------------------------------------------------------------------------------

###-------------------------------------------------------------------------------------
#Q5. Combine all of questions 1-4 into one step.
###-------------------------------------------------------------------------------------

