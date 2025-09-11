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
      fluidRow(
        column(12,
               wellPanel(
                 selectInput("test",
                             "Test",
                             choices = 1:5)
               )
        )
      ),
      div(style = "padding: 0px 0px; margin-top:-3em",
          fluidRow(
            column(12,
                   h3(htmlOutput("test2")),
                   br(),
                   leafletOutput("map"))
          )
      )
    )
  )
)

server <- function(input, output) {

  output$map <- renderLeaflet({
    leaflet(sightings_data) |>
      addTiles() |>
      addMarkers(lng = ~longitude, lat = ~latitude, popup = ~County)
  })
}

shinyApp(ui = ui, server = server)