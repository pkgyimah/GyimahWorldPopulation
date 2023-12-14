# Unit Testing for World Population Data Validation
test_that('Check if the country name provided by the user exists within the World Population dataset.', {
  expect_error(CountryPopulation('Gyimah'))
})
