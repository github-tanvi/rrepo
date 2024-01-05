## Week 3: Exercise - 1

To complete the following exercises, you will need to copy and paste the code below into your R Studio session. This should create a data frame named `adsl` in your environment. 
Please verify this before moving onlibrary(tidyverse)

library(tidyverse)
set.seed(8083)

adsl <- data.frame(
  stringsAsFactors = FALSE,
  SUBJIDN = c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 10L),
  SEX = c("M", "F", NA , "F", "M", "M", "F", "M", "F", "M"),
  SEXN = c(1, 0, NA , 0, 1, 1, 0, 1, 0, 1),
  AGE = c(57, NA, 68, 50, 70, 36, 30, 52, 57, 19),
  CNTY = c("CHINA","INDIA","USA","USA",
           "CHINA","CHINA","CHINA","AUS","USA",NA),
  CNTYN = c("1","2","3","3",
            "1","1","1",NA,"3",NA),
  TRTP = c("DRUG","DRUG","PLACEBO","DRUG",
           "PLACEBO",NA,"PLACEBO","PLACEBO","PLACEBO",
           "PLACEBO"),
  TRTPN = c(1, 1, 1, NA, 0, 0, 0, 0, 0, 0),
  TRTSDT = c("2019-08-18","2022-07-04",
             "2022-07-30","2022-03-31","2022-01-25","2022-08-13",
             "2022-06-10","2022-05-20","2022-02-22","2022-01-19"),
  SAFFN = c(0L, 1L, 1L, 1L, 0L, 0L, 1L, 1L, 1L, 0L)
)
 
Q: In the dataset `adsl`, can you identify the country that has missing decode in `CNTYN` ?
  
  
## Week 3: Exercise - 2 

step 1> Create a dataset `big_n` from `adsl` and derive a new variable `"N"` with count of subjects in each treatment, include only `safety population`.

step 2> After `N` is derived, create a new variable `"PCT"` with percentage of subjects in each treatment.
[Hint: use `mutate()` to create new variable and `sum(N)` for denominator of percentage]

step 3> round `"PCT"` to 2 decimals using `round()`

step 4>create a new variable "N_PCT" by combining `N` and `PCT` and concatenate with `"%"` using `paste0()`

## Week 3: Exercise - 3

step 1> Create a dataset `desc_age_trt` from `adsl` with descriptive statistics - `n,Min,Max, Mean, Median, and SD` for `AGE` by `Treatment`, include `safety population` only. 
Note: Each statistic will be a new column. Try to round the decimals of each statistic as per our Global standard tables

step 2> Create new variable `Var` with value "Age"

step 3> Move the column Var to the first position in dataset (use `select()`)

