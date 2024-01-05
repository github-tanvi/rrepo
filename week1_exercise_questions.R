## Week 1: Exercise

To complete the following exercises, you will need to copy and paste the code below into your R Studio session. This should create a data frame named `adsl` in your environment. Please verify this before moving on.

library(dplyr)

set.seed(8083)

adsl <- data.frame(SUBJIDN  = 1:200,
                   SEX      = sample(c('M','F', NA), 200, replace = T, prob = c(.8,.15,.05)),
                   AGE      = runif(200, min=18, max=65) %>% round(),
                   TRTP     = sample(c('DRUG','PLACEBO'), 200, replace = T),
                   SAFFL    = sample(c('Y','N', NA), 200, replace = T, prob = c(.9,.07,.03)),
                   COUNTRY  = sample(c('USA','INDIA','EU','CHINA'), 200, replace = T),
                   stringsAsFactors = F)
  
1. Examine the structure of the code used to create `adsl`. In R, it’s useful to be able to simulate data on the fly in order to test a new package or function. Type `?runif` and `?sample` at the prompt to learn about these function arguments. Can you describe, in words, how AGE and SAFFL are simulated?
  
2. Write a select query that chooses all columns in `adsl` that start with "S" or end with "Y".

3. Create a new data frame that contains only subjects from USA or INDIA, older than 60 in the safety population. 

## Week 1: Exercise - bring your own study (local R studio) 


library(haven)

adsl <- read_sas("P:/swan/root/bhc/2927088/21607/stat/main01/dev/analysis/data/adsl.sas7bdat") # please note the / used here


<br>
  1. Make changes to the data path above to load the `adsl` dataset from your own study. This may take a while depending on the connection and dataset size. 

2. Write a select query that chooses all columns in `adsl` that start with "TRT" or end with "FL"

3. Create a new data frame that contains only subjects from USA or INDIA, older than 60 in the safety population. 