# R code complete - Telerilevamento Geo-Ecologico

#...................................................................................................................................................................................

#Summary:

# 1. Remote Sensing - first code
# 2. R code time series
# 3. R code Copernicus data
# 4. R code knitr 
# 5. R code multivariate analysis 
# 6. R code classification
# 7. R code ggplot 2
# 8. R code vegetation indicies
# 9. R code land cover
# 10. R code variability
# 11. R code spectral signatures


#....................................................................................................................................................................................

# 1. Remote Sensing - first code

# My first code in R for remote sensing!
# Il mio primo codice in R per il telerilevamento!

# Pacchetti da installare:
# install.packages("raster")
# install.packages("RStoolbox")

# Le librerie mi permettono di aprire i pacchetti appena intallati:
library(raster)


### Day 1

# Setwd mi permette di creare un collegamento tra la cartella lab e R. 
setwd("C:/lab/") #Windows
# Brick mi permette di importare un immagine satellitare contenuta nel mio pc nella cartella lab.
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# Ricavo informazioni sull'immagine caricata 
p224r63_2011
# Plot mi permette di visualizzare l'immagine appena caricata.
plot(p224r63_2011)

### Day 2 

# ColorRampPalette permette di cambiare il colore
cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(p224r63_2011, col=cl)
# Cambiamo colori a nostro piacimento
cls <- colorRampPalette(c("blue","purple","red","orange","yellow","green")) (100)
plot(p224r63_2011, col=cls)

### Day 3

# Bande Landsat:
#B1: blue
#B2: green
#B3: red 
#B4: infrarosso vicino
#B5: infrarosso medio
#B6: infrarosso termico 
#B7: infrarosso medio 
# se volessi plottare la banda del blu prima pulisco la mia finestra
# dev.off() ripulisce la finestra grafica
dev.off()
# se volessi vedere solo la banda del blu: 
plot(p224r63_2011$B1_sre)
# plot band 1 with a predefined colur ramp palette
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011$B1_sre, col=cls)

dev.off()
# plot singole bande con la funzione par =settaggio parametri grafici di un certo grafico che vogliamo creare
# row=1,2 una riga e due colonne:
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
# non riusciamo in questo modo a plottare insieme quindi usiamo la funzione "Par" per decidere come mettere le immahgini nel nostro software:
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
# row=2,1 plottiamo 2 righe e 1 colonna:
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
# par(mfcol= per le colonne prima e dopo le righe) // (mfrow= prima righe e poi colonne)

# Plot le prime 4 bande di Landsat (4 righe e 1 colonna)
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)    
# Plot le prime 4 bande di Landsat (2 righe e 2 colonne)
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre) 
# Creo un quadrato 2x2 cambiando colore ad ogni banda
par(mfrow=c(2,2))
# colorRampPalette banda del blu:
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)
# colorRampPalette banda del verde:
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)
# colorRampPalette banda del rosso:
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)
# colorRampPalette banda dell'infrarosso:
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)

### Day 4
# Visualizing data by RGB plotting

# Bande Landsat:
#B1: blue
#B2: green
#B3: red 
#B4: infrarosso vicino
#B5: infrarosso medio
#B6: infrarosso termico 
#B7: infrarosso medio 
# Uso la funzione plotRGB per montare 3 bande alla volta e associare una banda a una componente di RGB + stretch="lin" per permettere di visualizzare tutte le sfumature di colori presenti nelle bande
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
# Abbiamo creato un immagine a colori naturali!!
# Ora però giochiamo con le altre bande e usiamo l'infrarosso: r=4, g=3, b=2
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
# Metto l'infrarosso nella banda del green
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")
# Metto l'infrarosso nella banda del blue
plotRGB(p224r63_2011,r=3,g=2,b=4, stretch="Lin")
# Exercize: mount a 2x2 multiframe:
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4, stretch="Lin")
# Facciamo un pdf della nostra immagine creata
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4, stretch="Lin")
dev.off()
# Usiamo ora uno stretch diveso usiamo l'histogram che usa funzione ad S e non lineare
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="hist")
# Facciamo un par con l'immagine natural colors, false coloror and false colour and histogram stretch
par(mfrow=c(3,1))
plotRGB(p224r63_2011,r=3,g=2,b=1, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2, stretch="hist")
# Installiamo un nuovo pacchetto per poter fare una PCA sui nostri dati
install.packages("RStoolbox")
library(RStoolbox)

### Day 5

