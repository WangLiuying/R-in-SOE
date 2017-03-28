
#an example
manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 56, 25, 89, 99)
leadership <- data.frame(manager, date, country, gender, age)
leadership
leadership$age[leadership$age == 99] <- NA
leadership$agecat[leadership$age > 75] <- "Elder"
leadership$agecat[leadership$age>=55 & leadership$age <= 75] <- "Middle Aged"
leadership$agecat[leadership$age < 55] <- "Young"
leadership

leadership <- within(leadership,{
  agecat <- NULL; agecat[age > 75] <- "Elder"
  agecat[age >= 55 & age <= 75] <- "Middle Aged"
  agecat[age < 55] <- "Young"})
#`within` is similar with `with`,but "environment"


class(leadership$date)
leadership$date <- as.Date(leadership$date,"%m/%d/%y")
class(leadership$date)
leadership$date <- as.character(leadership$date)
class(leadership$date)

#Missing Value
x <- c(1,2,NA,3)
sum(x)
sum(x,na.rm = T)

x <- c(1,2,NA,NaN,3)
sum(x)
sum(x,na.rm=T)

x <- c(1,2,NA,4,NA,5)
y <- c("a","b","c","d",NA,"f")
good <- complete.cases(x,y)
good
x[good];y[good]

df <- data.frame(x=x,y=y)
na.omit(df)


#Date Values
x <- Sys.time()
class(x)
unclass(x)
str(x)

p <- as.POSIXlt(x)
names(unclass(p))
p$sec
#POSIXct是个数字,POSIXlt是个列表

today <- Sys.Date()
class(today)
as.numeric(as.Date("1970-01-01"))
as.numeric(as.Date("1969-01-01"))

format(today,format="%a %m %d %Y")
format(today,format="%a %m %d %y")
format(today,format="%B")

dates <- c("02/27/92","02/27/92")
class(dates)
dates <- as.Date(dates,format = "%m/%d/%y")
dates
class(dates)
unclass(dates)

#perform arithmetic operations on them
startdate <- as.Date("2004-02-13")
enddate <- as.Date("2011-01-22")
(days <- enddate-startdate)
today <- Sys.Date()
dob <- as.Date("1999-9-9")
difftime(today,dob,units = "week")

birthday <- as.Date("1993-12-03")
birthday+1000

#############################################################
#Sorting data
#############################################################
leadership

#sort and order
sort(leadership$age)
order(leadership$age)

leadership[order(leadership$age),]
leadership[order(leadership$age)]#wrong answer
attach(leadership)
newdata <- leadership[order(gender,-age),]
newdata
detach(leadership)
#exclude variables
names(leadership)
(myvars <- names(leadership)%in% c("manager","age"))
(newdate <- leadership[!myvars])


#selecting or excluding
leadership
which(leadership$gender=="M"&leadership$age>30)
(newdata <- leadership[which(leadership$gender=="M"&leadership$age>30),])

leadership$date <- as.Date(leadership$date,"%m/%d/%y")
startdate <- as.Date("2009-01-01")
enddate <- as.Date("2009-10-31")
newdata <- leadership[which(leadership$date >= startdate & leadership$date <= enddate),]
newdata
newdata <- subset(leadership, age >= 35 | age < 80, select=c(manager,age))
newdata
newdata <- subset(leadership, gender=="M" & age > 50, select=manager:age)
newdata

#random samples
mysample <- leadership[sample(1:nrow(leadership), 3, replace=FALSE),]
mysample

require(ggplot2)
## Loading required package: ggplot2
data(diamonds)
head(diamonds)
?aggregate
aggregate(price ~ cut, diamonds, mean)
aggregate(price ~ cut + color, diamonds, range)
aggregate(cbind(price, carat) ~ cut, diamonds, mean)


#merge and join
lifeforms <- read.table("R/R-class/c3/Data/lifeforms.txt",header=T)
flowering <- read.table("R/R-class/c3/Data/fltimes.txt",header=T)
lifeforms;flowering
merge(x=flowering,y=lifeforms,by.x=c("Genus","species"),by.y=c("Genus","species"))
merge(x=flowering,y=lifeforms,by.x=c("Genus","species"),by.y=c("Genus","species"),all=T)


