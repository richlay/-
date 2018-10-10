setwd("C:/Users/user/Documents/GitHub/Rlanguage/week_4/hw")
speech = readLines("17.txt")
library("tm")
library("tmcn")
library("rJava")
library("Rwordseg")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
docs <- Corpus(VectorSource(speech))

# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove punctuations
docs <- tm_map(docs, removePunctuation)

docs <- tm_map(docs[1:100], segmentCN, nature = TRUE)
docs <- tm_map(docs, function(sentence) {
  noun <- lapply(sentence, function(w) {
    w[names(w) == "n"]
  })
  unlist(noun)
})
docs <- Corpus(VectorSource(docs))
# Text stemming
docs <- tm_map(docs, stemDocument)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
View(d)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")
