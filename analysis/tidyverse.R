# College Scorecard
# "college_score_200601.csv", a subset of the data in the [College Scorecard](https://collegescorecard.ed.gov/data/) database as of June 1, 2020. These data contain information on colleges in the United States. The variables include:
- `UNITID` and `OPEID`: Identifiers for the colleges.
- `INSTNM`: Institution name
- `ADM_RATE`: The Admission Rate.
- `SAT_AVE`: Average SAT equivalent score of students admitted.
- `UGDS`: Enrollment of undergraduate certificate/degree-seeking students
- `COSTT4_A`: Average cost of attendance (academic year institutions)
- `AVGFACSAL`: Average faculty salary
- `GRAD_DEBT_MDN`: The median debt for students who have completed
- `AGE_ENTRY`: Average age of entry
- `ICLEVEL`: Level of institution (1 = 4-year, 2 = 2-year, 3 = less than 2-year).
- `MN_EARN_WNE_P10`: Mean earnings of students working and not enrolled 10 years after entry.
- `MD_EARN_WNE_P10`: Median earnings of students working and not enrolled 10 years after entry.
- `FEMALE`: Share of female students
- `PCT_WHITE`: Percent of the population from students' zip codes that is White, via Census data

# load packages 
library(tidyverse)
library(ggthemes)
library("viridis")     
library(RColorBrewer)
# Use a relative path and readr function to load data/college_score_200601.csv into a tibble
cs <- read_csv("../data/college_score_200601.csv")
head(cs)
str(cs)
ncol(cs) # 16 variables 
# 11 variables are type character when they should be numeric. 
# MN_EARN_WNE_P10, MD_EARN_WNE_P10, SAT_AVG, ADM_RATE, UGDS, COSTT4_A, AVGFACSAL, GRAD_DEBT_MDN,AGE_ENTRY,FEMALE, PCT_WHITE
# These are read in as type character because the numbers are inside Quotation(" "). 
# For example, 7 and "7" are different type. 
# I think computer will think 7 is numeric, however "7" will be recognized as character, since 7 is inside the quotation.

# use readr function to fix these variables to be numeric and save the updated tibble.
cs$MN_EARN_WNE_P10 <- readr::parse_number(cs$MN_EARN_WNE_P10) 
cs$MD_EARN_WNE_P10 <- readr::parse_number(cs$MD_EARN_WNE_P10)
cs$SAT_AVG <- readr::parse_number(cs$SAT_AVG)
cs$ADM_RATE <- readr::parse_number(cs$ADM_RATE)
cs$UGDS <- readr::parse_number(cs$UGDS)
cs$COSTT4_A <- readr::parse_number(cs$COSTT4_A)
cs$AVGFACSAL <- readr::parse_number(cs$AVGFACSAL)
cs$GRAD_DEBT_MDN <- readr::parse_number(cs$GRAD_DEBT_MDN)
cs$AGE_ENTRY <- readr::parse_number(cs$AGE_ENTRY)
cs$FEMALE <- readr::parse_number(cs$FEMALE)
cs$PCT_WHITE <- readr::parse_number(cs$PCT_WHITE)
# check 
str(cs)


4. How is average faculty salary associated the mean earnings of students ten years after initial enrollment? Create an appropriate plot and interpret the plot to justify your answer.
```{r}
ggplot(data = cs, mapping = aes(y = AVGFACSAL, x = MN_EARN_WNE_P10)) +
  geom_point()+
  geom_smooth() +
  labs(y ="AVGFACSAL", x = "MN_EARN_WNE_P10")+
  theme_classic()
```

