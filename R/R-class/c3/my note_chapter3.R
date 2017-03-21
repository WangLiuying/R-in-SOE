
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
dob <- as.Date()
difftime()