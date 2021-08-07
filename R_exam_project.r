# R_exam_project.r

#Drought in California

#Library:
library(raster)
library(rasterVis)
library(RStoolbox)


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

#Plot 





