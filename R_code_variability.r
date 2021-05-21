#R_code_variability.r

#Pacchetti da installare:
#install.packages("raster")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("gridExtra")
#install.packages("viridis")

#Librerie:
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis) #per colorare i plot di ggplot2

setwd("C:/lab/") #Windows

#Importiamo l'immagine 
sent <- brick("sentinel.png")
#Plottiamo l'immagine con plotRGB così da mostrarne i 3 livelli
#NIR 1, RED 2, GREEN 3
#Già di default la sequenza per questa funzione è r=1, g=2, b=3 quindi possiamo anche evitare di scrivere
plotRGB(sent, stretch="lin")
#è uguale a dire: plotRGB(sent, r=1, g=2, b=3, stretch="lin")
#Se cambiamo l'ordine delle bande mettendo la banda NIR in g avremo la parte vegetale in verde fluorescente
#Le zone in nero sono d'acqua
plotRGB(sent, r=2, g=1, b=3, stretch="lin")
#Nell'immagine sent nominiamo le bande Nir=1, Red=2
nir <- sent$sentinel.1
red <- sent$sentinel.2
#Calcoliamo il NDVI
ndvi <- (nir-red) / (nir+red)
plot(ndvi)
#Facciamo la colorRampPalette
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

#Calcoliamo la variabilità dell'immagine con la funzione focal 
#Deviazione standard in R si dice sd
#w=windows della matrice di ogni pixel su 9 totali, disposti su 3 righe per 3 colonne 
#Meglio calcolare finestre quadrate, più pixel più sarà lungo il calcolo
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
#Cambiamo i colori
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)
#blu e verde= deviazione più bassa; rossa e gialla= deviazione più alta 
#blu=roccia omogenia, verde=zone confine roccia e vegetazione,
#grandi praterie la deviazione standard torna a diminuire perchè molto simili tra di loro come riflettanza

#Calcoliamo la media del ndvi
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
plot(ndvimean3, col=clsd)
#Valori molto alti per i boschi e le praterie, valori più bassi per la roccia nuda

#Cambiamo la grandezza della nostra moving windows (deve essere sempre dispari)
#Usiamo 13*13 pixel 
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
plot(ndvisd13, col=clsd)

#cambiano ancora la gradezza
#usiamo 5*5 pixel
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
plot(ndvisd5, col=clsd)


#Possiamo usare un'altra tecnica la PCA ed usiamo solo la prima componente principale con la funzione rasterPCA
#PCA di sent
sentpca <- rasterPCA(sent)
plot(sentpca$map)
#PC1 è la migliore, man mano che passiamo alle altre le informazioni diminuisono drasticamente
sentpca
#Vediamo quanta proporzione di varianza viene spiegata in ogni componente
summary(sentpca$model)
#                          Comp.1     Comp.2      Comp.3 Comp.4
# Standard deviation     77.3362848 53.5145531 5.765599616      0
# Proportion of Variance  0.6736804  0.3225753 0.003744348      0
# Cumulative Proportion   0.6736804  0.9962557 1.000000000      1
#la prima PC continente il 67,36804% della informazione originale


### Day 2
pc1 <- sentpca$map$PC1

#Funzione focal con la PC1, facciamo la sd di una sola banda
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(pc1sd5, col=clsd)

#Usiamo la funzione source per mettere in R un pezzo di codice salvato in un file
#Non dobbiamo copiare e incollare il codice con questa funzione
source("source_test_lezione.r")

source("source_ggplot.r")

#Fare una nuova finestra con ggplot vuota
ggplot()
#Aggiungiamo un blocco a ggplot
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer))
#Aggungiamo la funzione per le legende di viridis
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()
#Aggiungiamo un titolo alla nostra mappa
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation of PC1 by viridis colour scale")

#Scegliamo noi una legenda da viridis: magma
p1 <- ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") +
ggtitle("Standard deviation of PC1 by magma colour scale")

#Scegliamo noi un'altra legenda da virids: inferno
p2 <- ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno") +
ggtitle("Standard deviation of PC1 by inferno colour scale")

#Scegliamo noi un'altra legenda da virids: turbo
p3 <- ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="turbo") +
ggtitle("Standard deviation of PC1 by turbo colour scale")

#Possiamo mettere tutte queste legende tutte in una volta (1magma=p1, 1inferno=p2, 1turbo=p3) con la funzione grid.arrage
grid.arrange(p1, p2, p3, nrow=1)
