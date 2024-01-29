#week 5 exercise

#upload required datasets from any of your study which you have access to
#helping notes: check data manipulations functions, data types and formats, data merging topic from previous workshops

# load following packages or install first if not installed earlier------------------------------------------
library(tidyverse) # data manipulation
library(haven)     # read SAS xport
library(lubridate)
library(dplyr)
library(Hmisc)

###-------------------------------------------------------------------------------------
### ADSL derivation --------------------------------------------------------------------
###-------------------------------------------------------------------------------------

###-------------------------------------------------------------------------------------
#Q1. from dm, please derive variables like AGEGR1 (<65, 65-70, >70), AGEGR1N, RACEN, TRT01P(ARM), TRT01PN, TRT01A(ACTARM), TRT01AN, ITTFL('Y' if ARM is not missing)
###--------------------------------------------------------------------------------------

###-------------------------------------------------------------------------------------
#Q2. from vs, please derive variables like WEIGHTBL(Weight (kg) at Baseline), HEIGHTBL (Height (cm) at Baseline)
## BMIBL(Body Mass Index (kg/m2) at Baseline), BMIGR1 (Pooled BMI Group 1: <25, >=25)
###-------------------------------------------------------------------------------------

###-------------------------------------------------------------------------------------
#Q3. from ex, please derive variables like TRTSDT, TRTEDT
###-------------------------------------------------------------------------------------

###-------------------------------------------------------------------------------------
#Q4. from ds, please derive variables like EOSSTT (end of study status, ONGOING if no DS record, COMPLETED if DSDECOD = COMPLETED,
## otherwise DISCONTINUED)
###-------------------------------------------------------------------------------------