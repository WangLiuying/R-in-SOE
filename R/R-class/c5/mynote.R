##chapter 5

##1.methodology
#mean
arithmetic.mean <- function(x) sum(x)/length(x)
mean(x,trim=0.05)
#去掉最大最小5%的数据

#median
median(x)

#调和平均数
harmonic <- function(x) 1/mean(1/x)

my.summary <- function(x)
{
  x.mean <- mean(x)
  x.var <- var(x)
  x.sd <- sd(x)
  x.median <- median(x)
  x.cv <- 100*x.sd/x.mean
  require(e1071)
  x.ske <- skewness(x)
  s.kur <- kurtosis(x)
  list(x.mean,x.var,x.sd,x.median,x.cv,x.ske,s.kur)
}
my.summary(x)

##basic method
data(mtcars)
vars <- c("mpg","hp","wt")
summary(mtcars[vars])
library(Hmisc)
describe(mtcars[vars])
library(pastecs)
stat.desc(mtcars[vars])


##descriptie statistics by group
aggregate(mtcars[vars],by=list(am=mtcars$am),mean)

library(psych)
describeBy(mtcars[vars],mtcars$am)

mystats <- function(x, na.omit = FALSE) {
  if (na.omit) x <- x[!is.na(x)]
  m <- mean(x)
  n <- length(x)
  s <- sd(x)
  skew <- sum((x - m)^3/s^3)/n
  kurt <- sum((x - m)^4/s^4)/n - 3
  return(c(n = n, mean = m, stdev = s, skew = skew, kurtosis = kurt))
}
library(reshape)
dfm <- melt(mtcars, measure.vars = c("mpg", "hp", "wt"), id.vars = c("am", "cyl"))
cast(dfm, am + cyl + variable ~ ., mystats)

library(doBy)
sumaryBy(mpg+pg+wt~am,data=mtcars,FUN=mystats)

##using a graph 
windows(5,5)
COM <- function(x)
{
  par(mfrow=c(2,2))
  hist(x)
  dotchart(x)
  boxplot(x)
  qqnorm(x);qqline(x)
  par(mfrow=c(1,1))
}
x <- rnorm(100)
COM(x)

#frequency tables
#one way tables
library(vcd)
data(Arthritis)
mytable <- with(Arthritis, table(Improved))
prop.table(mytable)
?prop.table

mytable <- with(Arthritis,table(Treatment,Improved))
mytable
class(mytable)

(mytable <- xtabs(~Treatment+Improved,data=Arthritis))

DF <- as.data.frame(UCBAdmissions)
head(DF)
xtabs(Freq ~ Gender + Admit, DF)

Titanic <- as.data.frame(Titanic)
xtabs(Freq~Class+Survived,Titanic)

addmargins(mytable)
addmargins(prop.table(mytable))

#correlation
?cor
#cor(x,use=,method=)
str(state.x77)
states<- state.x77[,1:5]
cov(states)
cor(states)
cor(states, method="spearman")
library(psych)
corr.test(states, use="complete")
library(ggm)
pcor(c(1,5,2,3,4), cov(states))

#output in text
install.packages("stargazer")
library(stargazer)
mydata <- mtcars
stargazer(mydata,type="text",title="Descriptive statistics",digits=2,out="table1.txt")
stargazer(mydata, type = "text", title="Descriptive statistics", digits=1, out="table1.txt",
          covariate.labels=c("Miles/(US)gallon","No. of cylinders","Displacement (cu.in.)",
                             "Gross horsepower","Rear axle ratio","Weight (lb/1000)",
                             "1/4 mile time","V/S","Transmission (0=auto, 1=manual)",
                             "Number of forward gears","Number of carburetors"))

stargazer(mydata, title="Descriptive statistics", digits=1, out="table1.tex",
          covariate.labels=c("Miles/(US)gallon","No. of cylinders","Displacement (cu.in.)",
                             "Gross horsepower","Rear axle ratio","Weight (lb/1000)",
                             "1/4 mile time","V/S","Transmission (0=auto, 1=manual)",
                             "Number of forward gears","Number of carburetors"))
stargazer(mydata, type="html", title="Descriptive statistics", digits=1, out="table1.html",
          covariate.labels=c("Miles/(US)gallon","No. of cylinders","Displacement (cu.in.)",
                             "Gross horsepower","Rear axle ratio","Weight (lb/1000)",
                             "1/4 mile time","V/S","Transmission (0=auto, 1=manual)",
                             "Number of forward gears","Number of carburetors"))
stargazer(subset(mydata[c("mpg","hp","drat")], mydata$am==0),
          title="Automatic transmission", type = "text", digits=1, out="table3.txt")