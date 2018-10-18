
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

List_03 <- c("Is", "is", "went", "Went",
             "We", "we", "are", "Are",
             "Here", "here", "Can", "can",
             "look", "Look")
List_03 <- as.data.frame(List_03)
colnames(List_03) <- "Word"
List_03$List <- "List 03"

List_04 <- c("See", "see", "The", "the",
             "And", "and", "In", "in",
             "My", "my", "Will", "will",
             "She", "she")
List_04 <- as.data.frame(List_04)
colnames(List_04) <- "Word"
List_04$List <- "List 04"

List_05 <- c("Us", "us", "An", "an",
             "I", "by", "By", 
             "Up", "up", "Come", "come",
             "said")
List_05 <- as.data.frame(List_05)
colnames(List_05) <- "Word"
List_05$List <- "List 05"

List_06 <- c("About", "about", "Good", "good",
             "Now", "now", "Under", "under",
             "As", "as")
List_06 <- as.data.frame(List_06)
colnames(List_06) <- "Word"
List_06$List <- "List 06"

Global_List <- bind_rows(List_01, List_02, List_03)

Complete_List <- Global_List

Complete_List$List <- "Complete List"

Global_List <- bind_rows(Global_List, Complete_List)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Let's Learn Some Words!"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         selectInput("List_Selection",
                            "Choose a Sight Word List:",
                            c("List 01", "List 02",
                              "List 03", "Complete List")),
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

