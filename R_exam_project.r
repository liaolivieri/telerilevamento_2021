# R_exam_project.r

#Drought in California

#Library:
library(raster)
library(rasterVis)
library(RStoolbox)
library(ggplot2)
library(rasterdiv) #per il NDVI globale
library(rasterVis)

setwd("C:/lab/exam") #Windows

# Uploud 4 images from Earth of Observatory
# Lake Shasta
shasta2019 <- raster("shasta_oli_2019194_lrg.jpg")
plot(shasta2019)
shasta2021 <- raster("shasta_oli_2021167_lrg.jpg")
plot(shasta2021)

# Lake Oroville
oro2019 <- raster("oroville_oli_2019155_lrg.jpg")
plot(oro2019)
oro2021 <- raster("oroville_oli_2021160_lrg.jpg")
plot(oro2021)

# Choose the color 
cl <- colorRampPalette(c("blue","light blue","yellow","orange","pink","red"))(200)

# Create 2 stack of the 2 lake
lshasta <- stack(shasta2019, shasta2021)
loroville <- stack(oro2019, oro2021)

#Plot the 2 stack
levelplot(lshasta,col.regions=cl, main="Lake Shasta", names.attr=c("July 2019","June 2021"))
levelplot(loroville,col.regions=cl, main="Lake Oroville", names.attr=c("June 2019","June 2021"))

# Paris
pairs(lshasta)
pairs(lroville)

# MULTIVARIATE ANALYSIS

# PCA of Lake Shasta
lshasta_pca <- rasterPCA(lshasta)
summary(lshasta_pca$model)
#Importance of components:
#                            Comp.1     Comp.2
# Standard deviation     82.5248997 36.7753106
# Proportion of Variance  0.8343183  0.1656817
# Cumulative Proportion   0.8343183  1.0000000
levelplot(lshasta_pca$map,col.regions=cl, main="PCA Lake Shasta", names.attr=c("July 2019","June 2021"))


# PCA of Lake Oroville
loroville_pca <- rasterPCA(loroville)
summary(loroville_pca$model)
# Importance of components:
#                            Comp.1     Comp.2
# Standard deviation     89.9813719 57.9840457
# Proportion of Variance  0.7065879  0.2934121
# Cumulative Proportion   0.7065879  1.0000000
levelplot(loroville_pca$map,col.regions=cl, main="PCA Lake Oroville", names.attr=c("June 2019","June 2021"))

#






