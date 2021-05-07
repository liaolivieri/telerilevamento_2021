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


### Day 2

#Dividiamo in 2 classi le nostre immagini (1 agricola, 1 foresta)
#Unsupervised classification
d1c <- unsuperClass(defor1, nClasses= 2)
d1c
plot(d1c$map)
#Class1: foresta
#Class2: agricoltura
#Con la funzione set.seed() si possono avere gli stessi risultati tutte le volte
d2c <- unsuperClass(defor2, nClasses= 2)
d2c
plot(d2c$map)
#Class1: foresta
#Class2: agricoltura
#Facciamo di defor2 3 classi 
d2c3 <- unsuperClass(defor2, nClasses= 3)
plot(d2c3$map)
#Class1: foresta
#Class2: agricoltura
#Andiamo a vedere quanta frequenza c'è delle due classi create
freq(d1c$map)
#class1= 304618
#class2= 36674
#Facciamo la somma
s1 <- 304618 + 36674
#s1= 341292
#Calcoliamo la proporzione tra le due classi
prop1 <- freq(d1c$map) / s1
prop1
#prop foresta: 0.8925436 ,
#prop agricoltura: 0.1074564
#Facciamo lo stesso per la seconda mappa
s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
#prop foresta: 0.5197388
#prop agricoltura: 0.4802612

#Facciamo un dataset 
#cover=Prima colonna fattori (valori categoriche: foresta, agricoltura)
#percent_1992= seconda colonna(valori percetuale 1992)
#percent_2006= terza colonna(valori percentuale 2006)
cover <- c("Forest", "Agriculture")
percent_1992 <- c(89.25, 10.75)
percent_2006 <- c(51.97, 48.03)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#        cover percent_1992 percent_2006
# 1      Forest        89.25        51.97
# 2 Agriculture        10.75        48.03

#Facciamo un grafico con ggplot
#aes=estetica, geom_bar= grafico a barre
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p1
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
p2

#Mettiamo assime i nostri due grafici
grid.arrange(p1, p2, nrow=1)
