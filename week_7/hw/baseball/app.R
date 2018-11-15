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
pitching <- read_csv("pitching.csv")
team_standard_batting <- read_csv("team_standard_batting.csv")
team_fielding <- read_csv("team_fielding.csv")
team_standard_pitching <- read_csv("team_standard_pitching.csv")


# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("MLB Postseason Analysis"),
   
   # create navbar
   navbarPage("",
              
   # team panel
   tabPanel("Teams",
         sidebarLayout(
         position = "right",
         sidebarPanel(
           selectInput(inputId = "value_team",
                         label = "Select value:",
                         choices = list("W","L"),
                         selected = "W"
                         )
                     ),
                     
        mainPanel(
                 plotOutput("barPlot_team")
                 )
               )
            ),
   # batter panel            
   tabPanel("Batters",
   sidebarLayout(
      position = "right",
      sidebarPanel(
         helpText("See the batters' bar chart of selected team."),
         selectInput(inputId = "team_batter",
                     label = "Select team:",
                     choices = standings$Tm
                     ),

         selectInput(inputId = "value_batter",
                     label = "Select value:",
                     choices = names(batting[6:29]),
                     selected = names(batting[19])
                     ),
         tags$a(href="https://richlay.github.io/Rlanguage/week_7/hw/note.html", "Abbreviation?")
      ),
      
      mainPanel(
         plotOutput("barPlot_batter")
      )
   )
),
      

# pitcher panel            
tabPanel("Pitchers",
         sidebarLayout(
           position = "right",
           sidebarPanel(
             helpText("See the pitchers' bar chart of selected team."),
             selectInput(inputId = "team_pitcher",
                         label = "Select team:",
                         choices = standings$Tm
             ),
             
             selectInput(inputId = "value_pitcher",
                         label = "Select value:",
                         choices = names(pitching[6:35]),
                         selected = names(pitching[9])
             ),
             tags$a(href="https://richlay.github.io/Rlanguage/week_7/hw/note.html", "Abbreviation?")
           ),
           
           mainPanel(
             plotOutput("barPlot_pitcher")
           )
         )
)

# comparison



)
)



# Define server logic required to draw a histogram
server <- function(input, output) {

  # batter panel output
   selected_team_batter <- reactive({filter(batting, Tm==input$team_batter, input$value_batter!=0)})
   output$barPlot_batter <- renderPlot({
     ggplot(data = selected_team_batter(), mapping = aes_string(x ="Name", y = input$value_batter))+
       geom_bar(stat = "identity")+
       coord_flip()+
       ylab(input$value_batter)+
       xlab("Name")
   })
   
  # team panel outout 
   output$barPlot_team <- renderPlot({
     ggplot(data = standings, mapping = aes_string(x = "Tm", y = input$value_team, fill = "Lg" ))+
       geom_bar(stat = "identity")+
       coord_flip()+
       ylab(input$value_team)+
       xlab("Teams")
   })
   
   # pitcher panel output
   selected_team_pitcher <- reactive({filter(pitching, Tm==input$team_pitcher, input$value_pitcher!=0)})
   output$barPlot_pitcher <- renderPlot({
     ggplot(data = selected_team_pitcher(), mapping = aes_string(x ="Name", y = input$value_pitcher))+
       geom_bar(stat = "identity")+
       coord_flip()+
       ylab(input$value_pitcher)+
       xlab("Name")
   })
}




# Run the application 
shinyApp(ui = ui, server = server)

