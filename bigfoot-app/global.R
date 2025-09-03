# Libraries --------------------------------------------------------------------
library(shiny)
library(dplyr)
library(stringr)
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

dat <- html_table(page)[[1]] |> 
  filter(Case != "Case")
