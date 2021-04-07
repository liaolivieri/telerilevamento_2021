#Time series analysis 
#Greenland increase of temperature
#Data and code from Emanuela Cosma

#Pacchetti da installare
#install.packages("raster")
#install.packages("rasterVis")

#Librerie che ci permettono di usare i nostri pacchetti installati:
library(raster)
library(rasterVis)

setwd("C:/lab/greenland") # Windows

#La funzione per caricaricare singoli dati è raster (del pacchetto raster)
#Carichiamo tutti le immagini lst della groenlandia del 2000, 2005, 2010, 2015
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

#Fare un pannello con le 4 immagini:
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
#Importiamo le immagini tutte insieme con la funzione: lapply
#Prima facciamo la lista dei nostri file per poter usare la funzione lapply
#con il pattern identifichiamo la scritta in comune a tutti i file quindi nel nostro caso lst
rlist <- list.files(pattern="lst")
rlist
#Ora che abbiamo la nostra lista con i nostri file applichiamo lapply a tutta la lista associata alla funzione raster
import <- lapply(rlist,raster)
import
#Impaccettiamo i file con la funzione stack 
TGr <- stack(import)
#Quindi adesso possiamo plottare direttamente il pacchetto TGr
plot(TGr)








