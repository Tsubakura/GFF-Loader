library(shiny)
library(hgu133plus2.db)
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("biomaRt")
library(biomaRt)
mart <- useMart(biomart="ENSEMBL_MART_ENSEMBL", 
                dataset="hsapiens_gene_ensembl")

# Define UI ----
ui <- fluidPage(
  titlePanel("Homo sapiens db from biomaRt"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Show functional genomics from the hsapiens_gene_ensembl dataset"),
      
      selectInput("var", 
                  label = "Choose a chromosome to display",
                  choices = keys(mart, keytype = "chromosome_name"),
                  selected = keys(mart, keytype = "chromosome_name")[1])
    ),
    
    mainPanel(
      tableOutput("table")
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  output$table <- renderTable({
    select(mart, 
           columns = c("chromosome_name","start_position",
                       "end_position","ensembl_gene_id"), 
           keys = input$var, 
           keytype = "chromosome_name")
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)
