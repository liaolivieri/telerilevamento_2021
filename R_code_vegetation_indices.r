#R_code_vegetation_indices.r

#Pacchetti da installare
#install.packages("raster")
#install.packages("RStoolbox")
#install.packages("rasterdiv") #for worlwide NDVI

#Librerie:
library(raster) #oppure anche require(raster)
library(RStoolbox) #per gli indici della vegetazione
library(rasterdiv) #per il NDVI globale
library(rasterVis)

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

#RStoolbox: funzione spectralIndices con la quale posso calcolare tutti gli indici
#b1=NIR, b2=red, b3=green
vi1 <- spectralIndices(defor1, green=3, red=2, nir=1)
plot(vi1, col=cl)
#Facciamolo per la seconda immagine
vi2 <- spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)

#Differenza NDVI
difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)

### Day 3
# worldwide NDVI

#Vediamo NDVI mondiale 
plot(copNDVI)
#Togliamo l'acqua dalla visualizzazione, trasformandoli in non valori
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
#Vediamo l'NDVI in modo globale senza l'acqua
plot(copNDVI)

#rasterVis
levelplot(copNDVI)
