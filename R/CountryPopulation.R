
#'A function utilizing the WorldPopulation data.frame to create a graphical representation depicting the population trend of any chosen country across time.
#'
#'
#' @param  country Country name
#' @param  title optional. Provide a title for the graph
#' @return return the graph
#' @examples
#' CountryPopulation('Ghana')
#' CountryPopulation('Ghana', 'Time series data representing the population of Ghana.') Use the title instead of the Country name
#' @export
CountryPopulation <- function(country,title=NULL){
  #If the user does not provide a title for the graph, use the country name instead
  cleaned_string <- country
  get_country <- WorldPopulation %>%
    filter(CountryName == cleaned_string)
  if(nrow(get_country)==0){
    stop('Country name  does not exist. Please check if the country name is correct.')
  }
  pivot_dt <- get_country %>%pivot_longer(
    paste(1950:2020),
    names_to  = 'Year',
    values_to = 'Population') %>%mutate_at(vars(matches('Year')),
                                           make_date)%>%
    mutate_at(vars(matches('Year')),
              lubridate::year)%>% select(-CountryName)


  P1 <- ggplot(pivot_dt, aes(x = Year, y = Population)) +
    geom_line() +
    labs(x = "Year", y = "Population", title =if(is.null(title)) cleaned_string else title)

  return(P1)
}
