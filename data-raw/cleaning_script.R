library(tidyverse)
library(readxl)
library(rvest)
#####################Cleaning World Cup#################################################
url <- "https://en.wikipedia.org/wiki/FIFA_World_Cup"
page <- read_html(url)
table.worldcup <- page %>%
  html_nodes('table') %>%.[[4]] %>%
  html_table(header=F, fill=TRUE)

table.worldcup1 <- table.worldcup %>% slice(-1 * 1:2) %>%
  select(X1,X2,X5,X4,X6)%>%
  rename(Year=X1,
         Host =X2,
         Matches=X5,
         Totalattendance=X4,
         Averageattendance=X6)

World_Cup <- table.worldcup1 %>%
  mutate_at(vars(matches('Year')),factor)%>%
  mutate_at(vars(matches('Average')),
            str_remove_all,',')%>%
  mutate_at(vars(matches('Average')),
            as.numeric) %>%
  mutate_at(vars(matches('Total')),
            str_remove_all,',') %>% drop_na() %>%
  filter(!str_detect(Year, pattern='Overall' ))


usethis::use_data(World_Cup,overwrite = T)