p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
# Multitemporal set, carichiamo una nuova immagine dalla cartella lab
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988
# Facciamo un plot di questa nuova immagine andando a vedere tutte le bande
plot(p224r63_1988)
# Plottiamola ora con RGB
plotRGB(p224r63_1988,r=3,g=2,b=1, stretch="Lin")
# Usiamo sempre lo schema RGB ma inseriamo la banda dell'infrarosso
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Lin")
# Confrontiamo ora l'immagine del 1988 e quella 2011
par(mfrow=c(2,1))
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
# Confrontiamo ora l'immagine del 1988 e quella del 2011 prima riga stretch lineare, seconda riga hystogram stretch e facciamone un pdf
pdf("il_mio_secondo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3,b=2, stretch="Hist")
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Hist")
dev.off()

#......................................................................................................................................................................................

# 2. R code time series

# Time series analysis 
# Greenland increase of temperature
# Data and code from Emanuela Cosma

# Pacchetti da installare
#install.packages("raster")
#install.packages("rasterVis")

# Librerie che ci permettono di usare i nostri pacchetti installati:
library(raster)
library(rasterVis)

setwd("C:/lab/greenland") # Windows

# La funzione per caricaricare singoli dati è raster (del pacchetto raster)
# Carichiamo tutti le immagini lst della groenlandia del 2000, 2005, 2010, 2015
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)
# Facciamo un pannello con le 4 immagini:
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# Importiamo le immagini tutte insieme con la funzione: lapply
# Prima facciamo la lista dei nostri file per poter usare questa funzione
# Con il pattern identifichiamo la scritta in comune a tutti i file quindi nel nostro caso lst
rlist <- list.files(pattern="lst")
rlist
# Ora che abbiamo la nostra lista con i nostri file applichiamo lapply a tutta la lista associata alla funzione raster
import <- lapply(rlist,raster)
import
# Impaccettiamo i file con la funzione stack 
TGr <- stack(import)
# Quindi adesso possiamo plottare direttamente il pacchetto TGr
plot(TGr)
# Possiamo plottarle tutte assime con RGB
#1=mappa 2000, 2=mappa 2005, 3=mappa 2010, 4=mappa 2015
# Mappa blu del 2010 (perchè B=3) 
plotRGB(TGr, 1, 2, 3, stretch="Lin")
# Mappa blu del 2015(perchè B=4)
plotRGB(TGr, 2, 3, 4, stretch="Lin")
# invertiamo i valori ma la mappa non cambia di molto
plotRGB(TGr, 4, 3, 2, stretch="Lin")


### Day 2
# Ricarichiamo il codice dell'altra volta 
rlist <- list.files(pattern="lst")
rlist 
import <- lapply(rlist,raster)
import 
TGr <- stack(import)
TGr
# Usiamo la funzione levelplot che permette di plottare la nosta immagine in modo più bello graficamente con una solo scala e una sola leggenda 
levelplot(TGr)
# legato ad una solo mappa con statistiche laterali 
levelplot(TGr$lst_2000)
# Abbelliamo il levelplot quindi possiamo usare la colorRampPalette perchè usiamo immagini singole (TGr)
# Il blu scuro temperatura più bassa a red temperature più alte
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr,  col.regions=cl)
# Possiamo cambiare i titoli di queste immagini definiti attributi 
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
# Diamo anche un titolo (main)
levelplot(TGr,col.regions=cl, main="LST variation in time", names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))

# Usiamo i dati Melt
# Sono tantisimi dati quindi faremo di nuovo una lista
meltlist <- list.files(pattern="melt")
meltlist
# Usiamo la funzione lapply
melt_import <- lapply(meltlist,raster)
melt_import 
# Facciamo lo stack 
melt <- stack(melt_import)
melt
# Facciamo il levelplot
levelplot(melt)
# Matrixalgebra cioè l'algebra associata alle matrici andiamo a vedere il valore di scioglimento nel tempo 
# sottrazione tra gli strati del 2007 e del 1979
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
# ColorRampPalette le zone rosse sono quelle che dal 1979 al 2009 c'è stato uno scioglimento del ghiacciopiù alto
clb <- colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount, col=clb)
# Facciamo un level plot di melt_ammonut
levelplot(melt_amount, col.regions=clb)

#...............................................................................................................................................

# 3. R code Copernicus data

# R_code_copernicus.r
# Visualizing copernicus data

#install.packages("ncdf4")

library(raster)
library(ncdf4)

# setwd("C:/lab/") # Windows

# Diamo un nome al nostro set
ndvi <- raster ("c_gls_NDVI300_202010010000_GLOBE_PROBAV_V1.0.1.nc")

cl <- colorRampPalette(c('light blue','blue','red','yellow'))(100)
plot(ndvi, col=cl)
 
