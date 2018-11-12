txt <- readLines()
new_txt <- sub("Reload page to return to the table-formatted data.", "", txt)
new_text <- read.delim("bospitch.txt")
write.csv(new_txt, file="txt.csv",sep=",",col.names=FALSE,row.names=FALSE )

