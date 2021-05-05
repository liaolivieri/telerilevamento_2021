#R_code_land_cover.r

#Pacchetti da istallare:
#install.packages("raster")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("gridExtra")

#Librerie:
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/") # Windows

#Carichiamo la prima immagine
defor1 <- brick("defor1.jpg")
#Plottiamola
#NIR 1, RED 2, GREEN 3
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
#Plottiamola con ggplot che ci permette di avere anche le cordinate
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

#Carichiamo e facciamo lo stesso con la seconda immagine
defor2 <- brick("defor2.jpg")
#NIR 1, RED 2, GREEN 3
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

#Multiframe with plotRGB
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#Multiframe with ggplot2 e gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)







