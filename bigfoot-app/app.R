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
      value = "sightings",
      h3(id = "nav_title", "Sightings"),
      sightings_ui(id = "sightings")
    )
  )
)

server <- function(input, output) {
  sightings_server(id = "sightings", parent = session)
}

shinyApp(ui = ui, server = server)