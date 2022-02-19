hw_01-jaehee99 created by GitHub Classroom

# Tidyverse

## College Scorecard dataset
###### "college_score_200601.csv", a subset of the data in the [College Scorecard](https://collegescorecard.ed.gov/data/) database as of June 1, 2020. These data contain information on colleges in the United States. The variables include:
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



## World Bank Data dataset

###### The World Bank provides loans to countries with the goal of reducing poverty. The dataframes in the data folder were taken from the public data repositories of the World Bank.

- country.csv: Contains information on the countries in the data set. 
  - The variables are:
  - `Country_Code`: A three-letter code for the country. Note not all rows are countries; some are regions.
  - `Region`: The region of the country.
  - `IncomeGroup`: Either `"High income"`, `"Upper middle income"`, `"Lower middle income"`, or `"Low income"`.
  - `TableName`: The full name of the country.  

- fertility.csv: Contains the fertility rate information for each country for each year. 
  + For the variables `1960` to `2017`, the values in the cells represent the fertility rate in total births per woman for that year. 
  + Total fertility rate represents the number of children that would be born to a woman if she were to live to the end of her  childbearing years and bear children in accordance with age-specific fertility rates of the specified year.   

- life_exp.csv: Contains the life expectancy information for each country for each year. 
  + For the variables `1960` to `2017`, the values in the cells represent life expectancy at birth in years for the given year. 
  + Life expectancy at birth indicates the number of years a newborn infant would live if prevailing patterns of mortality at the time of its birth were to stay the same throughout its life.  

- population.csv: Contains the population information for each country. 
  + For the variables `1960` to `2017`, the values in the cells represent the total population in number of people for the given year. 
  + Total population is based on the de facto definition of population, which counts all residents regardless of legal status or citizenship. The values shown are midyear estimates.
