# R_code_classification.r

#Pacchetti da installare
library(raster)
library(RStoolbox)

#Creiamo il collegamento con la cartella lab
setwd("C:/lab/") #Windwos

###Day 1

#La funzione brick mi importa in R la mia immagine 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# Visualizziamo i livelli RGB della nostra immagine
so 
#Visualizziamo l'immagine con la funzione plot
plotRGB(so, 1,2,3, stretch="lin")

#Facciamo la classificazione con la funzione: unsuperClass -> Unsupervised Classification
soc <- unsuperClass(so, nClasses=3)
#Andiamo a plottare la nostra immagine (soc) classificata ma solo della mappa
plot(soc$map)
#Facciamo Unsupervised Classification con 20 classi
sou <- unsuperClass(so, nClasses=20)
plot(sou$map)

#Download an image of:
#https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")
#Facciamo Unsupervised Classification con 3 classi
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)

###Day 2

#Classifichiamo un immagine del Grand Canyon
#Download of: https://landsat.visibleearth.nasa.gov/view.php?id=80948
#Carichiamo la nostra immagine
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc, r=1,g=2,b=3, stretch="lin")
plotRGB(gc, r=1,g=2,b=3, stretch="hist")
#Facciamo Unsupervised Classification con 2 classi
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)
#Facciamo Unsupervised Classification con 4classi
gcc4 <- unsuperClass(gc, nClasses=4)
plot(gcc4$map)
