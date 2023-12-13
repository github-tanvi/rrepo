#install.packages("tidyverse")
#install.packages("haven")
#install.packages("Tplyr")
#install.packages("knitr")
#install.packages("survival")
#install.packages("xportr")
#install.packages("dplyr")    ## Dplyr Code for data manipulation
#install.packages("Hmisc")    ##Need this package to add Label

# load packages ------------------------------------------
library(tidyverse) # data manipulation
library(haven)     # read SAS xport
library(lubridate)
library(xportr)
library(dplyr)
library(Hmisc)


# load files from the phuse test data factory ------------------------------------------
dm <- haven::read_xpt(url("https://github.com/phuse-org/TestDataFactory/raw/main/Updated/TDF_SDTM/dm.xpt"))
ex <- haven::read_xpt(url("https://github.com/phuse-org/TestDataFactory/raw/main/Updated/TDF_SDTM/ex.xpt"))
vs <- haven::read_xpt(url("https://github.com/phuse-org/TestDataFactory/raw/main/Updated/TDF_SDTM/vs.xpt"))
ds <- haven::read_xpt(url("https://github.com/phuse-org/TestDataFactory/raw/main/Updated/TDF_SDTM/ds.xpt"))

###-------------------------------------------------------------------------------------
### ADSL derivation --------------------------------------------------------------------
###-------------------------------------------------------------------------------------


###-------------------------------------------------------------------------------------
## from dm, please derive variables like AGEGR1 (<65, 65-70, >70), AGEGR1N, RACEN, TRT01P(ARM), TRT01PN, TRT01A(ACTARM), TRT01AN, ITTFL('Y' if ARM is not missing)
###--------------------------------------------------------------------------------------

adsl_sa0 <- dm %>%
  #drop_na(DMDTC, DMDY) %>%  : to drop the complete missing row columns
  arrange(SUBJID) %>%
  select(-c(DMDTC, DMDY)) %>%
  mutate (AGEGR1N = case_when (AGE > 70  ~ 3, AGE >= 65 & AGE <= 70 ~ 2, AGE < 65 ~ 1)) %>%
  mutate (AGEGR1 = case_when (AGE > 70  ~ '70', AGE >= 65 & AGE <= 70 ~ '65-70', AGE < 65 ~ '<65')) %>%
  mutate (RACEN = case_when (RACE == 'AMERICAN INDIAN OR ALASKA NATIVE'  ~ 4,
                             RACE == 'ASIAN' ~ 3,
                             RACE == 'BLACK OR AFRICAN AMERICAN' ~ 2,
                             RACE == 'WHITE' ~ 1)) %>%
  mutate(ITTFL = case_when(ARMCD %in% c('Scrnfail', "Xan_Hi", "Xan_Lo", "Pbo")  ~ 'Y', ARMCD == " " ~ ' ')) %>%
  
  mutate(TRT01PN = case_when(ARMCD == 'Pbo'  ~ 0,
                             ARMCD %in% "Xan_Lo" ~ 1,
                             ARMCD %in% "Xan_Hi" ~ 2)) %>%
  mutate(TRT01P = case_when(ARMCD == 'Pbo'  ~ 'Placebo',
                            ARMCD %in% "Xan_Lo" ~ 'Xanomeline Low Dose',
                            ARMCD %in% "Xan_Hi" ~ 'Xanomeline High Dose')) %>%
  mutate(TRT01AN = case_when(ACTARMCD == 'Pbo'  ~ 0,
                             ACTARMCD %in% "Xan_Lo" ~ 1,
                             ACTARMCD %in% "Xan_Hi" ~ 2)) %>%
  mutate(TRT01A = case_when(ACTARMCD == 'Pbo'  ~ 'Placebo',
                            ACTARMCD %in% "Xan_Lo" ~ 'Xanomeline Low Dose',
                            ACTARMCD %in% "Xan_Hi" ~ 'Xanomeline High Dose'))



