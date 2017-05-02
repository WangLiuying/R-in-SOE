# scatter plot
library(car)
scatterplot(mpg ~ wt | cyl, data=mtcars, lwd=2,
            main="Scatter Plot of MPG vs. Weight by # Cylinders",
            xlab="Weight of Car (lbs/1000)",
            ylab="Miles Per Gallon",
            legend.plot=TRUE,
            id.method="identify",
            labels=row.names(mtcars),
            boxplots="xy"
)

#高密度散点图
set.seed(1234)
n <- 10000
c1 <- matrix(rnorm(n, mean=0, sd=.5), ncol=2)
c2 <- matrix(rnorm(n, mean=3, sd=2), ncol=2)
mydata <- rbind(c1, c2)
mydata <- as.data.frame(mydata)
names(mydata) <- c("x", "y")
with(mydata, plot(x, y, pch=19, main="Scatter Plot with 10,000 Observations"))
with(mydata, smoothScatter(x, y,
                           main="Scatterplot Colored by Smoothed Densities"))
#散点矩阵图
pairs(~mpg+disp+drat+wt, data=mtcars, main="Basic Scatter Plot Matrix",
      upper.panel=NULL)

library(car)
scatterplotMatrix(~ mpg + disp + drat + wt, data=mtcars,
                  spread=FALSE, lty.smooth=2, main="Scatter Plot Matrix via car Package")
scatterplotMatrix(~ mpg + disp + drat + wt | cyl,
                  data=mtcars, spread=FALSE, diagonal="histogram", main="Scatter Plot Matrix via car Package")

#3d散点图
library(scatterplot3d)

x1 <- 1;x2 <- 2;x3 <- 3

n=10000
y1 <- rnorm(n,0,x1)
y2 <- rnorm(n,0,x2)
y3 <- rnorm(n,0,x3)
x <- c(rep(x1,n),rep(x2,n),rep(x3,n))
y <- c(y1,y2,y3)
z <- c(dnorm(y1,0,x1),dnorm(y2,0,x2),dnorm(y3,0,x3))
ma.dat <- data.frame(x=x,y=y,z=z)
var3d <- scatterplot3d(ma.dat,lwd=2,pch=46,
                       box=F,type="p")

with(mtcars,scatterplot3d(wt, disp, mpg, main="Basic 3D Scatter Plot"))
attach(mtcars)
scatterplot3d(wt, disp, mpg, pch=16, highlight.3d=TRUE,
              type="h", main="3D Scatter Plot with Vertical Lines")

s3d <-scatterplot3d(wt, disp, mpg, pch=16, highlight.3d=TRUE,
                    type="h", main="3D Scatter Plot with Vertical Lines and Regression Plane")
fit <- lm(mpg ~ wt+disp)
s3d$plane3d(fit)

##其他3d散点图
library(rgl)
plot3d(wt,disp,mpg,col="red",size=5)

library(Rcmdr)
scatter3d(wt, disp, mpg)
detach(mtcars)

##exercise
library(datasets)
View(airquality)

mydata <- airquality
mydata$Month <- ifelse(mydata$Month==5,"May","Other Month")
mydata$Month <- as.factor(mydata$Month)

#1
with(airquality,plot(Wind,Ozone,main="Ozone and Wind",type="n"))
with(subset(airquality,Month==5),
     points(Wind,Ozone,col="blue"))
with(subset(airquality,Month!=5),
     points(Wind,Ozone,col="red"))
legend("topright",pch=1,col=c("blue","red"),legend=c("May","Other"))
model <- lm(Ozone~Wind,airquality)
abline(model,lwd=2)
#2
opar <- par(no.readonly = TRUE)
par(mfrow=c(1,3),mar=c(4,4,2,1),oma=c(0,0,2,2))
with(mydata,{
  plot(Wind,Ozone,main="Ozone and Wind")
  plot(Solar.R,Ozone,main="Ozone and Solar Radiation")
  plot(Temp,Ozone,main="Ozone and Temperature")
  mtext("Ozone and Weather in New York City",outer=T)
})
