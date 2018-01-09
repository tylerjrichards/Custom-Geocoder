suppressMessages(library(plumber))
suppressMessages(library(dbplyr))
suppressMessages(library(RSQLite))
suppressMessages(library(dplyr))

US_db <- src_sqlite("US_Geocoding.db", create = TRUE)

#* @get /geocode
geocode <- function(location, state){
  suppressMessages(library(dplyr))
  state <- gsub("\"", "", state)
  state = paste(state, "_data", sep = "")
  state_db <- tbl(US_db, state)
  Addresses = as.data.frame(select(state_db, Address, Long, Lat, State))
  long = Addresses$Long
  long
  lat = Addresses$Lat
  result = c(long, lat, state)
  result
}
