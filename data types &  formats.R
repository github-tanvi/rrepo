#data types

#understand the 5 types of data types
#change the data type for a variable
#add levels to the factor variable

library(dplyr)

set.seed(8083)

adsl <- data.frame(SUBJIDN  = 1:200,
                   names    = paste0("Person_", 1:200),
                   SEX      = sample(c('M','F', NA), 200, replace = T, prob = c(.8,.15,.05)),
                   AGE      = runif(200, min=18, max=65) %>% round(),
                   TRTP     = sample(c('DRUG','PLACEBO'), 200, replace = T),
                   WEIGHT   = rnorm(200, mean = 70, sd = 10), 
                   SAFFL    = sample(c('Y','N', NA), 200, replace = T, prob = c(.9,.07,.03)),
                   TRTSDT   = seq(as.Date("2022-01-01"), by = "1 day", length.out = 200),
                   COUNTRY  = sample(c('USA','INDIA','EU','CHINA'), 200, replace = T),
                   stringsAsFactors = F)

#1)names - character variable(normal text)
#2)sex - categorical variable and also represents ordinal data, we can call it as factor variable in order to get different levels
adsl$sex <- as.factor(adsl$sex)
levels(adsl$sex)
#3)age - numeric variable is a continuous variable but we want it to be a whole number, we call it as integer
adsl$age<- as.integer(adsl$age)
#4)weight -  any number between 2 whole number(continuous number), we can call it as numeric variable
#5)logical - age, which is of these are older than 23
adsl$old<- adsl$age >23
class(adsl$age)
str(adsl$age)
#)date - functions are in lubdridate package like mdy, dmy, ymd, month, day, year
#vector is a variable and dataframe is called as dataset. vector is a collection of data of same type.
#now look at their structures so that we can change to a different type as needed
str(adsl)

