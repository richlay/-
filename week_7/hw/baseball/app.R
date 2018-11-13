#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyverse)
library(readr)
batting <- read_csv("batting.csv")
standings <- read_csv("standings.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Baseball Postseason Analysis"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      position = "right",
      sidebarPanel(
         helpText("See the selected bar chart of selected team."),
         selectInput(inputId = "team",
                     label = "Select team:",
                     choices = standings$Tm,
                     ),

         selectInput(inputId = "value",
                     label = "Select value:",
                     choices = batting[1, 6:29],
                     selected = batting[1, 19]
         )
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("barPlot")
      )
   )
)



# Define server logic required to draw a histogram
server <- function(input, output) {

   selected_team <- reactive({filter(batting, Tm==input$team)})

   output$barPlot <- renderPlot({
     ggplot(data = selected_team(), mapping = aes_string(x ="Name", y = "BA"))+
       geom_bar(stat = "identity")+
       coord_flip()+
       ylab("value")+
       xlab("Name")
   })
}




# Run the application 
shinyApp(ui = ui, server = server)

