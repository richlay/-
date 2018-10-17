library(tm)
library(tmcn)
library(Rwordseg)
library(jiebaR)

library("SnowballC")
library("wordcloud")
library("RColorBrewer")

for (y in 91:107) {
  nam <- paste("speech", y, sep = "")
  assign(nam, readLines(paste(y, '.txt' , sep = "")))  
}

cutter <- worker()
docs <- segment(speech100, cutter)
docs <- filter_segment(docs,stopwordsCN())
docs<-gsub("[0-9]+?","",docs)###去除数字和英文
library(stringr)#加载stringr包
docs<-str_trim(docs)#去除空格

docs
sort(table(cutter[docs]),decreasing = T)
library(plyr)
tableWord <- count(docs)
tableWord
wordcloud(tableWord[,1],tableWord[,2],random.order=F,col= rainbow(length(docs)))
