
#* @get /geocode
geocode <- function(location, state){
  if(location == "USAFA"){
    long = "38.9983? N"
  }
  
  long
  result = c(long, state)
  result
}
