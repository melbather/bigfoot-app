# Libraries --------------------------------------------------------------------
library(shiny)
library(ggplot2)
library(dplyr)
library(stringr)
library(leaflet)
library(tidyr)
library(gfonts)
library(rvest)
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