Aid_90s<-read.delim("R/R-class/c3/Data/US_Foreign_Aid_90s.csv",sep=",")
Aid_00s<-read.delim("R/R-class/c3/Data/US_Foreign_Aid_00s.csv",sep=",")
head(Aid_90s)
head(Aid_00s)
Aid90s00s <- merge(x=Aid_90s, y=Aid_00s,
                   by.x=c("Country.Name", "Program.Name"),
                   by.y=c("Country.Name", "Program.Name"))
head(Aid90s00s)

require(plyr)
Aid90s00sJoin <- join(x = Aid_90s, y = Aid_00s, by = c("Country.Name",
                                                       "Program.Name"))
head(Aid90s00sJoin)

##transpose
#t()
cars <- mtcars[1:5,1:4]
cars
class(cars)

t(cars)
class(t(cars))

#melting and dcast
#reshape packages
ID<-c(1,1,2,2) #ID<-c(1,1,1,2,2)
Time<-c(1,2,1,2) #Time<-c(1,1,2,1,2)
X1<-c(5,3,6,2) #X1<-c(5,5,3,6,2)
X2<-c(6,5,1,4) #X2<-c(6,6,5,1,4)
mydata<-data.frame(ID,Time,X1,X2)
mydata

#install.packages("reshape")
library(reshape)
(md <- melt(mydata,id=c("ID","Time")))

cast(md,ID+Time~variable,value = "value")


#example
country<-c("China","USA","Japan")
GDP2000<-c(5000,6000,7000)
GDP2005<-c(5500,6500,7500)
GDP2010<-c(5010,6010,7001)
developed<-as.factor(c(0,1,1))
Data<-data.frame(country,developed,GDP2000,GDP2005,GDP2010)

Data.l <- melt(Data,measure.vars = c("GDP2000","GDP2005","GDP2010"))
Data.l
long<-reshape(Data,idvar="country",varying=list(names(Data)[3:5]),
              v.names="GDP",timevar="year",times=c(2000,2005,2010),direction="long")
long <- long[order(long$country),]
wide <- reshape(long, v.names="GDP", idvar="country", timevar="year", direction="wide")
wide


trdata <- read.csv("clipboard")
head(trdata)
tr.wide <- dcast(trdata,...~year,value.var="rgdpl")
tr.long <- melt(tr.wide,id.vars = c("country","country.isocode"),value.name="rgdpl")
tr.long <- tr.long[order(tr.long$country),]

#merge
setwd("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c3/Data")
library(stringr)
filename <- c("brazil_daily.csv","China_daily.csv","India_daily.csv","Rusia_daily.csv")
mymerge <- function(filename)
{
  for (i in filename)
  {
    if (i == filename[1])
    {
      mydata <- read.csv(i)[, c("Date", "Adj.Close")]
      mydata$Date <- as.Date(mydata$Date)
      names(mydata) <- c("Date", str_extract(i, pattern = "\\D+_"))
    }
    else
    {
      mydata.temp <- read.csv(i)[, c("Date", "Adj.Close")]
      names(mydata.temp) <- c("Date", str_extract(i, pattern = "\\D+_"))
      mydata.temp$Date <- as.Date(mydata.temp$Date)
      mydata <- merge(x = mydata, y = mydata.temp)
    }
  }
  return(mydata)
}
data.bric <- mymerge(filename)

##字符串操作
person <- "Jared"
partySize <- "eight"
waitTime <- 25
paste("Hello ",person,", your party of ",partySize,
      " will be seated in ",waitTime," minutes.",sep="")
sprintf("Hello %s, your party of %s will be seated in %s minutes",
        person, partySize, waitTime)
sprintf("Hello %s, your party of %s will be seated in %s minutes",
        c("Jared", "Bob"), c("eight", 16, "four", 10), waitTime)

