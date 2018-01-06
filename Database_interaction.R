suppressMessages(library(here))
library(data.table)
library(dbplyr)
suppressMessages(library(dplyr))
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

Colorado_data <- Colorado %>% 
  gs_read(ws = "Address_errors")

#Or we can do the same thing by name
Colorado <- gs_title("Colorado")
Colorado_data <- Colorado %>% 
  gs_read(ws = "Address_errors")

#Now that we have the data, we need to create or update a database
#we'll start with creating a new database

Colorado_database <- src_sqlite("Colorado.db", create = TRUE)

copy_to(Colorado_database, Colorado_data, temporary = FALSE)

src_tbls(Colorado_database)
