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

# Plot the mean earnings 10 years after enrollment for Level 1 institutions as the Y-axis against PCT_WHITE Plot 1:
cs %>% 
  filter(ICLEVEL == 1) %>%  
  ggplot(aes(y = MN_EARN_WNE_P10, x = PCT_WHITE)) +
  geom_point()+
  geom_smooth(method = "loess",color='red') +
  labs(y ="mean earnings level 1", x = "PCT_WHITE")+
  scale_y_log10()+
  theme_classic() -> plot1
plot1

# Plot the mean earnings 10 years after enrollment for Level 1 institutions as the Y-axis against FEMALE Plot 2:
cs %>% 
  filter(ICLEVEL == 1) %>%  
  ggplot(aes(y= MN_EARN_WNE_P10, x = FEMALE)) +
  geom_point() +
  geom_smooth(method = "loess",color='red') +
  labs(y = "mean earnings level 1", x = "FEMALE")+
  scale_y_log10()+
  theme_classic() -> plot2
plot2

# Interpretation: 
# plot1 for level 1 institution, when PCT_WHITE is around 75~90, the mean earnings are around 30000~50000. 
# Most of the dots are highly densed in this range. 
# Also, the loess line shows that when PCT_WHITE increases until 75, meaning earnings also increases, however, after PCT_WHITE is 75, the loess line slightly decreases. 

# plot2 for level 1 institution, the most of the dots are densed around when FEMALE students are around 0.50 ~0.75. 
# When x-axis FEMALE is around 0.50~0.75, then mean earnings are around 50000. 
# This indicates that when the university is 4-year institution with 'Share of Female students' 0.50~0.75, then the mean earnings 10 years after is around 50000. 
# Furthermore, the loess line is almost horizontal to the x-axis, which indicates that regardless of the 'Share of Female students' value, mean of earnings after 10 years will be around 50000.

# Create a scatter plot of the mean earnings 10 years after enrollment (Y) axis) compared to the median earnings 10 years after enrollment (X axis) using log scales for both.  
ggplot(data = cs, mapping = aes(y = MN_EARN_WNE_P10, x = MD_EARN_WNE_P10)) +
  geom_point()+
  scale_y_log10()+
  scale_x_log10() +
  labs(y ="MN_EARN_WNE_P10", x = "MD_EARN_WNE_P10")+
  theme_classic()+
  geom_abline(color = "blue", size = 2.0)

# Interpretation: Above graph shows that MD_EARN_WNE_P10 and MN_EARN_WNE_P10 are strong, and positively linearly related. 
# They are showing strong correlation since the dots are well aligned with the abline that is blue. This indicates that when the median earnings 10 year after enrollment is high, then mean earnings 10 years after enrollment is also high.

# Compute a ranking of level 1 universities based on the ratio of mean earnings 10 years after enrollment compared to median graduation debt.   
# Identify the top 5 best (highest ROI should be #1 ) and the bottom 5 worst? 
# What is American University's rank and ROI? 

cs %>% 
  filter(ICLEVEL == 1) -> cs_1
# RATIO
cs_1$RATIO <- cs_1$MN_EARN_WNE_P10/cs_1$GRAD_DEBT_MDN
# Top 5 best
cs_1 %>% 
  arrange(desc(RATIO)) %>% 
  top_n(5) %>%  
  select(INSTNM, RATIO) -> ratio_top_5
ratio_top_5
# Bottom 5 worst
cs_1 %>% 
  arrange(RATIO) %>% 
  head(5) %>%  
  select(INSTNM, RATIO) -> ration_bottom_5
ration_bottom_5
# What is American University's ROI? 
cs_1 %>% 
  filter(INSTNM == "American University") %>%  
  select(RATIO) -> AU_ROI
AU_ROI
# What is American University's Rank? 
cs_1 %>% 
  arrange(desc(RATIO)) %>%
  mutate(rank = row_number()) %>%  
  filter(INSTNM == "American University") %>% 
  select("rank") -> AU_RANK
AU_RANK


# World bank data analysis
# Use relative paths and a readr function to load these files into four tibbles.  
life_expectancy <- read_csv("../data/life_exp.csv")
fertility <- read_csv("../data/fertility.csv")
population <- read_csv('../data/population.csv')
country <- read_csv('../data/country.csv')


