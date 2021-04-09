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
#Facciamo un pannello con le 4 immagini:
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#Importiamo le immagini tutte insieme con la funzione: lapply
#Prima facciamo la lista dei nostri file per poter usare questa funzione
#Con il pattern identifichiamo la scritta in comune a tutti i file quindi nel nostro caso lst
rlist <- list.files(pattern="lst")
rlist
#Ora che abbiamo la nostra lista con i nostri file applichiamo lapply a tutta la lista associata alla funzione raster
import <- lapply(rlist,raster)
import
#Impaccettiamo i file con la funzione stack 
TGr <- stack(import)
#Quindi adesso possiamo plottare direttamente il pacchetto TGr
plot(TGr)
#Possiamo plottarle tutte assime con RGB
#1=mappa 2000, 2=mappa 2005, 3=mappa 2010, 4=mappa 2015
#Mappa blu del 2010 (perchè B=3) 
plotRGB(TGr, 1, 2, 3, stretch="Lin")
#Mappa blu del 2015(perchè B=4)
plotRGB(TGr, 2, 3, 4, stretch="Lin")
#invertiamo i valori ma la mappa non cambia di molto
plotRGB(TGr, 4, 3, 2, stretch="Lin")


### Day 2
#Ricarichiamo il codice dell'altra volta 
rlist <- list.files(pattern="lst")
rlist 
import <- lapply(rlist,raster)
import 
TGr <- stack(import)
TGr
#Usiamo la funzione levelplot che permette di plottare la nosta immagine in modo più bello graficamente con una solo scala e una sola leggenda 
levelplot(TGr)
#legato ad una solo mappa con statistiche laterali 
levelplot(TGr$lst_2000)
#Abbelliamo il levelplot quindi possiamo usare la colorRampPalette perchè usiamo immagini singole (TGr)
#Il blu scuro temperatura più bassa a red temperature più alte
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr,  col.regions=cl)
#Possiamo cambiare i titoli di queste immagini definiti attributi 
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#Diamo anche un titolo (main)
levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

#Usiamo i dati Melt
#Sono tantisimi dati quindi faremo di nuovo una lista
meltlist <- list.files(pattern="melt")
meltlist
#Usiamo la funzione lapply
melt_import <- lapply(meltlist,raster)
melt_import 
#Facciamo lo stack 
melt <- stack(melt_import)
melt
#Facciamo il levelplot
levelplot(melt)
#Matrixalgebra cioè l'algebra associata alle matrici andiamo a vedere il valore di scioglimento nel tempo 
#sottrazione tra gli strati del 2007 e del 1979
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
#ColorRampPalette le zone rosse sono quelle che dal 1979 al 2009 c'è stato uno scioglimento del ghiacciopiù alto
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
#Facciamo un level plot di melt_ammonut
levelplot(melt_amount, col.regions=clb)

