##class 17/2/23

#setwd("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c2")

#start
##save the path
#mine<-getwd()
#setwd("c:\\temp")
#setwd(mine)
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
#一个窗口化的界面，使用commender呼出

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
2*1:5
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


#matrix
x <- 1:5
y <- 2*1:5
x*y
t(x)%*%y
crossprod(x,y)
tcrossprod(x,y)
outer(x,y)
(A <- matrix(1:6,nrow=2))
t(A)
dim(A)
nrow(A)
ncol(A)

##subsetting a Matrix
(B <- A[1,])
C <- A[,1]
D <- A[2,2]
D
class(D)
(E <- A[2,2,drop=FALSE])
class(E)
(F <- A[1,,drop=FALSE])
A1 <- A[,-2]
A1
det(A1)#determine
eigen(A1)
solve(A1)
A1%*%solve(A1)
diag(4) #4*4 indentity
diag(2,4,4) #4*4 element=4
diag(rep(c(1,2),c(3,3)))

B <- svd(A1)
B$u%*%diag(B$D)%*%t(B$v)

qr(A1)
cbind(1,A1)
rbind(A1,diag(4,2))
x <- runif(20)
summary(x)
hist(x)

#exercise
a <- matrix(c(1,-1,1,1),nrow = 2)
b <- c(2,4)
solve(a,b)

#set operation
x <- c(1,2,5)
y <- c(5,1,8,9)
union(x,y)
intersect(x,y)
setdiff(x,y)
setdiff(y,x)
setequal(x,y)
setequal(x,c(1,2,5))
2 %in% x
2 %in% y
choose(5,2)#组合数：5选2

x <- c(13,5,12)
sort(x)
x
x <- sort(x)


#2.2 Complex numbers in R
z <- 3.5-8i
Re(z)
Im(z)
Mod(z)
Conj(z)
is.complex(z)

x <- sqrt(2)
x*x==2

x <- 0.3-0.2
y <- 0.1
x==y
identical(x,y)
all.equal(x,y) #注意

#3.Data structures
rm(list=ls())
data(mtcars)
View(mtcars)
attributes(mtcars)
example("attributes")
class(mtcars)

a <- c(1,2,5,3,6,-2,4)
b <- c("one","two","three")
c <- c(T,T,T,F,T,T)

y <- matrix(1:20,nrow=5)
cells <- c(1,26,24,68)
rnames <- c("R1","R2")
cnames <- c("C1","C2")
mymatrix <- matrix(cells,nrow=2,ncol=2,byrow=T,dimnames=list(rnames,cnames))
dim(mymatrix)
mymatrix

str(mtcars)

#exercise
#install.packages("pixmap")
library(pixmap)
mtrush1 <- read.pnm("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c2/Data_Chap_2/mtrush1.pgm")
mtrush1
plot(mtrush1)
str(mtrush1)
#install.packages("pryr")
library(pryr)
mtrush1@grey[28,88]
locator()
#pixmap是自上而下计算坐标，而locator是自下往上进行计算
mtrush2 <- mtrush1
mtrush2@grey[84:163,135:177] <- 1  #像素算法和locator算法是反的哦
plot(mtrush2)

blurpart <- function(img,rows,cols,q) {
  lrows <- length(rows)
  lcols <- length(cols)
  newimg <- img
  randomnoise <- matrix(nrow=lrows,ncol=lcols,runif(lrows*lcols))
  newimg@grey[rows,cols] <- (1-q)*img@grey[rows,cols]+q*randomnoise
  newimg
}

#array
z <- 1:24
dim1 <- c("A1","A2")
dim2 <- c("B1","B2","B3")
dim3 <- c("C1","C2","C3","C4")
(z <- array(1:24,c(2,3,4),dimnames=list(dim1,dim2,dim3)))
#array transposition
A <- array(1:24,dim=c(2,3,4));A
B <- aperm(A,c(2,3,1));B;dim(B)

#data frame
patientID <- c(1,2,3,4)
age <- c(25,34,28,52)
diabetes <- c("Type1","Type2","Type1","Type1")
status <- c("Poor","Improved","Excellent","Poor")
class(patientID);class(age);class(diabetes);class(status)
patientdata1 <- cbind(patientID,age,diabetes,status)
patientdata1
class(patientdata1)
class(patientdata1[,1])
class(patientdata2[,2])
?data.frame
patientdata2 <- data.frame(patientID,age,diabetes,status)
class(patientdata2$age)
class(patientdata2$diabetes)
str(patientdata2)
is.data.frame(patientdata1)
is.data.frame(patientdata2)
#index
patientdata2[4]
patientdata2["status"]
patientdata2$status
patientdata2[,4]
#index more than one column
patientdata2[1:2]
patientdata2[c(1,3)]
patientdata2[c("diabetes","status")]
patientdata2$age
patientdata2["s"]
#subset
subset(patientdata2,age>30)
subset(patientdata2,age>30,select=c(patientID,status))
subset(patientdata2,age>30,select=-age)
subset(patientdata2,age>30,select=c(age:status))
#you can delete a list component by setting it to NULL
patientdata2[2] <- NULL
patientdata2 #厉害了
#add a column 
patientdata2$patientID <- patientID
patientdata2

