library(jiebaR)
library(stringr)
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


cutter <- worker(stop_word = "停用詞.txt") #initialize jiebaR workers

for (y in 91:107) {
  nam <- paste("speech", y, sep = "")
  assign(nam, readLines(paste(y, '.txt' , sep = ""), encoding = "UTF-8")) 
   
}

docs <- cutter[speech107]

docs<-str_trim(docs)#去除空格
docs

sort(table(docs),decreasing = T)
tb<-table(docs)

library(plyr)
tableWord <- count(docs) #Equivalent to as.data.frame(table(x))
str(tableWord)
wordcloud(tableWord[,1],tableWord[,2],min.freq=3,random.order=F,rot.per = F,colors= rainbow(length(docs)))

