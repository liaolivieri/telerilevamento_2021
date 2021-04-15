# R_code_copernicus.r
# Visualizing copernicus data

# install.packages("ncdf4")

library(raster)
library(ncdf4)

# setwd("C:/lab/") # Windows

# Diamo un nome al nostro set
ndvi <- raster ("c_gls_NDVI300_202010010000_GLOBE_PROBAV_V1.0.1.nc")

cl <- colorRampPalette(c('light blue','blue','red','yellow'))(100)
plot(ndvi, col=cl)
 
# La funzione aggregate va ad aggregare vari pixel al fine di alleggerire la mia immagine che quindi avrà un numero ristretto di pixel
# Uso il fact nella mia funzione es fact=100 ogni 100 pixel avrò 1 pixel (linearmente 100x100 pixel li trasformiamo in 1 pixel)
# Ricampionamento bilaterale (resampling)
ndvires <- aggregate(ndvi, fact=100)
plot(ndvires, col=cl)
