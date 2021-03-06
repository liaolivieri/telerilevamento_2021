#R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("C:/lab/") #Windows

#Carichiamo la foto con tutte la bande
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

#Plot dei valori pixel della banda 1 contro quelli della banda 2
#col=cambio colore dei punti, pch=forma dei punti, cex=dimensione punti
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

#Per mostrare tutte le correlazioni possibili tra tutte le variabili si può la funzione pairs
pairs(p224r63_2011)

### Day 2

#Riduciamo la dimensione della nostra immagine con la funzione aggregrate (aggrega i pixel)
#resampling=ricampionamento
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res

#Confrontiamo le due immagini per vederne la differenza
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

#rasterPCA: prende il pacchetto di dati e li compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#La funzione summary ci da un sommario del nostro modello, vediamo la varianza delle varie componenti delle bande
summary(p224r63_2011res_pca$model)
#vediamolo anche graficamente
plot(p224r63_2011res_pca$map)

#vediamo tutto quello che abbiamo generato fino ad adesso
p224r63_2011res_pca

#plottiamo la mappa risultante con RGB
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

#La funzione str ci da informazioni sulla struttura del file e informazioni aggiuntive
str(p224r63_2011res_pca)
