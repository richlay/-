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

newvar <- t(team_fielding)
newvar <- as.data.frame(newvar, stringsAsFactors = F)
colnames(newvar) <-  as.character(unlist(newvar[1, ])) # the first row will be the header
newvar <-  newvar[-1, ] 
newvar <-  newvar[,-32 ]
newvar <-  newvar[,-31 ]
for(i in 1:30){
  newvar[,i] <- as.numeric(newvar[,i])
}
for(k in 1:17){
  newvar<- mutate(newvar, counting = newvar$HOU-newvar$BOS)
  if(newvar[k,31]>0){
    newvar[k,32] <- 1
  }else if(newvar[k,31]==0){
    newvar[k,32] <- 0
  }else if(newvar[k,31]<0){
    newvar[k,32] <- -1
  }
}

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
),

# comparison panel
tabPanel("Comparison",
         sidebarLayout(
           position = "right",
           sidebarPanel(
             selectInput(
               inputId = "team1",
               label = "Select a team.",
               choices = standings$Tm,
               selected = "BOS"
             ),
             selectInput(
               inputId = "team2",
               label = "Select another team.",
               choices = standings$Tm,
               selected = "LAD"
             ),
             radioButtons(
               inputId = "value_bat_pit",
               label = "Select catagory.",
               choices = list("Batter",
                              "Pitcher",
                              "Fielding")
             ),
             selectInput(
               inputId = "value_com",
               label = "Select value.",
               choices = "-"
             )
           ),
           
           mainPanel(
             plotOutput("barPlot_com")
           ) 
         )
         ),

# analysis panel            
tabPanel("Analysis",
         sidebarLayout(
           position = "right",
           sidebarPanel(
             helpText("Select the teams matchups you wish to analysis."),
             selectInput(inputId = "ana_team_win",
                         label = "Select winning team:",
                         choices = standings$Tm
             ),
             selectInput(inputId = "ana_team_lose",
                         label = "Select losing team:",
                         choices = standings$Tm,
                         selected = "LAD"
             ),
             actionButton("go", "Go")
           ),
           mainPanel(
             plotOutput("barPlot_ana")
           )
         
)

)
)
)


# Define server logic required to draw a histogram
server <- function(input, output, session) {

  # batter panel output
   selected_team_batter <- reactive({filter(batting, Tm==input$team_batter, input$value_batter !=0)})
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
   
   # observe
   observe(
     if(input$value_bat_pit=="Batter"){
     updateSelectInput(session,
                       "value_com",
                       label = "Select value.",
                       choices = names(team_standard_batting[3:29])
                       )

     })
   observe(  
   if(input$value_bat_pit=="Pitcher"){
       updateSelectInput(session,
                         "value_com",
                         label = "Select value.",
                         choices = names(team_standard_pitching[3:36])
       )
     })
   observe(
     if(input$value_bat_pit=="Fielding"){
       updateSelectInput(session,
                         "value_com",
                         label = "Select value.",
                         choices = names(team_fielding[4:14])
       )
     })
   
   output$barPlot_com <- renderPlot({
     selected_team_standard_batting <- reactive({filter(team_standard_batting, Tm==input$team1|Tm==input$team2)})
     selected_team_standard_pitching <- reactive({filter(team_standard_pitching, Tm==input$team1|Tm==input$team2)})
     selected_team_fielding <- reactive({filter(team_fielding, Tm==input$team1|Tm==input$team2)})
     if(input$value_bat_pit=="Batter"){
     ggplot(data = selected_team_standard_batting(), mapping = aes_string(x ="Tm", y = input$value_com))+
       geom_bar(stat = "identity")+
       ylab(input$value_com)+
       xlab("Team")
     }else if(input$value_bat_pit=="Pitcher"){
     ggplot(data = selected_team_standard_pitching(), mapping = aes_string(x ="Tm", y = input$value_com))+
       geom_bar(stat = "identity")+
       ylab(input$value_com)+
       xlab("Team")
   }else if(input$value_bat_pit=="Fielding"){
     ggplot(data = selected_team_fielding(), mapping = aes_string(x ="Tm", y = input$value_com))+
       geom_bar(stat = "identity")+
       ylab(input$value_com)+
       xlab("Team")
   }
})
   
   # analysis panel output
   eventReactive(input$go, {
     for(k in 1:17){
       newvar<- mutate(newvar, counting = newvar$input$ana_team_win-newvar$input$ana_team_lose)
       if(newvar[k,31]>0){
         newvar[k,32] <- 1 + newvar[k,32]
       }else if(newvar[k,31]==0){
         newvar[k,32] <- 0 + newvar[k,32]
       }else if(newvar[k,31]<0){
         newvar[k,32] <- -1 + newvar[k,32]
       }
     }
   })
   output$barPlot_ana <- renderPlot({
     ggplot(data = newvar(), mapping = aes(x =newvar[,32]))+
       geom_bar(stat = "identity")+
       coord_flip()+
       xlab("Value")
   })
}




# Run the application 
shinyApp(ui = ui, server = server)

