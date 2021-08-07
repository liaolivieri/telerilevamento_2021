# R_exam_project.r

#Drought in California in the Lake Shasta from 2019 to 2021

#Library:
library(raster)
library(rasterVis)
library(RStoolbox)
library(ggplot2)
library(rasterdiv) #per il NDVI globale
library(rasterVis)

setwd("C:/lab/exam") #Windows

# Uploud 2 images from Earth of Observatory 
# Lake Shasta
shasta2019 <- brick("shasta_oli_2019194_lrg.jpg")
plot(shasta2019)
shasta2021 <- brcik("shasta_oli_2021167_lrg.jpg")
plot(shasta2021)

#Plot the 3 band with the function plotRGB
par(mfrow=c(2,2))
plotRGB(shasta2019,r=1,g=2,b=3, stretch="Hist")
plotRGB(shasta2021,r=1,g=2,b=3, stretch="Hist")

# Upload with function raster
shasta2019r <- raster("shasta_oli_2019194_lrg.jpg")
shasta2021r <- raster("shasta_oli_2021167_lrg.jpg")

# Choose the color 
cl <- colorRampPalette(c("blue","light blue","yellow","orange","pink","red"))(200)

# Create a stack of the Lake
lshasta <- stack(shasta2019r, shasta2021r)

#Plot the stack with levelplot
levelplot(lshasta,col.regions=cl, main="Lake Shasta", names.attr=c("July 2019","June 2021"))


#............................................................................................................................................................

# MULTIVARIATE ANALYSIS

# PCA of Lake Shasta 2019
shasta2019_pca <- rasterPCA(shasta2019)
summary(shasta2019_pca$model)
#Results
# Importance of components:
#                            Comp.1      Comp.2      Comp.3
# Standard deviation     72.8708129 15.49184619 6.569193764
# Proportion of Variance  0.9493767  0.04290794 0.007715347
# Cumulative Proportion   0.9493767  0.99228465 1.000000000
plotRGB(shasta2019_pca$map,r=1,g=2,b=3, stretch="Hist")

# PCA of Lake Shasta 2021
shasta2021_pca <- rasterPCA(shasta2021)
summary(shasta2021_pca$model)
#Results
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








