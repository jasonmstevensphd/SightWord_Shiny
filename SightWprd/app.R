
library(shiny)
library(tidyverse)

List_01 <- c("it", "It", "did", "Did", "a", "A",
             "to", "To", "me", "Me", "go", "Go")

List_02 <- c("like", "Like", "yes", "Yes",
             "am", "Am", "he", "He",
             "this", "This", "get", "Get",
             "be", "Be")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Let's Learn Some Words!"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         checkboxGroupInput(List_Selection, c("List_01", "List_02"))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- faithful[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

