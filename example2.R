
#exercise from https://miniature-bassoon-eeff7f7b.pages.github.io/week01-exercise.html#/week-1-exercise

#WEEK1

library(dplyr)

set.seed(8083)

adsl <- data.frame(SUBJIDN  = 1:200,
                   SEX      = sample(c('M','F', NA), 200, replace = T, prob = c(.8,.15,.05)),
                   AGE      = runif(200, min=18, max=65) %>% round(),
                   TRTP     = sample(c('DRUG','PLACEBO'), 200, replace = T),
                   SAFFL    = sample(c('Y','N', NA), 200, replace = T, prob = c(.9,.07,.03)),
                   COUNTRY  = sample(c('USA','INDIA','EU','CHINA'), 200, replace = T),
                   stringsAsFactors = F)


#2. Write a select query that chooses all columns in `adsl` that start with "S" or end with "Y".
 
selected_columns <- adsl %>%
  select(starts_with("S")|ends_with("Y")) 
#or
selected_columns <- adsl %>%
  select(matches("^S|Y$"))

#3. Create a new data frame that contains only subjects from USA or INDIA, older than 60 in the safety population. 

new_data <- adsl %>%
  filter(SAFFL == "Y" & AGE > 60 & COUNTRY %in% c("USA", "INDIA")) 

library(haven)

# set path
swan_path <- "\\\\by-swanPRD\\swan\\root\\bhc\\2927088\\21607\\stat\\main01\\dev\\analysis\\data\\"
swan_path1 <- "P:\\DFS1\\swan_on_prod\\root\\bhc\\2927088\\21607\\stat\\main01\\dev\\analysis\\data\\"

# read in adsl.sas7bdat using read_sas() from haven
adsl123 <- haven::read_sas(paste0(swan_path,"adsl.sas7bdat"))

#4. Use adsl to create a new data frame that consists of numeric variables only.

adsl %>%
  select(where(is.numeric)) 

#5. Compute individual frequencies for the COUNTRY and SEX variables.

X <- table(adsl$COUNTRY) 
#or
adsl %>%
  count(SEX) 

#6. Compute a cross-tabulation for COUNTRY and SEX while removing any rows where COUNTRY or SEX are NA.

subset_data <- adsl[complete.cases(adsl$COUNTRY, adsl$SEX), ]

# Compute cross-tabulation for COUNTRY and SEX
cross_tab <- as.data.frame(table(subset_data$COUNTRY, subset_data$SEX))

#7. Compute the frequency of SAFFL.
#a.Request that frequencies are sorted from highest to lowest.

# Compute the frequency of SAFFL
saffl_frequency <- table(adsl$SAFFL)

# Convert the result to a data frame and sort by frequency in descending order
saffl_frequency_df <- as.data.frame(saffl_frequency)
saffl_frequency_df <- saffl_frequency_df[order(-saffl_frequency_df$Freq), ]

#How might you add the percentages with your frequencies for SAFFL? Ensure your final answer is multiplied by 100.

# Calculate percentages
total_obs <- sum(saffl_frequency_df$Freq)
saffl_frequency_df$Percentage <- (saffl_frequency_df$Freq / total_obs) * 100