# My first code in R for remote sensing!
# Il mio primo codice in R per il telerilevamento!

# Pacchetti da installare:
# install.packages("raster")

# Le librerie mi permettono di aprire i pacchetti appena intallati:
library(raster)


### Day 1

# Setwd mi permette di creare un collegamento tra la cartella lab e R. 
setwd("C:/lab/") #Windows
# Brick mi permette di importare un immagine satellitare contenuta nel mio pc nella cartella lab.
p224r63_2011 <- brick("p224r63_2011_masked.grd")
#Ricavo informazioni sull'immagine caricata 
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
#dev.off() ripulisce la finestra grafica
dev.off()
#se volessi vedere solo la banda del blu: 
plot(p224r63_2011$B1_sre)
#plot band 1 with a predefined colur ramp palette
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011$B1_sre, col=cls)

dev.off()
#plot singole bande con la funzione par =settaggio parametri grafici di un certo grafico che vogliamo creare
#row=1,2 una riga e due colonne:
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#non riusciamo in questo modo a plottare insieme quindi usiamo la funzione Par per decidere come mettere le immahgini nel nostro software:
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#row=2,1 plottiamo 2 righe e 1 colonna:
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#par(mfcol= per le colonne prima e dopo le righe) // (mfrow= prima righe e poi colonne)

#Plot le prime 4 bande di Landsat (4 righe e 1 colonna)
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)    
#Plot le prime 4 bande di Landsat (2 righe e 2 colonne)
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre) 
#Creo un quadrato 2x2 cambiando colore ad ogni banda
par(mfrow=c(2,2))
#colorRampPalette banda del blu:
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)
#colorRampPalette banda del verde:
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)
#colorRampPalette banda del rosso:
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)
#colorRampPalette banda dell'infrarosso:
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
#Abbiamo creato un immagine a colori naturali!!
#Ora però giochiamo con le altre bande e usiamo l'infrarosso: r=4, g=3, b=2
plotRGB(p224r63_2011,r=4,g=3,b=2, stretch="Lin")






