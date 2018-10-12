library(leaflet)
content <- read.csv("park.csv")

x <- paste("名稱： ", content$park,"<br>","成立時間： ", content$date)
 
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=content$long, lat=content$lat,
             popup=x)

m  # Print the map
