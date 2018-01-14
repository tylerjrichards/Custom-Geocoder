suppressMessages(library(here))
library(data.table)
library(dbplyr)
suppressMessages(library(dplyr))
suppressMessages(library(RSQLite))
setwd(here())


#steps here are to create a database for each state we're worries about and then call that database in the api
#for now, we're going to use the google sheets package for where we get our data
#a few reasons for this: easy to update and share, and works like a spreadsheet
#additionally, with google sheets you can give different people partial access to edit without giving them full access

#Can access by name or by link, the googlesheets package will sign you in and make a gitignore file for your project
#by name
library(googlesheets)
#by link
Colorado_url <- "https://docs.google.com/spreadsheets/d/19l0yoBkS_NscBbKG4vg92OLAex5K_zIieRfoc44OGIM/edit?usp=sharing"
Colorado <-Colorado_url %>% 
  gs_url()

Colorado_data <- Colo`rado %>% 
  gs_read(ws = "Address_errors")

#Or we can do the same thing by name
Colorado <- gs_title("Colorado")
Colorado_data <- Colorado %>% 
  gs_read(ws = "Address_errors")

#Now that we have the data, we need to create or update a database
#we're going to create a database called US Geocoding and then add a table for each google sheet spreadsheet that we have
#after we've done that, we can write new functions to update the database and add rows
#we'll start with creating a new database

US_dat <- src_sqlite("US_Geocoding.db", create = TRUE)



#now let's add our googlesheets data to the database
copy_to(US_dat, Colorado_data, temporary = FALSE)

#and that's how we create and update a database in R
#the reason why we do this is because we want to create a step inbetween editing a googlesheet and returning different values from our geocoding API