# 2. These data are messy. The observational units in `fert`, `life`, and `pop` are locations in space-time (e.g. Aruba in 2017). Recall tidy data should have one observational unit per row.  
# - Use dplyr 1.0 functions to tidy these three tibbles and save the updated data frames.
# - Use an approach where the tidying function also ensures the variable for `year` is a numeric.  
# In order to tidy datasets like these messy, I have to "gather" those columns into a new pair of variables.
population %>%  
  gather(colnames(population)[3:61], key = "year", value = "population") -> population_tidy

life_expectancy %>%  
  gather(colnames(life_expectancy)[3:61], key = "year", value = "life_expectancy") -> life_expectancy_tidy

fertility %>%  
  gather(colnames(life_expectancy)[3:61], key = "year", value = "fertility")  -> fertility_tidy

# correct data type
population_tidy$year <- readr::parse_number(population_tidy$year)

life_expectancy_tidy$year <- readr::parse_number(life_expectancy_tidy$year)

fertility_tidy$year <- readr::parse_number(fertility_tidy$year)

# Use dplyr functions to combine the three tibbles into one and save to a new tibble which includes the fertility rate, population, and life expectancy in each year as well as the region for each country.
full_join(population_tidy, life_expectancy_tidy, by = c("Country Name","Country Code", "year"))-> pop_life
full_join(pop_life, fertility_tidy, by = c("Country Name","Country Code", "year")) -> pop_life_fert
full_join(pop_life_fert, country, by = "Country Code") -> pop_life_fert_country

# Make a scatterplot of fertility rate vs life expectancy, color-coding by region and annotating size by the population.  
# Include only the years 1960, 1970, 1980, 1990, 2000, and 2010. 
# Facet by these years.
pop_life_fert_country %>%  
  drop_na() %>% 
  filter(year == "1960"|year == "1970"|year == "1980"|year == "1990"|year == "2000"|year == "2010") %>%  
  ggplot(aes(life_expectancy, fertility, color = Region))+
  geom_point(aes(size = population))+
  facet_wrap(. ~year)+ 
  ggtitle("Changes by Region across Decades \nWorld Bank Data") +
  ylab("Fertility Rate")+
  xlab("Life Expectancy")+
  scale_color_viridis(discrete = TRUE, option = "D") +
  scale_fill_viridis(discrete = TRUE) 

# Interpretation: Throughout the years 1960, 1970, ...2010, in "Sub-Saharan Africa", Life Expectancy is very low and fertility rate is very high, in contrast, areas in "East Asia & Pacific" and "Europe & Central Asia", "North America" are having Life Expectancy to be very high and Fertility Rate is very low. 
# Furthermore, "South Asia", "Latin America& Carribbean", "Middle East& North Africa" are in between the previous two analysis. 

# Calculate the total population for each region for each year.  
# Exclude 2018.  
# Make a line plot of year versus total population, color-coding by region and using a log scale.
# Your final plot should look like this:
pop_life_fert_country %>%  
  filter(year != 2018)  %>%  
  group_by(year, Region) %>%  
  drop_na() %>% 
  summarize(total = sum(population)) %>%  
  ggplot(aes(x=year,y=total, group = Region))+
  geom_line(aes(colour=Region)) +
  ggtitle("Population by Region") +
  xlab("Years")+
  ylab("Total Population (Log scale)")+
  scale_y_log10()+
  scale_x_discrete(limit = c(1960, 1980, 2000)) +
  theme_clean() +
  scale_color_brewer(palette="Dark2")

# Interpretation: Since the x-axis is same for all regions which is years(from 1960 to 2017), so I have to consider only y-axis to find out the fastest growing regions. When the difference between the starting point of the y-value and the last point of the y-value is the biggest among 7 regions, then that region is the fastest growing region. But I have to carefully see the y-scale since I did y scale log.Therefore, the regions where the differences seems to be greatest here is "East Asia and the Pacific", indicating thatthe fastest growing region is East Asia & Pacific. 

# Make a bar plot of population vs region for the year 2010.  
# Order the bars on the $y$-axis in **decreasing** order of population. 
# Your final plot should look like this:
pop_life_fert_country %>% 
  drop_na() %>% 
  filter(year == 2010) %>%  
  select(Region, population) %>%  
  ggplot(aes(x = reorder(Region, -population,sum), y = population/1000000)) + 
  geom_bar(stat = "identity", fill = '#0000FF') +
  coord_flip()+
  theme_bw() +
  labs(x = NULL, y = "Total Population(in Millions)", title = "2010 Population by Region")




