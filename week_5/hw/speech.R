library(tm)
library(tmcn)
library(jiebaR)
library(stringr)
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library(Rwordseg)


cutter <- worker(stop_word = "停用詞.txt") #initialize jiebaR workers

#for (y in 91:107) {
#  nam <- paste("speech", y, sep = "")
 # assign(nam, readLines(paste(y, '.txt' , sep = ""), encoding = "UTF-8")) 
   #}

#docs <- cutter[speech107]
wordstop <- readLines("停用詞.txt", encoding= "UTF-8")
d.corpus <- Corpus(DirSource("txt",encoding = "UTF-8"), list(language = NA))
d.corpus <- tm_map(d.corpus, removePunctuation)


d.corpus <- tm_map(d.corpus[1:100], segmentCN, nature = TRUE)
d.corpus <- tm_map(d.corpus, function(sentence) {
  noun <- lapply(sentence, function(w) {
    w[names(w) == "n"]
  })
  unlist(noun)
})
d.corpus<-tm_map(d.corpus,removeWords,stopwords(wordstop))
d.corpus <- Corpus(VectorSource(d.corpus))

tdm = TermDocumentMatrix(d.corpus, control = list(wordLengths = c(2, Inf)))
inspect(tdm[1:10, 1:2])



sort(table(docs),decreasing = T)
tb<-table(docs)

library(plyr)
tableWord <- count(docs) #Equivalent to as.data.frame(table(x))
str(tableWord)
wordcloud(tableWord[,1],tableWord[,2],min.freq=3,random.order=F,rot.per = F,colors= rainbow(length(docs)))

作者：拿笔的小鑫
链接：https://www.jianshu.com/p/30460f38b774
來源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。
