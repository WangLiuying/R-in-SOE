##lattice
library(lattice)
#xyplot(y~x|f*g,data,option)
library(datasets)
windows(5,5)
airquality <- transform(airquality, Month = factor(Month))
xyplot(Ozone ~ Wind | Month, data = airquality, layout = c(5, 1))

xyplot(mpg~wt|cyl,data=mtcars)

#区别|和group
densityplot(~mpg|cyl,data=mtcars)

densityplot(~mpg,data=mtcars,group=cyl)

#scatter matrix
splom(mtcars[,c(1,3,4,5,6)])

#3d
cloud(mpg~wt*qsec|cyl,data=mtcars,main="main title")

#调图
mygraph <- densityplot(~mpg|cyl,data=mtcars,main="main title",xlab="Miles per gallon")
mygraph
update(mygraph,col="red",pch=12,cex=0.8,lwd=3)

#连续变量作栅格图
help(mtcars)
displacement <- equal.count(mtcars$disp,number=3,overlap=0)
xyplot(mpg~wt|displacement,data=mtcars)


#cheat sheet
show.settings()



#example 雷达图和风玫瑰图
load("wind9am.rdata")
load("hourlySpeed.rdata")
head(wind9am)
head(hourlySpeed)
library(plotrix)
with(wind9am,
     {
       polar.plot(Speed, Dir, rp.type="s",
                  start=90, clockwise=TRUE,
                  point.symbols=16,
                  point.col=rgb(0,0,0, .3*Speed/max(Speed)))
     })
library(openair)
with(wind9am,
     polarFreq(data.frame(ws=Speed, wd=Dir, date=Date),
               cols=rainbow(256), border.col="black"))
hourSpeed <- aggregate(hourlySpeed["Speed"],
                       list(hour=hourlySpeed$hour),
                       mean)
head(hourSpeed)
polar.plot(hourSpeed$Speed, hourSpeed$hour * 15,
           start=90, clockwise=TRUE, lwd=5,
           label.pos=seq(15, 360, 15), labels=1:24,
           radial.lim=c(0, 4.5))
with(wind9am,
     windRose(data.frame(ws=Speed, wd=Dir,
                         date=Date, station=factor(Station)),
              paddle=FALSE,
              type="station", cols=gray(4:1/6), width=2))


##ggplot2
library(ggplot2)
data(mpg)
str(mpg)

qplot(displ,hwy,data=mpg,color=drv,geom=c("point","smooth"))


qplot(hwy,data=mpg,fill=drv)

qplot(displ,hwy,data=mpg,facets=.~drv)
qplot(displ,hwy,data=mpg,facets=trans~drv)
qplot(hwy,data=mpg,facets=drv~.)


#compare
plot(displ~hwy,data=mpg)
qplot(displ,hwy,data=mpg)


#save
ggsave(file="test.pdf")
ggsave(file="test.jpeg",dpi=72)

#ggplot vs qplot

p <- ggplot(data=mpg,aes(x=displ,y=hwy,colour=factor(cyl)))
p+geom_point()+geom_smooth()+theme_bw()

##Maps
install.packages("maps")
library(maps)
help(package="maps")
map("world",fill=TRUE,col=rainbow(250),ylim=c(-90,90))
title("World map")

opar <- par(no.readonly = TRUE)
par(mfrow = c(2, 2))
par(mar = rep(1, 4))
map(regions="Brazil", fill=TRUE, col="gray")
map(regions="france", fill=TRUE, col="gray")
map(regions="italy", fill=TRUE, col="gray")
map(regions="Norway", fill=TRUE, col="gray")

#install.packages('mapdata')
library(mapdata)
## Warning: package ’mapdata’ was built under R version 3.3.3
map("china",col="black",ylim=c(18,54),panel.first=grid())
title("china_map")


library(maptools)
map.2<-readShapePoly(file.choose())
#View(map.2)
summary(map.2)
#1
sp::plot(map.2,col=rainbow(200),ylim = c(18, 54), panel.first = grid(),axes=TRUE, border="gray")
#2
#install.packages('ggplot2')
library(ggplot2)
map.3<-fortify(map.2) #convert to data.frame
ggplot(map.3, aes(x = long, y = lat, group = group))+
  geom_polygon( )+
  geom_path(colour = "grey40")+
  scale_fill_manual(values=colours(),guide=FALSE)


###NEED VPN
#install.packages('ggmap')
#install.packages('mapproj')
library(ggmap)
#library(mapproj)
## Download data from Google (need VPN)
map <- get_map(location = 'China', zoom = 4)
ggmap(map)
map <- get_map(location = 'Xiamen', zoom = 13, maptype = 'roadmap')
ggmap(map)
map <- get_map(location = 'Xiamen University of China', zoom = 15,
               maptype = 'satellite')
ggmap(map)

library(googleVis)
G1 <- gvisGeoMap(Exports, locationvar='Country', numvar='Profit',
                 options=list(dataMode="regions"))
plot(G1)

