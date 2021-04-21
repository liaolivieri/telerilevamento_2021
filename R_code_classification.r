# R_code_classification.r

#Pacchetti da installare
library(raster)
library(RStoolbox)

#Creiamo il collegamento con la cartella lab
setwd("C:/lab/") #Windwos

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

#Andiamo ad usare la funzione set.seed(42) così da avere una classificazione uguale
#Download an image of:
#https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun <- brick("sun.png")
#Facciamo Unsupervised Classification con 3 classi
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)
