# Read in files
source("global.R")

ui <- fluidPage(
  tags$head(
    includeCSS("www/style.css")
  ),
  titlePanel(div(id = "title",
                 img(src = "bigfoot-icon.png", height = "10%", width = "10%"), 
                 "USA Bigfoot Sightings Map",
                 img(src = "bigfoot-icon.png", height = "10%", width = "10%"))),
  sidebarLayout(
    sidebarPanel(
      selectInput("decade_filter",
                  "Select decade",
                  choices = c("All decades", paste0(all_decades, "s"))
        )),
    mainPanel(
      leafletOutput("map"))
    )
)

server <- function(input, output) {
  
  dat <- reactive({
    req(input$decade_filter)
    
    if (input$decade_filter == "All decades") {
      df <- sightings_data
    } else {
      decade <- as.numeric(str_remove(input$decade_filter, "s"))
      year_range <- decade:(decade+9)
      df <- sightings_data |> 
        filter(as.numeric(Year) %in% year_range)
    }
    
    df
    
  })

  output$map <- renderLeaflet({
    req(dat())
    leaflet(dat()) |>
      addTiles() |>
      addMarkers(lng = ~longitude, 
                 lat = ~latitude, 
                 popup = ~paste("County:", County, 
                                "<br>State:", State,
                                "<br>Year:", Year,
                                "<br>Summary:", Summary),
                 icon = makeIcon(
                   iconUrl = "https://cdn.iconscout.com/icon/premium/png-256-thumb/bigfoot-icon-svg-png-download-2227694.png",
                   iconWidth = 45, iconHeight = 45
                 ))
  })
}

shinyApp(ui = ui, server = server)