#factor
str(status)
status <- factor(status,ordered=T)
status
status <- factor(status,ordered=T,levels=c("Poor","Improved","Excellent"))
status
status <- factor(status,ordered=T,levels=c("Poor","Improved","Excellent"),labels=c("A","B","C"))
status

#another example
a <- c("A","C","B","C")
class(a)
b <- as.factor(a)
b
b[5] <- "D" #error
c <- as.vector(b)
c[5] <- "D"
b <- as.vector(c)
b
#factor take more space than character
object.size(a)
b <- as.factor(a)
object.size(b)

#logical operations
isTRUE(6>4)
!isTRUE(8 != 5)
! isTRUE(4<3)
isTRUE(!TRUE)

identical(4,3.1)
identical(5>4,3<3.1)
identical(5>4,3>3.1)

xor(5==6,!FALSE)
xor(!!TRUE,!!FALSE)
xor(identical(xor,"xor"),7==7.0)

#use the which() function to find the indicis 
ints <- sample(10)
sample(10,5)
ints>5
which(ints>7)
int[which(ints>7)]
which.max(ints)
ints[which.max(ints)]
ints[which.min(ints)]

help("&&")
TRUE & c(T,T,F)
TRUE && c(T,T,F)
FALSE | c(T,T,F)
FALSE || c(T,T,F)

#type conversions
ab <- c(1,2,3)
is.numeric(ab)
is.vector(ab)
ab <- as.character(ab)
is.numeric(ab)
is.vector(ab)

#drawback of data.frame
patientID <- c(1,2,3,4)
age <- c(25,34,28,NA)
diabetes <- c("type1","type2","type1","type1")
status <- c("poor","improved","excellent","poor")
patientdata <- data.frame(patientID,age,diabetes,status)
#list
Lst <- list(name="Fred",wife="Mary",child.ages=c(4,7,9))
Lst
Lst[[2]];Lst[2]
Lst[[3]];Lst[[3]][2]
Lst[["name"]]
Lst$child.ages[2]
Lst$child.ages;Lst[[2]]

z <- list(a="abc",b=12)
z$c <- "sailing" #add a component c
z
#you can delete by
z$b <- NULL
z

#partial matching
x <- list(aardvark=1:5)
x$a
x[["a"]]
x[["a",exact=FALSE]]

#统计词频的例子
?scan
txt <- scan("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c2/Data_Chap_2/testconcorda.txt","")
txt
cat(txt)

findwords <- function(tf) {
  # read in the words from the file, into a vector of mode character
  txt <- scan(tf,"")
  wl <- list()
  for (i in 1:length(txt)) {
    wrd <- txt[i]  # i-th word in input file
    wl[[wrd]] <- c(wl[[wrd]],i)
  }
  return(wl)
}
countWord <- findwords("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c2/Data_Chap_2/testconcorda.txt")


#formula
f <- y~x
f
class(f)
?lm
data(mtcars)
lm(formula=mpg~hp,data=mtcars)

#missing value
x <- c(1,2,NaN,NA,4)
#NaN not a number
1/0
0/0
is.na(x)
is.nan(x)

#attach()\detach()\with()
View(mtcars)
View(mpg) #error
View(mtcars$mpg)
summary(mpg) #error
summary(mtcars$mpg)
plot(mtcars$mpg,mtcars$disp)

attach(mtcars) #把数据加载到搜索路径中
summary(mpg)
plot(mpg,disp)
detach(mtcars)

with(mtcars,{
  summary(mpg,disp,wt)
  plot(mpg,disp)
  plot(mpg,wt)
})
with(mtcars, {
  nokeepstats <- summary(mpg)
  keepstats <<- summary(mpg) 
})
nokeepstats
keepstats

#attach misery
#entering the same attach command twice
#especially notice "for" loop
search() #搜索路径
attach(mtcars)
attach(mtcars)
search()
detach(mtcars)
search()
mtcars
str(mtcars)
as.character(mpg)
attach(mtcars)
mpg
detach(mtcars);detach(mtcars)
search()


#data input
setwd("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c2")
#install.packages("rJava")
#install.packages("xlsx")
library(rJava)
library(xlsx)
#Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_121")
Sys.getenv()#查看环境路径设定
auto <- read.xlsx("Data_Chap_2/auto.xlsx",1,header=TRUE,as.data.frame=TRUE)


#1
mydata <- data.frame(age=numeric(0),gender=character(0))
View(mydata)
mydata <- edit(mydata)
class(mydata$gender)
rm(mydata)

#2
x <- numeric(10)
data.entry(x)
x

#3
aa <- scan
setwd("D:/DataAnalysis/R's workingspace/R-class XuHaifeng/R/R-class/c2/Data_Chap_2")
#scan
read.table(file="rt.txt") #error
rt <- scan(file="rt.txt")
rt <- scan(file="rt.txt",sep="\n")
rt <- scan(file="rt.txt",sep="\t")
rt <- scan(file=file.choose(),sep="\t")

