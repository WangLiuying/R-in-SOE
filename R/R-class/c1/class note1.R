##配置java
Sys.setenv(JAVA_HOME="C:/Program Files (x86)/Java/jre1.8.0_121")

##china map
install.packages("ggmap")
install.packages("mapproj")
library(ggmap)
library(mapproj)
map <- get_map(location = 'China', zoom = 4)
ggmap(map)
map <- get_map(location = 'Beijing', zoom = 10, maptype = 'roadmap')
ggmap(map)

##world map
install.packages("maps")
library(maps)
map("world", fill = TRUE, col = rainbow(200),
    ylim = c(-60, 90), mar = c(0, 0, 0, 0))
title("world map")

##brownian movement
install.packages("R2SWF")
library(R2SWF)
if (capabilities("cairo")) {
        olddir = setwd(tempdir())
        svg("Rplot%03d.svg", onefile = FALSE)
        set.seed(123)
        x = rnorm(5)
        y = rnorm(5)
        for (i in 1:100) {
                plot(x <- x + 0.1 * rnorm(5), y <- y + 0.1 * rnorm(5), xlim = c(-3,
                                                                                3), ylim = c(-3, 3), col = "steelblue", pch = 16, cex = 2, xlab = "x",
                     ylab = "y")
        }
        dev.off()
        output = svg2swf(sprintf("Rplot%03d.svg", 1:100), interval = 0.1)
        swf2html(output)
        setwd(olddir)
}

##kmeans

install.packages("animation")
library(animation)
output = dev2swf({
        par(mar = c(3, 3, 1, 1.5), mgp = c(1.5, 0.5, 0))
        kmeans.ani()
}, output = "test.swf")
swf2html(output)