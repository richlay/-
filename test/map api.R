url <- read_html("https://api.opencagedata.com/geocode/v1/xml?q=台北市中正區延平南路96號&key=ecc60a065eff4d33907058bcad9820d7")
node <- html_nodes(url,".latitude")
