#Using data “testconcorda.txt” and package “wordcloud2”, draw the following plot.
setwd("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c2/Data_Chap_2")
wlist <- scan(file="testconcorda.txt",what="")
wlist
library(stringr)
objects("package:stringr")
cat(wlist)
wordfreq <- function(wl)
{
  freq <- data.frame(word=unique(wl),stringsAsFactors = F)
  freq$freq <- 0
  for (i in seq_along(freq$word))
  {
    freq$freq[i]<- sum(str_count(string=wl,pattern=paste("^",freq$word[i],"$",sep="")))
  }
  return(freq)
  #require(data.table)
  # freq <- data.table(word=wl,stringsAsFactors = F)
  # freq <- freq[,.(freq=.N),by=c("word")]
  # return(freq)
}
wfreq <- wordfreq(wlist)
head(wfreq)
wordcloud2(data=wfreq,color="random-light",backgroundColor="grey",shape="cardioid")