##
library(RCurl)
library(stringr)
library(XML)
load("presidents.rdata")
# theURL <- "http://www.loc.gov/rr/print/list/057_chron.html"
# presidents <- readHTMLTable(theURL, which=3, as.data.frame=TRUE,
#                             skip.rows=1, header=TRUE,
#                             stringsAsFactors=FALSE)
head(presidents)
tail(presidents)
presidents <- presidents[1:64,]
yearList <-  str_split(string=presidents$YEAR,pattern="-")
# a=c(1,2,2,4,5)
# Reduce("+",a)
# cadd <- function(x) Reduce("+",x,accumulate=T)
# cadd(seq_len(7))
yearMatrix <- data.frame(Reduce(rbind, yearList))
head(yearMatrix)
names(yearMatrix) <- c("Start", "Stop")
presidents <- cbind(presidents, yearMatrix)
presidents$Start <- as.numeric(as.character(presidents$Start))
presidents$Stop <- as.numeric(as.character(presidents$Stop))
head(presidents)
tail(presidents)
str_sub(string = presidents$PRESIDENT, start = 1, end = 3)
presidents[str_sub(string = presidents$Start, start = 4,
                   end = 4) == 1, c("YEAR", "PRESIDENT", "Start", "Stop")]

johnPos <- str_detect(string=presidents$PRESIDENT,pattern="John")
presidents[johnPos,c("YEAR","PRESIDENT","Start","Stop")]
goodSearch <- str_detect(presidents$PRESIDENT,ignore.case("john"))
?modifiers
sum(str_detect(presidents$PRESIDENT,coll("john",ignore_case = T)))
presidents[str_detect(presidents$PRESIDENT,coll("john",ignore_case = T)),
           c("YEAR","PRESIDENT","Start","Stop")]

##Another example
load("warTimes.rdata")
#con <- url("http://www.jaredlander.com/data/warTimes.rdata")
#load(con)
#close(con)
head(warTimes, 10)
class(warTimes)
write.table(warTimes,"warTimes.txt")
warTimes[str_detect(string=warTimes,pattern="-")]
theTimes <- str_split(string=warTimes,pattern="(ACAEA)|-",n=2)
which(str_detect(string=warTimes,pattern = "-"))
theTimes[[147]];theTimes[[150]]
theStart <- sapply(theTimes,FUN=function(x) x[1])
head(theStart)
theStart <- str_trim(theStart)
head(theStart)
str_extract(string=theStart,pattern="January")
theStart[str_detect(string=theStart,pattern="January")]
head(str_extract(string=theStart,"[0-9]\\d\\d\\d"),20)
head(str_extract(string=theStart,"\\d{4}"),20)
head(str_extract(string=theStart,"\\d{1,3}"),20)
head(str_extract(string=theStart,"^\\d{4}"),20)         
head(str_extract(string=theStart,"\\d{4}$"),20)
head(str_replace(string=theStart,"\\d",replacement = "x"))
head(str_replace_all(string=theStart,"\\d",replacement = "x"))

#########################
##Time
Sys.time()##1970-1-1 start
class(Sys.time())
str_split(Sys.time()," ")[[1]][2]
unlist(str_split(Sys.time()," "))[2]


url<-"http://www.stats.govt.nz/~/media/Statistics/Browse%20for%20stats/GovernmentFinanceStatisticsLocalGovernment/HOTPYeJun14/gfslg-jun14-tables.xls"
temp<-getBinaryURL(url)
note <- file("hellodata.xls",open="wb")#新建一个链接，方式“读写”
writeBin(temp,note)#写入刚才的数据
close(note)

#download multi data
require(stringr)
require(Rcurl)
url<-"http://rfunction.com/code/1202/"
html<-getURL(url)
html
files<-str_split(html,"<li><a href=\"")
class(files)
files<-unlist(files)
files<-str_extract_all(string = files, "^\\d{6}.R")
head(files)
class(files)
files<-unlist(files)
files
class(files)
baseurl<-"http://rfunction.com/code/1202/"
for(i in 1:length(files)) {
  url<-paste(baseurl,files[i],sep="")
  temp<-getBinaryURL(url)
  note <-file(paste(files[i],"txt",sep="."), open = "wb")
  writeBin(temp,note)
  close(note)
  Sys.sleep(2)
}
