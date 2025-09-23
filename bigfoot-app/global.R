# Libraries --------------------------------------------------------------------
library(shiny)
library(dplyr)
library(stringr)
library(leaflet)
library(ggplot2)
library(plotly)
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
years <- as.numeric(sightings_data$Year)
year_range <- range(years, na.rm=TRUE)

lowest_decade <- floor(year_range[1]/10)*10
highest_decade <- floor(year_range[2]/10)*10

all_decades <- seq(lowest_decade, highest_decade, by = 10)