# La funzione aggregate va ad aggregare vari pixel al fine di alleggerire la mia immagine che quindi avrà un numero ristretto di pixel
# Uso il fact nella mia funzione es fact=100 ogni 100 pixel avrò 1 pixel (linearmente 100x100 pixel li trasformiamo in 1 pixel)
# Ricampionamento bilaterale (resampling)
ndvires <- aggregate(ndvi, fact=100)
plot(ndvires, col=cl)

#.......................................................................................................................................

# 4. R code knitr 

# R_code_knitr.r

# Il pacchetto knitr può usare un codice esterno per creare un report
# Si prende il codice all'esterno e lo importa, e genererà un report è verrà salvato nella cartella in cui è salvato il codcie

# Pacchetti da istallare:
#install.packages("knitr")

# Librerie:
library(knitr)

setwd("C:/lab/") # Windows
# Generà il report
stitch("C:/lab/R_code.greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
# Mi genererà un file con estension .tex

#..........................................................................................................................................................................................

# 5. R code multivariate analysis 

# R_code_multivariate_analysis.r

library(raster)
library(RStoolbox)

setwd("C:/lab/") #Windows

# Carichiamo la foto con tutte la bande
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)

# Plot dei valori pixel della banda 1 contro quelli della banda 2
# col=cambio colore dei punti, pch=forma dei punti, cex=dimensione punti
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

# Per mostrare tutte le correlazioni possibili tra tutte le variabili si può la funzione pairs
pairs(p224r63_2011)

### Day 2

# Riduciamo la dimensione della nostra immagine con la funzione aggregrate (aggrega i pixel)
# resampling=ricampionamento
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res

# Confrontiamo le due immagini per vederne la differenza
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

# rasterPCA: prende il pacchetto di dati e li compatta in un numero minore di bande
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

# La funzione summary ci da un sommario del nostro modello, vediamo la varianza delle varie componenti delle bande
summary(p224r63_2011res_pca$model)
#vediamolo anche graficamente
plot(p224r63_2011res_pca$map)

# vediamo tutto quello che abbiamo generato fino ad adesso
p224r63_2011res_pca

# plottiamo la mappa risultante con RGB
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

# La funzione str ci da informazioni sulla struttura del file e informazioni aggiuntive
str(p224r63_2011res_pca)

#...............................................................................................................................................................................................

# 6. R code classification

# R_code_classification.r

# Librerie
library(raster)
library(RStoolbox)

# Creiamo il collegamento con la cartella lab
setwd("C:/lab/") #Windwos

### Day 1

# La funzione brick mi importa in R la mia immagine 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# Visualizziamo i livelli RGB della nostra immagine
so 
# Visualizziamo l'immagine con la funzione plot
plotRGB(so, 1,2,3, stretch="lin")

# Facciamo la classificazione con la funzione: unsuperClass -> Unsupervised Classification
soc <- unsuperClass(so, nClasses=3)
# Andiamo a plottare la nostra immagine (soc) classificata ma solo della mappa
plot(soc$map)
# Facciamo Unsupervised Classification con 20 classi
sou <- unsuperClass(so, nClasses=20)
plot(sou$map)

# Download an image of:
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")
# Facciamo Unsupervised Classification con 3 classi
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

### Day 2

# Classifichiamo un immagine del Grand Canyon
# Download of: https://landsat.visibleearth.nasa.gov/view.php?id=80948
# Carichiamo la nostra immagine
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1,g=2,b=3, stretch="lin")
plotRGB(gc, r=1,g=2,b=3, stretch="hist")
# Facciamo Unsupervised Classification con 2 classi
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)
# Facciamo Unsupervised Classification con 4classi
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)

#......................................................................................................................................................................................

# 7. R code ggplot 2

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("~/lab/")

p224r63 <- brick("p224r63_2011_masked.grd")

ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")

p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")

grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#........................................................................................................................................................................................

# 8. R code vegetation indicies

# R_code_vegetation_indices.r

# Pacchetti da installare
#install.packages("raster")
#install.packages("RStoolbox")
#install.packages("rasterdiv") #for worlwide NDVI

# Librerie:
library(raster) #oppure anche require(raster)
library(RStoolbox) #per gli indici della vegetazione
library(rasterdiv) #per il NDVI globale
library(rasterVis)

setwd("C:/lab/") #Windows

# Carichiamo le immagini 
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

# Plottiamo le immagini 
#b1=NIR, b2=red, b3=green
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

### Day 2

# Vediamo come si chiamano le componenti/variabili del Nir e del red
defor1
#NIR=defor1.1 , RED=defor1.2
# Facciamo il primo indice dvi1= (banda dell'infrarosso) - (banda del rosso)
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)
# Cambiamo i colori
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")
 
