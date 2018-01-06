



#* @get /geocode
geocode <- function(location){
  suppressMessages(library(dplyr))
  Colorado <- tbl(US_db, "Colorado_data")
  Addresses = as.data.frame(select(Colorado, Address, Long, Lat, State))
  state = "Colorado"
  long = Addresses$Long
  long
  result = c(long, state)
  result
}
