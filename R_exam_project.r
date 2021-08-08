# R_exam_project.r

# California drought in Sasha Lake from 2019 to 2021
# Images from: https://earthobservatory.nasa.gov/images/148447/california-reservoirs-reflect-deepening-drought

#Library:
library(raster)
library(rasterVis)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
library(rgdal)

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
cll <- colorRampPalette(c("pink","blue","yellow","red"))(100)

# Create a stack of the Lake
lshasta <- stack(shasta2019r, shasta2021r)

#Plot the stack with levelplot
levelplot(lshasta,col.regions=cll, main="Lake Shasta", names.attr=c("July 2019","June 2021"))


#............................................................................................................................................................

# MULTIVARIATE ANALYSIS

# 1. The function pairs produce a matrix of scatterplots.

# Plots the correlations between the 3 bands of my stack.
# The values of indices correlation range from 0 to 1: 1= correlation, 0= no correlation
# 
pairs(lshasta, main="Comparation with the function pairs")
# Result= 0.65


# 2. Principal component analysis

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
plot(shasta2019_pca$model) #For see the graphic

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
plot(shasta2021_pca$model) #For see the graphic

# Comparison PCA 2019 and PCA 2021 
par(mfrow=c(1,2))
plotRGB(shasta2019_pca$map,r=1,g=2,b=3, stretch="Hist")
plotRGB(shasta2021_pca$map,r=1,g=2,b=3, stretch="Hist")

# Multiframe with ggplot
sh19 <- ggRGB(shasta2019_pca$map,r=1,g=2,b=3, stretch="Hist")
sh21 <- ggRGB(shasta2021_pca$map,r=1,g=2,b=3, stretch="Hist")
grid.arrange(sh19, sh21, nrow=1)


#......................................................................................................................................................

# 1. DVI - Difference Vegetation Index

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


# 2. NDVI - Normalized Difference Vegetation Index

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

# Create a spectral signature of images Lake Shasta 2019 with the function "click"
plotRGB(shasta2019, r=1, g=2, b=3, stretch="lin")
click(shasta2019, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# In a pixel of vegetation -> B1= very high value, B2=low value, B3= average value
# In a pixel of water -> B1= low value, B2= high value, B3= very high value
# Results
#        x      y    cell shasta_oli_2019194_lrg.1 shasta_oli_2019194_lrg.2 shasta_oli_2019194_lrg.3
# 1  521.5 1201.5  966665                       45                      133                      119
# 2 1685.5  749.5 1879513                        4                       53                       60
# 3 1356.5 1289.5  790004                       32                      115                      105
# 4 1557.5 1037.5 1298489                        9                       32                       40
# 5  412.5  304.5 2775805                        2                       43                       65
# 6  646.5  584.5 2211279                        4                       53                       67


# Create a spectral signature of images Lake Shasta 2021  with the function "click"
plotRGB(shasta2021, r=1, g=2, b=3, stretch="hist")
click(shasta2021, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
# Results:
#        x      y    cell shasta_oli_2021167_lrg.1 shasta_oli_2021167_lrg.2 shasta_oli_2021167_lrg.3
# 1  499.5  935.5 1503165                        4                       62                       76
# 2 1674.5  745.5 1887570                      254                      249                      227
# 3 1294.5 1227.5  914996                       26                       93                       84
# 4 1550.5 1041.5 1290414                       10                       33                       39
# 5  393.5  326.5 2731412                       37                      108                      130
# 6  652.5  523.5 2334322                       57                      137                      148

# Create a dataset with our results (just a few more representative results)
band <- c(1,2,3)
Shasta2019p1 <- c(45, 133, 119)
Shasta2019p2 <- c(4, 53, 60)
Shasta2019p5 <- c(2, 43, 65)
Shasta2019p6 <- c(4, 53, 67)
Shasta2021p1 <- c(4, 62, 76)
Shasta2021p2 <- c(254, 249, 227)
Shasta2021p5 <- c(37, 108, 130)
Shasta2021p6 <- c(57, 137, 148)
spectralst <- data.frame(band,Shasta2019p1,Shasta2019p2,Shasta2019p5,Shasta2019p6,Shasta2021p1,Shasta2021p2,Shasta2021p5,Shasta2021p6)

# Plot this dataset with ggplot
# Red for the results of 2019, blue for the results of 2021
ggplot(spectralst, aes(x=band)) +
geom_line(aes(y = Shasta2019p1), color="blue") +
geom_line(aes(y = Shasta2019p2), color="blue") +
geom_line(aes(y = Shasta2019p5), color="blue") +
geom_line(aes(y = Shasta2019p6), color="blue") +
geom_line(aes(y = Shasta2021p1), color="red") +
geom_line(aes(y = Shasta2021p2), color="red") +
geom_line(aes(y = Shasta2021p5), color="red") +
geom_line(aes(y = Shasta2021p6), color="red") +
labs(x="band", y="reflectance")

# Plot this dataset with ggplot
# The light color represent the results of 2019, the dark color represent the results of 2021
ggplot(spectralst, aes(x=band)) +
geom_line(aes(y = Shasta2019p1), color="light blue") +
geom_line(aes(y = Shasta2019p2), color="pink") +
geom_line(aes(y = Shasta2019p5), color="yellow") +
geom_line(aes(y = Shasta2019p6), color="gray") +
geom_line(aes(y = Shasta2021p1), color="blue") +
geom_line(aes(y = Shasta2021p2), color="purple") +
geom_line(aes(y = Shasta2021p5), color="orange") +
geom_line(aes(y = Shasta2021p6), color="black") +
labs(x="band", y="reflectance")

#........................................................................................................................................