rt <- sapply(1:5,function(i){
  as.numeric(na.omit(
    scan("rt.txt",sep="\t",quiet=T)[(4*i-3):(4*i)]
  ))
})
weight <- scan(file="weight.data")
Forest <- scan(file="ForestData.txt",what=double(),skip=10)#error
?scan
#scan优势，速度快，但是读入数据类型单一，
Forest <- read.table(file="ForestData.txt")
View(Forest)
Forest <- read.table(file="ForestData.txt",header=T)
View(Forest)
str(Forest)
names(Forest)
Forest <- read.table(file="ForestData.txt",header=T,stringsAsFactors = F)
str(Forest)
Forest <- read.table(file="ForestData.txt",header=T,colClasses = c("integer","integer",
                                                                   "character","double","integer","double","double","double"))
#sep参数改分隔；
Forest <- read.delim(file="ForestData.txt")
#read.delim默认有header

data2 <- read.table("http://www.bio.ic.ac.uk/research/mjcraw/therbook/data/cancer.txt",
                    header=T)
head(data2)

urlhandle <- url("http://www.math.smith.edu/r/testdata")
ds <- readLines(urlhandle)
ds <- read.table("http://www.math.smith.edu/r/testdata")

#Excel
library("xlsx")
Forest <- read.xlsx("ForestData.xlsx",1,header=T,as.data.frame = T)
str(Forest)
levels(Forest$month)
Forest$month <- factor(Forest$month,order=T,
                       levels=c("jan","feb","mar","apr","may","jun",
                                "jul","aug","sep","oct","nov","dec"))
levels(Forest$month)

#stata
library("foreign")
auto <- read.dta("auto.dta")
head(auto)

#clipboard
TRData <- read.table("clipboard",header=T,sep=" ")

#country countryisocode year PPP
#afghanistan AFG 2010 23.81
#albania ALB 2010 58.26
#

TRData1 <- read.csv("clipboard",sep=" ")

#Built-in data
data("iris")
str(iris)
try(data(package="MASS"))
data(package=.packages(all.available=T))


##Data Output
#Saving history
history(Inf)
#savehistory
#loadhistory

#saving graphics
plot(mtcars$wt~mtcars$mpg)
pdf("fig1.pdf")
plot(mtcars$wt~mtcars$mpg)
dev.off()

#expporting data to ascii file
For.sep <- Forest[Forest$month=="sep",]
write.table(For.sep,file="For_sep.txt",sep=" ",quote=F,append=F,na="NA")

#save as a R data file
save(For.sep,file="For_sep.Rdata")
load("For_sep.Rdata")
save(list=ls(all=T),file="all.Rdata")


writeClipboard(as.character(factor.name))
file.exists("Decay.txt")

#Ctex
#Lyx smaller
#package knitr


#install.packages("XML")
#install.packages("RCurl")
#install.packages("stringr")
library(XML)
library(RCurl)
library(stringr)
url <- "http://www.stateair.net/web/historical/1/1.html"
page_parse <- htmlParse(url,encoding="UTF-8")
links <- getHTMLLinks(url)
filename <- "Beijing_2017_HourlyPM25_created20170301.csv"
url1 <- "http://www.stateair.net/web/assets/historical/1/"
u.full <- paste(url1,filename,sep="")
Beijing.2017 <- read.csv(u.full,skip=3,encoding="utf-8")
class(Beijing.2017)
head(Beijing.2017)
#编码转换
Beijing.2017$Unit <- iconv(Beijing.2017$Unit,from="windows-1252",to="GB2312")
head(Beijing.2017)

#have a try
links
csvlinks <-str_detect(links,pattern="http://www.stateair.net.+.csv")
csvlinks <- links[csvlinks]
Beijing.air <- data.frame()
for (i in seq_along(csvlinks))
{
  if (i==1) Beijing.air <- read.csv(csvlinks[i],skip=3,encoding="utf-8")
  Beijing.air1 <- read.csv(csvlinks[i],skip=3,encoding="utf-8")
  Beijing.air <- rbind(Beijing.air,Beijing.air1)
  Sys.sleep(3)
}

#teacher version
linkcsv <- links[str_detect(string=links,".csv")]
linkcsv
linkcsv_list <- as.list(linkcsv)
linkcsv_list
#execute download
all.data <- data.frame
for(i in 1:length(linkcsv_list))
{
  all.data <- rbind(all.data,read.csv(linkcsv_list[[i]],skip=3,encoding="utf-8"))
  Sys.sleep(3)
}


#中文pdf制作（待学）
devtools::install_github("yihui/xaringan")
devtools::install_github("rstudio/addinexamples",type="source")



install.packages("wordcloud2")
library(wordcloud2)
wf <- wordfreq(words) #udf
wordcloud2(wf,color="random-light",backgroundcolor="grey")