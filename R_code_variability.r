#R_code_variability.r

#Pacchetti da installare:
#install.packages("raster")
#install.packages("RStoolbox")

#Librerie:
library(raster)
library(RStoolbox)

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
#w=windows della matrice di ogni pixel su 9, su 3 righe e 3 colonne 
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
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=3, ncol=3), fun=sd)
plot(ndvisd13, col=clsd)













