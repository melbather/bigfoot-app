# Libraries --------------------------------------------------------------------
library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(dplyr)
library(stringr)
library(leaflet)
library(sf)
library(tidyr)
# Web scraping libraries
library(rvest)
library(httr2)
library(jsonlite)
library(purrr)
library(readr)
library(xml2)

# Scrape data from https://reports.woodape.org/data/ ---------------------------
BASE_URL <- "https://reports.woodape.org/data/"

page <- read_html(BASE_URL)

sightings_data <- html_table(page)[[1]] |> 
  filter(Case != "Case") |> 
  separate_wider_delim(`Lat/Lon`, ",", 
                       names = c("latitude", "longitude")) |> 
  mutate(latitude = as.numeric(latitude),
         longitude = as.numeric(longitude))
