# R_code_no2.r

library(raster)
library(RStoolbox) # here used for raster based multivariate analysis

# 1. Set the working directory EN
setwd("C:/lab/EN") #Windwos

# 2. Import the first image (single band)
# we will select band 1, but the raster funciotion enables to select other single-bands
EN01 <- raster("EN_0001.png")

# 3. Plot the first importaed image with your preferred  Color Ramp Palette
cl <- colorRampPalette(c("blue","grey","yellow")) (100)
plot(EN01, col=cl)

# 4. Import the last image (13th) and plot il with the previous Color Ramp Palette
EN13 <- raster("EN_0013.png")
cl <- colorRampPalette(c("blue","grey","yellow")) (100)
plot(EN13, col=cl)

# 5. Make the difference between the two images and plot it
# eith March- January or January - March 
ENdif <- EN01 - EN13
#ENdif <- EN13 - EN01
plot(ENdif, col=cl)

# 6. Plot everything, altogether
par(mfrow=c(3,1))
plot(EN01, col=cl, main="No2 in January")
plot(EN13, col=cl, main="No2 in March")
plot(ENdif, col=cl, main="Difference (January-March)")

# 7. Import the whole set 
#list to file
rlist <- list.files(pattern="EN")
rlist
import <- lapply(rlist, raster)
import
EN <- stack(import)
plot(EN, col=cl)

# 8. Replicate the plot of images 1 and 13 using the stack 
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

# 9. Compute a PCA over the 13 images
EN_pca <- rasterPCA(EN)
summary(EN_pca$model)
dev.off()
plotRGB(EN_pca$map, r=1, g=2, b=3, stretch="Lin")

# 10. Compute the local varibility (local standard deviation) of the first PCA
PC1sd <- focal(EN_pca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cl)
