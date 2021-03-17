# My first code in R for remote sensing!
# Il mio primo codice in R per il telerilevamento!

# Pacchetti da installare:
# install.packages("raster")

# Le librerie mi permettono di aprire i pacchetti appena intallati:
library(raster)

# Setwd mi permette di creare un collegamento tra la cartella lab e R. 
setwd("C:/lab/") # Windows
# Brick mi permette di importare un immagine satellitare contenuta nel mio pc nella cartella lab.
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
# Plot mi permette di visualizzare l'immagine appena caricata.
plot(p224r63_2011)
#
# ColorRampPalette permette di cambiare il colore
cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(p224r63_2011, col=cl)
 
# Cambiamo colori a nostro piacimento
cls <- colorRampPalette(c("blue","purple","red","orange","yellow","green")) (100)
plot(p224r63_2011, col=cls)
