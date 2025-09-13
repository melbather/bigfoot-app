# Sitings Map UI ---------------------------------------------------------------

sightings_map_ui <- function(id, label = "map_ui") {
  ns <- NS(id)
  tagList(
    fluidPage(
      fluidRow(
        column(12,
               wellPanel(
                 selectInput(ns("test"),
                             "Test",
                             choices = 1:5)
               )
        )
      ),
      div(style = "padding: 0px 0px; margin-top:-3em",
          fluidRow(
            column(12,
                   h3(htmlOutput(ns("test2"))),
                   br(),
                   plotlyOutput(ns("map_plot")))
          )
      )
    ))
  
}




#Map Server ----------------------------------------------------

sightings_map_server <- function(id, parent, label = "sightings_map_server") {
  
  moduleServer(id, function(input, output, session) {
    
    output$map_title <- renderUI({
      req(input$test)
      if(input$test == 1) title_pt1 <- "blah"
      else if(input$test == 2) title_pt1 <- "blahdeblah"
      else title_pt1 <- "bloop"
      
      paste(title_pt1, "Test Title")
    })
    
    dat <- reactive({
      req(input$test)
      
      sightings_dat
    })
    
    output$map_plot <- renderPlotly({
      req(dat(), input$test)
      
      p <- ggplot(dat())
      
      ggplotly(p, tooltip = "text")
    })
    
    
  })
  
}