label(adsl_sa0$AGEGR1) <- "Age Group"         #add variable Label
label(adsl_sa0$AGEGR1N) <- "Age Group (N)"
label(adsl_sa0$RACEN) <- "Race (N)"
label(adsl_sa0$ITTFL) <- "Intent To Treat"
label(adsl_sa0$TRT01P) <- "Plan Treatment"
label(adsl_sa0$TRT01PN) <- "Plan Treatment (N)"
label(adsl_sa0$TRT01A) <- "Actual Treatment"
label(adsl_sa0$TRT01AN) <- "Actual Treatment (N)"

describe(adsl_sa0)         #print the description of the data

table(adsl_sa0$ARMCD)
table(adsl_sa0$ARM)

table(adsl_sa0$ACTARMCD)
table(adsl_sa0$ACTARM)
table(adsl_sa0$RACE)

attributes(adsl_sa0$ARMCD)

###-------------------------------------------------------------------------------------
## from vs, please derive variables like WEIGHTBL(Weight (kg) at Baseline), HEIGHTBL (Height (cm) at Baseline)
## BMIBL(Body Mass Index (kg/m2) at Baseline), BMIGR1 (Pooled BMI Group 1: <25, >=25)
###-------------------------------------------------------------------------------------

## Get the 1st record of the BASELINE as there is multiple record on same visit
vs_w <- vs %>%
  filter(VSTESTCD %in% "DIABP" & VISIT == "BASELINE") %>%
  select( c(USUBJID, VSTESTCD, VSSTRESC, VSORRESU))  %>%
  rename(BASEWEIGHT = VSSTRESC, WEIGHT=VSTESTCD, WEIGHT_unit=VSORRESU) %>%
  group_by(USUBJID) %>%
  arrange(USUBJID)  %>%
  filter(row_number()==1) %>%
  select(-c(WEIGHT))  #To drop this variable

# Drop 3rd,4th and 5th columns of the dataframe
# select(mydata,-c(3,4,5))

vs_h <- vs %>%
  filter(VSTESTCD %in% "HEIGHT" & VISIT == "SCREENING 1") %>%
  select( c(USUBJID, VSTESTCD, VSSTRESC, VSORRESU))  %>%
  rename(BASEHEIGHT = VSSTRESC, HEIGHT=VSTESTCD, HEIGHT_unit=VSORRESU) %>%
  select(-c(HEIGHT))


#To see the frequencies
table(vs$VSTESTCD)

#Merge adsl with vs data
adsl_sa1 <- full_join(adsl_sa0, vs_w, by=c("USUBJID"))
adsl_sa2 <- full_join(adsl_sa1, vs_h, by=c("USUBJID"))

adsl_sa3 <- adsl_sa2

#convert column 'a' from character to numeric
#df$a <- as.numeric(df$a)
adsl_sa3$BASEWEIGHT <- as.numeric(adsl_sa3$BASEWEIGHT)
adsl_sa3$BASEHEIGHT <- as.numeric(adsl_sa3$BASEHEIGHT)

#confirm class of numeric vector
class(adsl_sa3$BASEWEIGHT)
class(adsl_sa3$BASEHEIGHT)
# Print the data to the console
adsl_sa3

adsl_sa4 <- adsl_sa3 %>%
  mutate(BASEBMI = (BASEWEIGHT / (BASEHEIGHT*BASEHEIGHT))*10000)  %>%
  mutate (BMIGR1 = case_when (BASEBMI >=25  ~ '2', BASEBMI <= 25 ~ '1'))

label(adsl_sa4$BASEWEIGHT) <- "Baseline Weight"         #add variable Label
label(adsl_sa4$BASEHEIGHT) <- "Baseline Height"
label(adsl_sa4$BASEBMI) <- "Baseline BMI"
label(adsl_sa4$BMIGR1) <- "BMI Group"

###-------------------------------------------------------------------------------------
## from ex, please derive variables like TRTSDT, TRTEDT
###-------------------------------------------------------------------------------------

