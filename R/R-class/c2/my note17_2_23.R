##class 17/2/23

#start
##save the path
mine<-getwd()
setwd("c:\\temp")
setwd(mine)
dir(mine)

##check for memory assigned to R
memory.size(NA)
memory.limit()
memory.limit(8000)

##List the objects in the current workspace
ls()
objects()
object.size(mine)
objects("package:base")
object.size(mtcars)

##Search for current packages
search()

##Remove (delete) one or more objects.
rm(mine)

##Remove all object
rm(list=ls(all=TRUE))


##Display your last # commands (default = 25).
history()
history(max.show=Inf)
##Save the commands history to myfile ( default = .Rhistory).

savehistory("myfile.Rhistory")
loadhistory("myfile.Rhistory")

##Save the workspace to myfile (default = .RData).
save.image("mydata.RData")
load("mydata.RData")

##Quit R. You’ll be prompted to save the workspace.
q()

#packages
.libPaths()
library() #my packages
search() #loaded packages

##install\library\help
install.packages("Rcmdr")
library(Rcmdr)
help(packages="Rcmdr")
install.packages(c("fBasic","foreign"))

##example1
install.packages("quantmod")
update.packages("quantmod")
library("quantmod")
##插播：安装不了包的问题
##1.换镜像
##2.关一下程序
detach("package:quantmod")
##3.删除该包
remove.packages("quantmod")
##4.从网上下载zip包重装

##继续
library("quantmod")
getSymbols("^GSPC",src="yahoo",from="1990-1-1",to=Sys.Date())
print(head(GSPC));print(tail(GSPC))
view(GSPC)
getSymbols("BABA",src="yahoo",from="2015-1-1",to=Sys.Date())
print(head(BABA));print(tail(BABA))
#save.image("baba.RData")
#load("baba.RData")

##example2
help.start()
install.packages(c("Hmisc","MASS"))

#As a calculator
119%/%13
119%%13
log(exp(sin(pi/4)^2*exp(cos(pi/4)^2)))

x <- 1:5
5:1*x
5:1*x+1:5

##subsetting
xx <- c("a","b","c","c")
class(xx)
xx[1]
xx[xx>"a"]

##cumulate
cumsum(c(5,12,13))
cumprod(c(5,12,13))

##matrix
(z <- matrix(c(1:6),nrow = 3,ncol = 2,byrow = T))
min(z)
pmin(z[,1],z[,2])#按行选
nlm(function(x) return(x^2-sin(x)),8)

#calculus
D(expression(exp(x^2)),"x") #derivative
integrate(function(x) x^2,0,1)
