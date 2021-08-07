# R_exam_project.r

#Drought in California in the Lake Shasta from 2019 to 2021

#Library:
library(raster)
library(rasterVis)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

setwd("C:/lab/exam") #Windows

# Uploud 2 images from Earth of Observatory 
# Lake Shasta
shasta2019 <- brick("shasta_oli_2019194_lrg.jpg")
plot(shasta2019)
shasta2021 <- brick("shasta_oli_2021167_lrg.jpg")
plot(shasta2021)

#Plot the 3 band with the function plotRGB
par(mfrow=c(2,2))
plotRGB(shasta2019,r=1,g=2,b=3, stretch="Hist")
plotRGB(shasta2021,r=1,g=2,b=3, stretch="Hist")

# Upload with function raster
shasta2019r <- raster("shasta_oli_2019194_lrg.jpg")
shasta2021r <- raster("shasta_oli_2021167_lrg.jpg")

# Choose the color 
cl <- colorRampPalette(c("blue","light blue","yellow","orange","pink","red"))(100)

# Create a stack of the Lake
lshasta <- stack(shasta2019r, shasta2021r)

#Plot the stack with levelplot
levelplot(lshasta,col.regions=cl, main="Lake Shasta", names.attr=c("July 2019","June 2021"))


#............................................................................................................................................................

# MULTIVARIATE ANALYSIS
# 1. Principal component analysis

# PCA of Lake Shasta 2019 
shasta2019_pca <- rasterPCA(shasta2019)
summary(shasta2019_pca$model)
#Results:
# Importance of components:
#                            Comp.1      Comp.2      Comp.3
# Standard deviation     72.8708129 15.49184619 6.569193764
# Proportion of Variance  0.9493767  0.04290794 0.007715347
# Cumulative Proportion   0.9493767  0.99228465 1.000000000
plotRGB(shasta2019_pca$map,r=1,g=2,b=3, stretch="Hist")

# PCA of Lake Shasta 2021
shasta2021_pca <- rasterPCA(shasta2021)
summary(shasta2021_pca$model)
#Results:
# Importance of components:
#                           Comp.1      Comp.2      Comp.3
# Standard deviation     95.682841 20.37762526 7.315502912
# Proportion of Variance  0.951292  0.04314722 0.005560759
# Cumulative Proportion   0.951292  0.99443924 1.000000000
plotRGB(shasta2019_pca$map,r=1,g=2,b=3, stretch="Hist")

# Comparison PCA 2019 and PCA 2021 
par(mfrow=c(1,2))
plotRGB(shasta2019_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(shasta2021_pca$map,r=1,g=2,b=3, stretch="Hist")

# Multiframe with ggplot
sh19 <- ggRGB(shasta2019_pca$map,r=1,g=2,b=3, stretch="Hist")
sh21 <- ggRGB(shasta2021_pca$map,r=1,g=2,b=3, stretch="Hist")
grid.arrange(sh19, sh21, nrow=1)


# 2. Unsupervised classification

# Multiframe with ggplot2 e gridExtra for the 2 images of 2019 and 2021
l1 <- ggRGB(shasta2019, r=1, g=2, b=3, stretch="lin")
l2 <- ggRGB(shasta2021, r=1, g=2, b=3, stretch="lin")
grid.arrange(l1, l2, nrow=1)

# classification in 2 classes: (1 forest, 1 water)
l1c <- unsuperClass(shasta2019, nClasses= 2)
l1c
plot(l1c$map)
# Class1: forest
# Class2: water
l2c <- unsuperClass(shasta2021, nClasses= 2)
l2c
plot(l2c$map)
freq(l1c$map)
#      value   count
# forest[1,]     1  664187
# water[2,]     2 2726390
freq(l2c$map)
#      value   count
# forest[1,]     1 2705449
# water[2,]     2  685128

unsh19 <- unsuperClass(shasta2019, nClasses=16)
plot(unsh19$map)

unsh21 <- unsuperClass(shasta2021, nClasses=16)
plot(unsh21$map)

par(mfrow=c(1,2))
plot(unsh19$map)
plot(unsh21$map)

#......................................................................................................................................................

# DVI - Difference Vegetation Index

# See how the bands of NIR and RED are called 
shasta2019
#B1(NIR)=shasta_oli_2019194_lrg.1,; B2(RED)=shasta_oli_2019194_lrg.2
shasta2021
#B1(NIR)=shasta_oli_2021167_lrg.1; B2(RED)=shasta_oli_2021167_lrg.2

# First index of Shasta 2019: NIR - RED
dvi1 <- shasta2019$shasta_oli_2019194_lrg.1 - shasta2019$shasta_oli_2019194_lrg.2
plot(dvi1)
cld <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cld, main="DVI of Shasta in 2019")

# First index of Shasta 2021: NIR - RED
dvi2 <- shasta2021$shasta_oli_2021167_lrg.1 - shasta2021$shasta_oli_2021167_lrg.2
plot(dvi2)
plot(dvi2, col=cld, main="DVI of Shasta in 2021")

# Comparison togher for the difference
par(mfrow=c(1,2))
plot(dvi1, col=cld, main="DVI of Shasta in 2019")
plot(dvi2, col=cld, main="DVI of Shasta in 2021")
difdvi <- dvi1 - dvi2
cldd <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cldd)


# NDVI - Normalized Difference Vegetation Index

# NDVI= (NIR-RED) / (NIR+RED)
# NDVI of Lake Shasta 2019
ndvi1 <- (dvi1) / (shasta2019$shasta_oli_2019194_lrg.1 + shasta2019$shasta_oli_2019194_lrg.2)
plot(ndvi1, col=cld, main="NDVI of Shasta in 2019")

# NDVI of Lake Shasta 2021
ndvi2 <- (dvi2) / (shasta2021$shasta_oli_2021167_lrg.1 + shasta2021$shasta_oli_2021167_lrg.2)
plot(ndvi2, col=cld, main="NDVI of Shasta in 2021")

# Difference NDVI
difndvi <- ndvi1 - ndvi2
plot(difndvi, col=cldd)


#.....................................................................................................................................
# SPECTRAL SIGNATURES











