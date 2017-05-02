##other graph:

##bar plot
library(vcd)
#one-way table
counts <- table(Arthritis$Improved)
counts

windows(5,5)
opar <- par(no.readonly=T)
par(mfrow=c(1,2))
barplot(counts,main="Simple bar plot",ylab="Frequency")
barplot(counts,main="Horizontal bar plot",ylab="Improvement",horiz=T,names.arg=c("A","B","C"))


#two-way plot
library(vcd)
counts <- table(Arthritis$Improved, Arthritis$Treatment)
counts
par(mfrow = c(1, 2))
barplot(counts, main="Stacked Bar Plot", xlab="Treatment",
        ylab="Frequency", col=c("red", "yellow","green"), legend=rownames(counts))
barplot(counts, main="Grouped Bar Plot", xlab="Treatment",
        ylab="Frequency", col=c("red", "yellow", "green"),
        legend=rownames(counts), beside=TRUE)

states <- data.frame(state.region, state.x77)
means <- aggregate(states$Illiteracy, by = list(state.region),
                   FUN = mean)
means
barplot(means$x, names.arg = means$Group.1)
title("Mean Illiteracy Rate")



#Pie chart

#1
slices <- c(10,12,4,2,9)
lbls <- c("US","UK","Australia","Germany","France")
pie(slices,labels=lbls,main="Simple Pie Chart")
#2
pct <- round(slices/sum(slices)*100)
lbls2 <- paste(lbls," ",pct,"%",sep=" ")
pie(slices, labels = lbls2, col = rainbow(length(lbls)),
    main = "Pie Chart with Percentages")
#3
library(plotrix)
pie3D(slices, labels = lbls, explode = 0.1, main = "3D Pie Chart ")
#4
mytable <- table(state.region)
lbls <- paste(names(mytable), "\n", mytable, sep = "")
pie(mytable, labels = lbls, main = "Pie Chart from a Table\n (with sample sizes)")


##kernel density plots
windows(5,5)
opar <- par(no.readonly = T)
par(mfrow = c(2, 1))
d <- density(mtcars$mpg)
plot(d)
d <- density(mtcars$mpg)
plot(d, main = "Kernel Density of Miles Per Gallon")
polygon(d, col = "red", border = "blue")
rug(mtcars$mpg, col = "brown")
par(opar)

#show differences between groups
par(lwd = 2)
library(sm)
attach(mtcars)
cyl.f <- factor(cyl, levels = c(4, 6, 8), labels = c("4 cylinder", "6 cylinder", "8 cylinder"))
sm.density.compare(mpg, cyl, xlab = "Miles Per Gallon")
title(main = "MPG Distribution by Car Cylinders")
colfill <- c(2:(1 + length(levels(cyl.f))))
cat("Use mouse to place legend...", "\n\n")
legend(locator(1), levels(cyl.f), fill = colfill)
detach(mtcars)
par(lwd = 1)

##histogram
par(mfrow = c(1, 2))
hist(mtcars$mpg, breaks = 7, col = "yellow", xlab = "Miles Per Gallon",
     main = "Colored histogram with 12 bins")
hist(mtcars$mpg, freq = FALSE, breaks = 12, col = "red", xlab = "Miles Per Gallon",
     main = "Histogram, rug plot, density curve")
rug(mtcars$mpg)
lines(density(mtcars$mpg), col = "blue", lwd = 2)
box()


##boxplot
windows(5,5)
opar <- par(no.readonly = T)
boxplot(mtcars$mpg, main="Box plot", ylab="Miles per Gallon")
boxplot.stats(mtcars$mpg)

par(mfrow = c(1, 2))
boxplot(mpg ~ cyl, data = mtcars, main = "Car Milage Data",
        xlab = "Number of Cylinders", ylab = "Miles Per Gallon")
mtcars$cyl.f <- factor(mtcars$cyl, levels = c(4, 6, 8),
                       labels = c("4", "6", "8"))
mtcars$am.f <- factor(mtcars$am, levels = c(0, 1),
                      labels = c("auto", "standard"))
boxplot(mpg ~ am.f * cyl.f, data = mtcars, varwidth = TRUE, col = c("gold", "darkgreen"),
        main = "MPG Distribution by Auto Type", xlab = "Auto Type")
par(opar)

##dot plot
#windows(width = 7, height = 4)
par(mfrow = c(1, 3))
dotchart(mtcars$mpg, labels = row.names(mtcars), cex = 0.7,
         main = "Gas Milage for Car Models", xlab = "Miles Per Gallon")
dotchart(mtcars$mpg,labels=row.names(mtcars),cex=0.7,groups=cyl.f)
x <- mtcars[order(mtcars$mpg),]
x$cyl <- factor(x$cyl)
x$color[x$cyl == 4] <- "red"
x$color[x$cyl == 6] <- "blue"
x$color[x$cyl == 8] <- "darkgreen"
dotchart(x$mpg, labels = row.names(x), cex = 0.7, pch = 19,
         groups = x$cyl, gcolor = "black", color = x$color,
         main = "Gas Milage for Car Models\ngrouped by cylinder",
         xlab = "Miles Per Gallon")

##bubble plots

attach(mtcars)
par(mfrow=c(1,2))
plot(mpg~wt,data=mtcars)
symbols(wt, mpg, circle=disp)
par(opar)
r <- sqrt(disp/pi)
symbols(wt, mpg, circle=r, inches=0.30,
        fg="white", bg="lightblue",
        main="Bubble Plot with point size proportional to displacement",
        ylab="Miles Per Gallon", xlab="Weight of Car (lbs/1000)")
text(wt, mpg, rownames(mtcars), cex=0.6)
detach(mtcars)


##exercise
raw <- read.csv("avgpm25.csv",header = T)
View(raw)
par(mfrow=c(2,2))
#1
attach(raw)
plot(x=latitude,y=pm25,type = "n")
redpoint <- subset(raw,subset=(region=="west"))
points(x=redpoint$latitude,y=redpoint$pm25,col="red")
blackpoint <- subset(raw,subset=(region=="east"))
points(x=blackpoint$latitude,y=blackpoint$pm25,col="black")
abline(h=12,lty=2)
#2
hist(x=pm25,col="lightgreen")
abline(v=12,col="black",lwd=2)
abline(v=10,col="purple",lwd=2)
#3
boxplot(pm25~region,col="red")
#4
library(plotrix)
counties <- c(dim(blackpoint)[1],dim(redpoint)[1])
pie3D(counties, labels = c("east","west"), explode = 0.1, main = "Number of Counties in Each Region")
detach(raw)
mtext("Wang,Liuying  15420161152156",outer = T)
