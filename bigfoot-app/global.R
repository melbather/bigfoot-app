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
library(gfonts)
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

# Get decades in data ----------------------------------------------------------
lowest_decade <- min(as.numeric(sightings_data$Year), 
                     na.rm = TRUE) - min(as.numeric(sightings_data$Year), 
                                         na.rm = TRUE)%%10
highest_decade <- max(as.numeric(sightings_data$Year), 
                      na.rm = TRUE) - max(as.numeric(sightings_data$Year), 
                                          na.rm = TRUE)%%10
all_decades <- seq(lowest_decade, highest_decade, by = 10)


