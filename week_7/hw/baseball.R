library(tidyverse)
library(readr)
team_fielding <- read_csv("team_fielding.csv")
team_standard_batting <- read_csv("team_standard_batting.csv")
team_standard_pitching <- read_csv("team_standard_pitching.csv")

newvar <- t(team_fielding)
newvar <- as.data.frame(newvar, stringsAsFactors = F)
colnames(newvar) <-  as.character(unlist(newvar[1, ])) # the first row will be the header
newvar = newvar[-1, ] 
newvar = newvar[,-32 ]
newvar = newvar[,-31 ]
for(i in 1:30){
  newvar[,i] <- as.numeric(newvar[,i])
}

for(k in 1:17){
newvar<- mutate(newvar, counting = newvar$HOU-newvar$HOU)
if(newvar[k,31]>0){
newvar[k,32] <- 1 + newvar[k,32]
}else if(newvar[k,31]==0){
  newvar[k,32] <- 0 + newvar[k,32]
}else if(newvar[k,31]<0){
  newvar[k,32] <- -1 + newvar[k,32]
}
}
View(newvar)

