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

# Create a plot that shows the relationship between average faculty salary with the mean earnings of students ten years after initial enrollment. 
ggplot(data = cs, mapping = aes(y = AVGFACSAL, x = MN_EARN_WNE_P10)) +
  geom_point()+
  geom_smooth() +
  labs(y ="AVGFACSAL", x = "MN_EARN_WNE_P10")+
  theme_classic()

# Interpretation: 
# MN_EARN_WNE_P10 and AVGFASCAL are strongly and positively correlated until when MN_EARN_WNE_P10 is 125000. 
# Most of the points are densed and aligned well with the loess_line before when MN_EARN_WNE_P10 is 125000. 
# This indicates that when MN_EARN_WNE_P10 increases, then AVGFASAL increases as well until MN_EARN_WNE_P10 is 125000. 
# However, the line starts to decrease because of the 'outliers'. 
# Overall, I can say that the higher the mean earnings of students, the average faculty salary was very high. 

# Create a box plot that shows the level of the institution to be associated with the mean earnings of students ten years after enrollment 
ggplot(data = cs, aes(y = log(MN_EARN_WNE_P10), x = factor(ICLEVEL))) +
  geom_boxplot(alpha=0.2)+
  xlab("Level of Institution")+
  ylab("Log of Mean Earnings")+
  ggtitle("Mean Earnings 10 Years after Enrollment by Level of Institution")+
  theme_bw()
# Interpretation: 
# Level of institution (1 = 4-year, 2 = 2-year, 3 = less than 2-year)
# The median of institution level 1 is the highest among three of the institution levels. This indicates that students who graduated 4-year university have a highest median earnings in the future 10 years among three levels. 
# Furthermore, level 2 institution have higher median than level 3. Therefore, not all, but most of the people who graduated 4-year institution have higher earnings than people who graduated 2-years institution or less than 2-year. 
# Also, students who graduated 2-years institution have higher earning than less than 2-year institution. 


