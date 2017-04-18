##mynote 2017-3-28

iTotal <- 0
for(i in 1:100)
{
  iTotal <- iTotal + i
}
cat("Sum of 1-100:",iTotal,"\n",sep="")

szSymbols <- c("MSFT","GOOG","AAPL","INTL","ORCL","SYMC")
for(SymbolName in szSymbols)
{
  cat(SymbolName,"\n",sep="")
}

x <- matrix(1:6, 2, 3)
ifelse(x >= 0, sqrt(x), NA)

ccc <- c("b","QQ","a","A","bb")
for (ch in ccc)
{
  cat(ch,":",switch(EXPR=ch,a=1,b=2:3,"otherwise:break"),"\n")
}

"%g%" <- function(x,y)
{
  print(x+y)
  print(x-y)
  print(x*y)
  print(x/y)
}
3%g%5


View(airquality)
columnmean <- function(y){
  nc <- ncol(y)
  means <- numeric(nc)
  for(i in 1:nc){
    means[i] <- mean(y[,i])
  }
  means
}
?Map()

# 1. Check for exact match for a named argument
# 2. Check for a partial match
# 3. Check for a positional match
args(sd)


myplot <- function(x, y, type = "l", ...) {
  plot(x, y, type = type, ...)
}
attach(mtcars)
opar=par()
par(mfrow=c(2,1))
plot(mpg,wt)
myplot(mpg,wt)
par(opar)
detach(mtcars)


args(paste)
args(cat)
paste("a", "b", sep = ":")
paste("a", "b", se = ":")

x <- c(1,9,2,8,3,7)
y <- c(9,2,8,3,7,2)
parboth <- function (a,b) {
  c <- pmax(a,b)
  d <- pmin(a,b)
  answer <- list(median(c),median(d))
  names(answer)[[1]] <- "median of the parallel maxima"
  names(answer)[[2]] <- "median of the parallel minima"
  return(answer) }
parboth(x,y)

#search path
search()


##exercise
# A 79.98, 80.04, 80.02, 80.04, 80.03, 80.03, 80.04, 79.97, 80.05, 80.03, 80.02, 80.00, 80.02
# B 80.02, 79.94, 79.98, 79.97, 79.97, 80.03, 79.95, 79.97
x <- c(79.98, 80.04, 80.02, 80.04, 80.03, 80.03, 80.04, 79.97, 80.05, 80.03, 80.02, 80.00, 80.02)
y <- c(80.02, 79.94, 79.98, 79.97, 79.97, 80.03, 79.95, 79.97)

ttest.mine <- function(x,y)
{
  n1 <- length(x);n2 <- length(y)
  xbar <- mean(x);ybar <- mean(y)
  s2_1 <- var(x);s2_2 <- var(y)
  s <- sqrt(((n1-1)*s2_1+(n2-1)*s2_2)/(n1+n2-2))
  (t <- (xbar-ybar)/(s*sqrt(1/n1+1/n2)))
}
ttest.mine(x,y)
t.test(x,y)


##messages,warnings and errors
f <- function(x)
{
  message("'x' contains ",toString(x))
  x
}
f(letters[1:5])
suppressMessages(f(letters[1:5]))

g <- function(x) {
  if(any(x < 0))
  {
    warning("'x' contains negative values: ", toString(x[x < 0]))
  }
  x
}
g(c(3, -7, 2, -9))
last.warning
suppressWarnings(g(c(3, -7, 2, -9)))


#*apply functions

str(apply)
?apply
x <- matrix(1:24,nrow=4,ncol=6)
x
apply(x,1,sum)
#对x矩阵的行进行求和
apply(x,2,sum)
#对x矩阵的列进行求和

x <- matrix(rnorm(200),20,10)
x
apply(x,1,quantile,probs=c(0.25,0.75))

#处理两个向量or列表
mapply(rep, 1:4, 4:1)
rnorm(1:5,1:5,2)
mapply(rnorm, 1:5, 1:5, 2)

lapply
#返回一个list
sapply
#返回一个简化的版本

x <- list(a=1:5,b=rnorm(1000))
lapply(x,mean)

str(mapply(rnorm,seq(50,500,100),1,3))
lapply(mapply(rnorm,seq(50,500,100),1,3),mean)


x <- list(a=matrix(1:4,2,2),b=matrix(1:6,3,2))
x
lapply(x,function(elt)elt[,1])

setwd("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c4/Data_Chap_4")
load("flags.RData")
View(flags)
str(flags)
str(lapply)
cls <- lapply(flags,class)
cls <- sapply(flags,class)
flag_colors <- flags[,11:17]
head(flag_colors)
lapply(flag_colors,sum)
sapply(flag_colors,sum)

flag_shapes <- flags[,19:23]
lshape <- lapply(flag_shapes,range)
mshape <- sapply(flag_shapes,range)
class(lshape)
lshape
subset(flags,flags$sunstars==50,name)
mshape
class(mshape)
unique(c(3,4,5,5,5,6,6))
unique_vals <- lapply(flags,unique)
sapply(unique_vals,length)

str(vapply)
vapply(flags,class,character(1))

str(tapply)
x <- c(rnorm(1000),runif(1000),rnorm(1000,1))
f <- gl(3,1000)
length(f)
tapply(x,f,mean)

table(flags$landmass)
table(flags$animate)
tapply(flags$animate, flags$landmass, mean)

##exercise
View(Titanic)
Titanic.df <- as.data.frame(Titanic)
tapply(Titanic.df$Freq,Titanic.df$Survived,sum)


##
str(split)

x <- c(rnorm(10),runif(10),rnorm(10,1))
f <- gl(3,10)
split(x,f)


library(datasets)
head(airquality)
s <- split(airquality,airquality$Month)
s


f1 <- gl(2, 5)
f2 <- gl(5, 2)
interaction(f1, f2)

