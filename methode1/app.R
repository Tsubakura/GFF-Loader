library(shiny)
library(hgu133plus2.db)

# Define UI ----
ui <- fluidPage(
  titlePanel("hgu133plus2.db"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Show info from the hgu133plus2.db"),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = head(keys(hgu133plus2.db)),
                  selected = head(keys(hgu133plus2.db))[1])
    ),
    
    mainPanel(
      tableOutput("table")
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  output$table <- renderTable({
    select(hgu133plus2.db, 
                columns = keytypes(hgu133plus2.db)[1:2], 
                keys = input$var)
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)