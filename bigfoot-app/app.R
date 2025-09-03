# Read in modules
source("global.R")

ui <- fluidPage(
  tags$head(
    includeCSS("www/style.css")
  ),
  # Navigation
  tabBox(
    width = 12,
    id = "primary_box",
    tabPanel(
      value = "sightings_map",
      h3(id = "nav_title", "Sightings Map"),
      sightings_map_ui(id = "sightings_map")
    )
  )
)

server <- function(input, output) {
  sightings_map_server(id = "sightings_map", parent = session)
}

shinyApp(ui = ui, server = server)