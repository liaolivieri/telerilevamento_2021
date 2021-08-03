# R_code_spectral_signatures.r

# Librerie
library(raster)
library(rgdal) #libreria GDAL
library(ggplot2)

setwd("C:/lab/") #Windwos

# Carichiamo il dataset con tutte le bande
defor2 <- brick("defor2.jpg")
# defor2.1, defor2.2, defor2.3
#   NIR,      red,      green

plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

# Creamo delle firme spettrali con la funzione "click"
#T=true, type=point, pch= è la forma del point
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# cliccando su un pixel di vegetazione abbiamo: B1=valore molto alto, B2=valore molto basso, B3=valore medio basso 
# cliccando su un pixel d'acqua abbiamo: B1=valore basso, B2=valore alta, B3= valore più alto
# Results:
#       x     y   cell defor2.1 defor2.2 defor2.3
# 1 151.5 287.5 136382      202       12       24
#       x     y   cell defor2.1 defor2.2 defor2.3
# 1 209.5 163.5 225348       47       53       89

# Define the columns of the dataset:
band <- c(1,2,3)
forest <- c(202, 12, 24)
water <- c(47, 53, 89)
# Create the data frame
spectrals <- data.frame(band, forest, water)

# Plot the spectral signtures
#definiamo subito l'asse x, nella x mettiamo le bande, nella y mettiamo la riflettanza foresta e acqua
#geom_line inserisce le geometrie nel mio plot aperto in precedenza dalla funzione ggplot
ggplot(spectrals, aes(x=band)) +
geom_line(aes(y = forest), color="green") +
geom_line(aes(y= water), color="blue")
labs(x="band", y="reflectance")

###### Multitemporal
# Facciamo questa analisi in modo multitemporale utilizzando defor1 e defor2
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
# Spectral signature defor 1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Results time 1:
#     x     y   cell defor1.1 defor1.2 defor1.3
# 1 52.5 330.5 105011      219       23       37
#      x     y   cell defor1.1 defor1.2 defor1.3
# 1 87.5 324.5 109330      204        9       25
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 91.5 373.5 74348      226       25       43
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 74.5 375.5 72903      221        4       31
#      x     y   cell defor1.1 defor1.2 defor1.3
# 1 68.5 313.5 117165      201       13       27

# Spectral signature defor 2
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Result time 2:
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 62.5 331.5 104745      156      143      134
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 97.5 334.5 102629      185      165      156
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 97.5 311.5 119120      147      139      128
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 64.5 350.5 91124      174      166      155
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 41.5 359.5 84648      181      173      160

#Creiamo il nostro dataset con i risultati ottenuti
band <- c(1,2,3)
time1 <- c(219, 23, 37)
time1p2 <- c(204, 9, 25)
time2 <- c(156, 143, 134)
time2p2 <- c(185, 165, 156)
spectralst <- data.frame(band, time1, time2, time1p2, time2p2)

ggplot(spectrals, aes(x=band)) +
geom_line(aes(y = time1), color="red", linetype="dotted") +
geom_line(aes(y = time1p2), color="red", linetype="dotted") +
geom_line(aes(y= time2), color="black", linetype="dotted") +
geom_line(aes(y= time2p2), color="black", linetype="dotted") +
labs(x="band", y="reflectance")


### Image from Earth Observatory

eo <- brick("july2021_puzzler.png")
plotRGB(eo, 1,2,3, stretch="hist")
# Spectral signature 
click(eo, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Results:
#     x     y  cell july2021_puzzler.1 july2021_puzzler.2 july2021_puzzler.3
# 1 106.5 426.5 38267                183                168                145
#   july2021_puzzler.4
# 1                255
#       x     y   cell july2021_puzzler.1 july2021_puzzler.2 july2021_puzzler.3
# 1 145.5 293.5 134066                 42                 51                 39
#   july2021_puzzler.4
# 1                255
#       x     y   cell july2021_puzzler.1 july2021_puzzler.2 july2021_puzzler.3
# 1 415.5 108.5 267536                159                145                110
#   july2021_puzzler.4
# 1                255

#Creazione del dataset
band <- c(1,2,3)
stratum1 <- c(183, 168, 145)
stratum2 <- c(42, 51, 39)
stratum3 <- c(159, 145, 110)

spectralsg <- data.frame(band, stratum1, stratum2, stratum3)

ggplot(spectralsg, aes(x=band)) +
geom_line(aes(y = stratum1), color="yellow") +
geom_line(aes(y = stratum2), color="green") +
geom_line(aes(y= stratum3), color="blue") +
labs(x="band", y="reflectance")