# Facciamo la stesso procedura per il dvi2
defor2
# NIR=defor2.1 , RED=defor2.2
# Facciamo il secondo indice dvi2= (banda dell'infrarosso) - (banda del rosso)
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")

# Plottiamoli assime per capirne meglio le differenze
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

# Per vedere la differenza possiamo fare la differenza dei due dvi
difdvi <- dvi1 - dvi2
# Visualizziamolo anche nella mappa per vedere meglio il confronto
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)

# Calcoliamo l'ndvi1
# NDVI= (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)
# la stessa cosa la possiamo scricere ache così:
# ndvi1 <- dvi1 / (defor1$defor1.1 + defor1$defor1.2)
# plot(ndvi1, col=cl)

# Calcoliamo l'ndvi2
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)
# la stessa cosa la possiamo scricere ache così:
# ndvi2 <- dvi2 / (defor2$defor2.1 + defor2$defor2.2)
# plot(ndvi2, col=cl)

# RStoolbox: funzione spectralIndices con la quale posso calcolare tutti gli indici
# b1=NIR, b2=red, b3=green
vi1 <- spectralIndices(defor1, green=3, red=2, nir=1)
plot(vi1, col=cl)
# Facciamolo per la seconda immagine
vi2 <- spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)

# Differenza NDVI
difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)

### Day 3
# worldwide NDVI

# Vediamo NDVI mondiale 
plot(copNDVI)
# Togliamo l'acqua dalla visualizzazione, trasformandoli in non valori
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
# Vediamo l'NDVI in modo globale senza l'acqua
plot(copNDVI)

# rasterVis
levelplot(copNDVI)

#.............................................................................................................................................................................................

# 9. R code land cover

# R_code_land_cover.r

# Pacchetti da istallare:
#install.packages("raster")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("gridExtra")

# Librerie:
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/") # Windows

# Carichiamo la prima immagine
defor1 <- brick("defor1.jpg")
# Plottiamola
# NIR 1, RED 2, GREEN 3
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
# Plottiamola con ggplot che ci permette di avere anche le cordinate
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

# Carichiamo e facciamo lo stesso con la seconda immagine
defor2 <- brick("defor2.jpg")
# NIR 1, RED 2, GREEN 3
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")

# Multiframe with plotRGB
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

# Multiframe with ggplot2 e gridExtra
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)


### Day 2

# Dividiamo in 2 classi le nostre immagini (1 agricola, 1 foresta)
# Unsupervised classification
d1c <- unsuperClass(defor1, nClasses= 2)
d1c
plot(d1c$map)
# Class1: foresta
# Class2: agricoltura
# Con la funzione set.seed() si possono avere gli stessi risultati tutte le volte
d2c <- unsuperClass(defor2, nClasses= 2)
d2c
plot(d2c$map)
# Class1: foresta
# Class2: agricoltura
# Facciamo di defor2 3 classi 
d2c3 <- unsuperClass(defor2, nClasses= 3)
plot(d2c3$map)
# Class1: foresta
# Class2: agricoltura
# Andiamo a vedere quanta frequenza c'è delle due classi create
freq(d1c$map)
# class1= 304618
# class2= 36674
# Facciamo la somma
s1 <- 304618 + 36674
# s1= 341292
# Calcoliamo la proporzione tra le due classi
prop1 <- freq(d1c$map) / s1
prop1
# prop foresta: 0.8925436 ,
# prop agricoltura: 0.1074564
# Facciamo lo stesso per la seconda mappa
s2 <- 342726
prop2 <- freq(d2c$map) / s2
prop2
# prop foresta: 0.5197388
# prop agricoltura: 0.4802612

# Facciamo un dataset 
# cover=Prima colonna fattori (valori categoriche: foresta, agricoltura)
# percent_1992= seconda colonna(valori percetuale 1992)
# percent_2006= terza colonna(valori percentuale 2006)
cover <- c("Forest", "Agriculture")
percent_1992 <- c(89.25, 10.75)
percent_2006 <- c(51.97, 48.03)

percentages <- data.frame(cover, percent_1992, percent_2006)
percentages
#        cover percent_1992 percent_2006
# 1      Forest        89.25        51.97
# 2 Agriculture        10.75        48.03

# Facciamo un grafico con ggplot
# aes=estetica, geom_bar= grafico a barre
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p1
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
p2

#Mettiamo assime i nostri due grafici
grid.arrange(p1, p2, nrow=1)

#............................................................................................................................................................................................

# 10. R code variability

# R_code_variability.r

