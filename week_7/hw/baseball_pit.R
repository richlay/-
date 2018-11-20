library(tidyverse)
library(readr)
team_fielding <- read_csv("team_fielding.csv")
team_standard_batting <- read_csv("team_standard_batting.csv")
team_standard_pitching <- read_csv("team_standard_pitching.csv")

newvar <- t(team_standard_pitching)
newvar <- as.data.frame(newvar, stringsAsFactors = F)
colnames(newvar) <-  as.character(unlist(newvar[1, ])) # the first row will be the header
newvar = newvar[-1, ] 
newvar = newvar[,-32 ]
newvar = newvar[,-31 ]
newvar1 <- newvar
for(i in 1:30){
  newvar[,i] <- as.numeric(newvar[,i])
}

for(k in 1:35){
  newvar<- mutate(newvar, counting = newvar$BOS-newvar$BOS)
  if(newvar[k,31]>0){
    newvar[k,32] <- 1
  }else if(newvar[k,31]==0){
    newvar[k,32] <- 0
  }else if(newvar[k,31]<0){
    newvar[k,32] <- -1
  }
}
row.names(newvar) <- row.names(newvar1)

View(newvar)

for(k in 1:35){
newvar<- mutate(newvar, counting = newvar$COL-newvar$CHC)
if(newvar[k,31]>0){
newvar[k,32] <- 1 + newvar[k,32]
}else if(newvar[k,31]==0){
  newvar[k,32] <- 0 + newvar[k,32]
}else if(newvar[k,31]<0){
  newvar[k,32] <- -1 + newvar[k,32]
}
}

row.names(newvar) <- row.names(newvar1)
View(newvar)

write.csv(newvar,"ana_post_pitching.csv")
