
#WEEK2

library(dplyr)

set.seed(8083)

adsl <- data.frame(SUBJIDN  = 1:200,
                   SEX      = sample(c('M','F', NA), 200, replace = T, prob = c(.8,.15,.05)),
                   AGE      = runif(200, min=18, max=65) %>% round(),
                   TRTP     = sample(c('DRUG','PLACEBO'), 200, replace = T),
                   SAFFL    = sample(c('Y','N', NA), 200, replace = T, prob = c(.9,.07,.03)),
                   COUNTRY  = sample(c('USA','INDIA','EU','CHINA'), 200, replace = T),
                   stringsAsFactors = F)


#1. Use adsl to create a new data frame that consists of numeric variables only.

adsl %>%
  select(where(is.numeric)) 

#2. Compute individual frequencies for the COUNTRY and SEX variables.

X <- table(adsl$COUNTRY) 
#or
adsl %>%
  count(SEX) 

#3. Compute a cross-tabulation for COUNTRY and SEX while removing any rows where COUNTRY or SEX are NA.

subset_data <- adsl[complete.cases(adsl$COUNTRY, adsl$SEX), ]

#4 Compute cross-tabulation for COUNTRY and SEX
cross_tab <- as.data.frame(table(subset_data$COUNTRY, subset_data$SEX))

#5. Compute the frequency of SAFFL.
#a.Request that frequencies are sorted from highest to lowest.

# Compute the frequency of SAFFL
saffl_frequency <- table(adsl$SAFFL)

# Convert the result to a data frame and sort by frequency in descending order
saffl_frequency_df <- as.data.frame(saffl_frequency)
saffl_frequency_df <- saffl_frequency_df[order(-saffl_frequency_df$Freq), ]

#b.How might you add the percentages with your frequencies for SAFFL? Ensure your final answer is multiplied by 100.

# Calculate percentages
total_obs <- sum(saffl_frequency_df$Freq)
saffl_frequency_df$Percentage <- (saffl_frequency_df$Freq / total_obs) * 100