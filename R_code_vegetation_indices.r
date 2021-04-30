#R_code_vegetation_indices.r

library(raster) #oppure anche require(raster)

setwd("C:/lab/") #Windows

#Carichiamo le immagini 
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#Plottiamo le immagini 
#b1=NIR, b2=red, b3=green
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

### Day 2

#Vediamo come si chiamano le componenti/variabili del Nir e del red
defor1
#NIR=defor1.1 , RED=defor1.2
#Facciamo il primo indice dvi1= (banda dell'infrarosso) - (banda del rosso)
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)
#Cambiamo i colori
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")

#Facciamo la stesso procedura per il dvi2
defor2
#NIR=defor2.1 , RED=defor2.2
#Facciamo il secondo indice dvi2= (banda dell'infrarosso) - (banda del rosso)
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")

#Plottiamoli assime per capirne meglio le differenze
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#Per vedere la differenza possiamo fare la differenza dei due dvi
difdvi <- dvi1 - dvi2
#Visualizziamolo anche nella mappa per vedere meglio il confronto
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

#Calcoliamo l'ndvi1
# NDVI= (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)
#la stessa cosa la possiamo scricere ache così:
#ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
#plot(ndvi1, col=cl)

#Calcoliamo l'ndvi2
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)
#la stessa cosa la possiamo scricere ache così:
#ndvi2 <- dvi2 / (defor2$defor2.1 + defor2$defor2.2)
#plot(ndvi2, col=cl)










