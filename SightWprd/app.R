
library(shiny)
library(tidyverse)

List_01 <- c("it", "It", "did", "Did", "a", "A",
             "to", "To", "me", "Me", "go", "Go", "you", "You")
List_01 <- as.data.frame(List_01)
colnames(List_01) <- "Word"
List_01$List <- "List 01"

List_02 <- c("like", "Like", "yes", "Yes",
             "am", "Am", "he", "He",
             "this", "This", "get", "Get",
             "be", "Be")
List_02 <- as.data.frame(List_02)
colnames(List_02) <- "Word"
List_02$List <- "List 02"

Global_List <- bind_rows(List_01, List_02)


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Let's Learn Some Words!"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput("List_Selection",
                            "Choose a Sight Word List:",
                            c("List 01", "List 02")),
         actionButton("Initiate", "Generate Word")
      ),
      
      # Display the Sight Word
      mainPanel(
         htmlOutput("SightWord")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
 
 Active_List <-  eventReactive(input$Initiate, {
    
    if(is.null(input$List_Selection)){
      return()
    }
    
   Reactive_List <- Global_List %>% filter(List == input$List_Selection) %>% select(Word)
   
   Sample_List <- sample(Reactive_List$Word, 1, replace = FALSE)
   
   Sample_List
   
  })
  
  output$SightWord <- renderUI({
    
    HTML(paste0('<b>',
                '<font size = "7">',
                Active_List(),
                '</font size>',
                '</b>'))
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

