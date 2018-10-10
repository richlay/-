library(rvest)
library(leaflet)
places <- read_html("https://zh.wikipedia.org/wiki/%E4%B8%AD%E8%8F%AF%E6%B0%91%E5%9C%8B%E5%9C%8B%E5%AE%B6%E5%85%AC%E5%9C%92")%>%
  html_nodes("td:nth-child(2) a") %>%
  html_text()
lat<-long<-location <- placesurl <- 0
for (i in 1:9) {
  placesurl[i] <- paste("https://zh.wikipedia.org/wiki/", places[i],sep='')
}
placesurl[2]
read_html(placesurl[2])%>%html_nodes("#coordinates .longitude")%>%html_text()
for (j in 1:9) {
  long[j]<- read_html(placesurl[j])%>%html_nodes("#coordinates .longitude")%>%html_text()
  lat[j]<- read_html(placesurl[j])%>%html_nodes("#coordinates .latitude")%>%html_text()
}

decimal_min <- function(x){
  return(round(x/60, digits = 4))
}
decimal_sec <- function(y){
  return(round(y/3600, digits = 4))
} 
decimal <- strsplit()

