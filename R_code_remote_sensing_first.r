# My first code in R for remote sensing!
# Il mio primo codide in R per il telerilevamento!!!

install.packages("raster")
library(raster)
# Setwd mi permette di creare un collegamento tra la cartella lab e R. 
setwd("C:/lab/") # Windows
# Brick mi permette di importare un immagine satellitare contenuta nel mio pc.
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
# Plot mi permette di visualizzare l'immagine appena caricata.
plot(p224r63_2011)
