library(tidyverse)
library(readxl)
library(rvest)

#######################Cleaning World Population############################################

World_pop <- read_excel('data-raw/World_Population.xlsx',
                        range = 'A17:BZ306')
WorldPopulation <- World_pop %>% select(3,6,"1950":"2020")%>%
  slice(-1*1:17)%>% rename(
    CountryName ='Region, subregion, country or area *'
  ) %>% filter(Type =='Country/Area')%>%
  select(-Type) %>% mutate_at(vars(matches( paste(1950:2020))),
                              as.numeric)

# Save the data frame to the data/ directory
usethis::use_data(WorldPopulation,overwrite = T)
