library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=120.768, lat=23.852,
             popup="The birthplace of R")
m  # Print the map
