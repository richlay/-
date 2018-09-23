library(rvest)
web <- read_html("https://www.atpworldtour.com/en/rankings/singles")
labeling <- web%>%html_nodes(".sorting-label")%>%html_text()
labeling

