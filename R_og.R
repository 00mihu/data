install.packages("dplyr")
install.packages("tidyverse")
install.packages("jsonlite")
library(httr)
library(tidyverse)
library(dplyr)
library(jsonlite)

GET("https://icanhazdadjoke.com")

result <- GET("https://icanhazdadjoke.com", accept("text/plain"))
#JSON#  result <- GET("https://icanhazdadjokes.com", accept("application/json"))
result
content(result)

result <- GET("https://icanhazdadjoke.com/search?term=dog", accept("application/json"))
result
content(result)

result <- GET("https://icanhazdadjoke.com/search?term=cats", 
              accept("application/json"))
bad_jokes <- result |>
  content(as="text") |>
  fromJSON() 

%>%
  .$results

GET("https://icanhazdadjoke.com/search?term=cats", 
    accept("application/json")),
    user_agent("httr")) %>%
  content(as="text") %>%
  fromJSON() %>%
.$results
#%>%
  #content
#result
#content(result)


###Danmarks Statisitic

#endpoints
#https://api.statbank.dk/v1/subjects
#https://api.statbank.dk/v1/tables
#https://api.statbank.dk/v1/tableinfo
#https://api.statbank.dk/v1/data

subjects_endpoint <- "https://api.statbank.dk/v1/subjects"

subject_body <- list(lang="en", rectusive = FALSE, 
     includeTables = FALSE, subjects = NULL)

subjects <- POST(subjects_endpoint, body = subjects_body, encode = "json")
subjects %>%
  content(as="text") %>%
  fromJSON()

#subjects_endpoint <- "https://api.statbank.dk/v1/subjects"

subject_body <- list(lang="en", rectusive = FALSE, 
                     includeTables = FALSE, subjects = I(3401))

subjects <- POST(subjects_endpoint, body = subjects_body, encode = "json")
sub_subjects <- subjects %>%
  content(as="text") %>%
  fromJSON()

table_endpoint <- "https://api.statbank.dk/v1/tables"
#code missed table_body <- sub

table_body <- list(lang = "da", subjects = I(20021))
tabeller <- POST(table_endpoint, bdy = table_body, encode = "json")

tabeller %>%
  content(as="text")
fromJSON() %>%
  view()

data_endpoint <- "https://api.statbank.dk/v1/data"
data_variables <- list(list(code = "OMRADE", values = I( "A")))
  list(code = "CIVILSTAND", values = I(c("U, G"))),
  list(code = tid, values = I("A"))
  
data_body <- list(table = "FOLKIA", lang = "da", format = "CSV", variables = data_variables)
befolknings_data <- POST(data_endpoint, body = data_body, encode = "json")
befolknings_data %>%
  content(type = "text")%>%
  read.csv2() %>%
  view()

install.packages("danstat")
library(danstat)
danstat:
