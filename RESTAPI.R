



#* @get /geocode
geocode <- function(location, state){
  suppressMessages(library(dplyr))
  
  Colorado <- tbl(US_db, "Colorado_data")
  Addresses = as.data.frame(select(Colorado, Address, Long, Lat, State))
  long = Addresses$Long
  long
  result = c(long, state)
  result
}
