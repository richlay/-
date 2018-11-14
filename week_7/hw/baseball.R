library(tidyverse)
library(readr)
standings <- read_csv("standings.csv")

library(ggplot2)
ggplot(data = standings, mapping = aes(x = Tm, y = W, fill = Lg ))+
  geom_bar(stat = "identity")+
  coord_flip()+
  ylab("Wins")+
  xlab("Teams")

batting <- read_csv("batting.csv")
bos <- filter(batting, Tm=="BOS")
ggplot(data = bos, mapping = aes(x = Name, y = BA ))+
  geom_bar(stat = "identity")+
  coord_flip()+
  ylab("Ba")+
  xlab("Name")

for (x in 1:30) {
  x <- 1
  team_name <- filter(standings, x==1) %>% Tm
  
}