## Get the 1st record of the BASELINE as there is multiple record on same visit
ex_s <- ex %>%
  select(c(USUBJID, EXSEQ, EXTRT, EXDOSE, EXDOSU, VISITNUM, VISIT, EXSTDTC, EXSTDY)) %>%  #To keep this variable
  rename(TRTSDT=EXSTDTC) %>%
  group_by(USUBJID) %>%
  arrange(USUBJID)  %>%
  filter(row_number()==1)  %>%  #Choose the first treatment date
  select(-c(EXSEQ, EXTRT, EXDOSE, EXDOSU, VISITNUM))  #To drop this variable


#ex_s$TRTSDT_n <- as.numeric(ex_s$TRTSDT, format="%Y-%m-%d")

#convert day variable to date
#df$day <- as.Date(df$day, format="%Y-%m-%d")
#ex_s$EXSTDY <- as.Date(ex_s$EXSTDY, format="%Y-%m-%d")

# display DATA
#print(ex_s)
ex_s

ex_e <- ex %>%
  select(c(USUBJID, EXSEQ, EXTRT, EXDOSE, EXDOSU, VISITNUM, VISIT, EXENDTC)) %>%  #To keep this variable
  rename(TRTEDT=EXENDTC) %>%
  group_by(USUBJID) %>%
  #desc(USUBJID)  %>%
  arrange(USUBJID)  %>%
  filter(row_number()==3)  %>%  #Choose the last treatment date
  select(-c(EXSEQ, EXTRT, EXDOSE, EXDOSU, VISITNUM))  #To drop this variable

#ex_s$TRTSDT_x <- as.numeric(ex_s$TRTSDT)
#ex_1$TRTEDT <- as.numeric(ex_1$TRTEDT)
label(ex_s$TRTSDT) <- "Treatment Start Date"
label(ex_e$TRTEDT) <- "Treatment End Date"

ex_s1<- ex_s %>%
  select(c(USUBJID, TRTSDT))
ex_e1<- ex_e %>%
  select(c(USUBJID, TRTEDT))

#Merge adsl with ex data
adsl_sa5 <- full_join(adsl_sa4, ex_s1, by=c("USUBJID"))
adsl_sa6 <- full_join(adsl_sa5, ex_e1, by=c("USUBJID"))

###-------------------------------------------------------------------------------------
## from ds, please derive variables like EOSSTT (end of study status, ONGOING if no DS record, COMPLETED if DSDECOD = COMPLETED,
## otherwise DISCONTINUED)
###-------------------------------------------------------------------------------------

ds_1 <- ds %>%
  select(c(USUBJID, DSSEQ, DSTERM, DSDECOD, EPOCH, VISIT, DSSTDTC)) %>%  #To keep this variable
  group_by(USUBJID) %>%
  arrange(USUBJID)  %>%
  mutate (EOSSTT = case_when (DSDECOD == "COMPLETED"  ~ 'COMPLETED',
                              DSDECOD %in% c("ADVERSE EVENT","LACK OF EFFICACY", "FINAL LAB VISIT","FINAL RETRIEVAL VISIT",
                                             "PHYSICIAN DECISION","LOST TO FOLLOW-UP") ~ 'ONGOING',
                              DSDECOD %in% c("WITHDRAWAL BY SUBJECT" , "STUDY TERMINATED BY SPONSOR","SCREEN FAILURE",
                                             "DEATH","PROTOCOL DEVIATION") ~ 'DISCONTINUED'))


label(ds_1$EOSSTT) <- "End of Study Status"

ds_2 <- ds_1 %>%
  select(c(USUBJID, EOSSTT))

#Merge adsl with ds data
adsl_f2f <- full_join(adsl_sa6, ds_2, by=c("USUBJID"))


#### How to identift if subject is not in DS domain #####
#ds_2 <- ds_2 %>%
#distinct()

#adsl_f2f_test <- anti_join(ds_2, adsl_sa6,  by=c("USUBJID"))

#DSDECOD %in% ("WITHDRAWAL BY SUBJECT", "STUDY TERMINATED BY SPONSOR","SCREEN FAILURE")