# Pacchetti da installare:
#install.packages("raster")
#install.packages("RStoolbox")
#install.packages("ggplot2")
#install.packages("gridExtra")
#install.packages("viridis")

# Librerie:
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(viridis) #per colorare i plot di ggplot2

setwd("C:/lab/") #Windows

# Importiamo l'immagine 
sent <- brick("sentinel.png")
# Plottiamo l'immagine con plotRGB così da mostrarne i 3 livelli
# NIR 1, RED 2, GREEN 3
# Già di default la sequenza per questa funzione è r=1, g=2, b=3 quindi possiamo anche evitare di scrivere
plotRGB(sent, stretch="lin")
# è uguale a dire: plotRGB(sent, r=1, g=2, b=3, stretch="lin")
# Se cambiamo l'ordine delle bande mettendo la banda NIR in g avremo la parte vegetale in verde fluorescente
# Le zone in nero sono d'acqua
plotRGB(sent, r=2, g=1, b=3, stretch="lin")
# Nell'immagine sent nominiamo le bande Nir=1, Red=2
nir <- sent$sentinel.1
red <- sent$sentinel.2
# Calcoliamo il NDVI
ndvi <- (nir-red) / (nir+red)
plot(ndvi)
# Facciamo la colorRampPalette
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

# Calcoliamo la variabilità dell'immagine con la funzione focal 
# Deviazione standard in R si dice sd
# w=windows della matrice di ogni pixel su 9 totali, disposti su 3 righe per 3 colonne 
# Meglio calcolare finestre quadrate, più pixel più sarà lungo il calcolo
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
# Cambiamo i colori
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)
# blu e verde= deviazione più bassa; rossa e gialla= deviazione più alta 
# blu=roccia omogenia, verde=zone confine roccia e vegetazione,
# grandi praterie la deviazione standard torna a diminuire perchè molto simili tra di loro come riflettanza

# Calcoliamo la media del ndvi
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
plot(ndvimean3, col=clsd)
# Valori molto alti per i boschi e le praterie, valori più bassi per la roccia nuda

# Cambiamo la grandezza della nostra moving windows (deve essere sempre dispari)
# Usiamo 13*13 pixel 
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
plot(ndvisd13, col=clsd)

# cambiano ancora la gradezza
# usiamo 5*5 pixel
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
plot(ndvisd5, col=clsd)


# Possiamo usare un'altra tecnica la PCA ed usiamo solo la prima componente principale con la funzione rasterPCA
# PCA di sent
sentpca <- rasterPCA(sent)
plot(sentpca$map)
# PC1 è la migliore, man mano che passiamo alle altre le informazioni diminuisono drasticamente
sentpca
# Vediamo quanta proporzione di varianza viene spiegata in ogni componente
summary(sentpca$model)
#                          Comp.1     Comp.2      Comp.3 Comp.4
# Standard deviation     77.3362848 53.5145531 5.765599616      0
# Proportion of Variance  0.6736804  0.3225753 0.003744348      0
# Cumulative Proportion   0.6736804  0.9962557 1.000000000      1
# La prima PC continente il 67,36804% della informazione originale


### Day 2
pc1 <- sentpca$map$PC1

# Funzione focal con la PC1, facciamo la sd di una sola banda
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(pc1sd5, col=clsd)

# Usiamo la funzione source per mettere in R un pezzo di codice salvato in un file
# Non dobbiamo copiare e incollare il codice con questa funzione
source("source_test_lezione.r")

source("source_ggplot.r")

# Fare una nuova finestra con ggplot vuota
ggplot()
# Aggiungiamo un blocco a ggplot
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer))
# Aggungiamo la funzione per le legende di viridis
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis()
# Aggiungiamo un titolo alla nostra mappa
ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation of PC1 by viridis colour scale")

# Scegliamo noi una legenda da viridis: magma
p1 <- ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") +
ggtitle("Standard deviation of PC1 by magma colour scale")

# Scegliamo noi un'altra legenda da virids: inferno
p2 <- ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="inferno") +
ggtitle("Standard deviation of PC1 by inferno colour scale")

# Scegliamo noi un'altra legenda da virids: turbo
p3 <- ggplot() + 
geom_raster(pc1sd5, mapping= aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="turbo") +
ggtitle("Standard deviation of PC1 by turbo colour scale")

# Possiamo mettere tutte queste legende tutte in una volta (1magma=p1, 1inferno=p2, 1turbo=p3) con la funzione grid.arrage
grid.arrange(p1, p2, p3, nrow=1)

#...........................................................................................................................................................................................

# 11. R code spectral signatures

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

#.........................................................................................................................................................................................
