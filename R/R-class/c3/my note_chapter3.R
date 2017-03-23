
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
