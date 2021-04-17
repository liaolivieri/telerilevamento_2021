# R_code_knitr.r

#Il pacchetto knitr può usare un codice esterno per creare un report
#Si prende il codice all'esterno e lo importa, e genererà un report è verrà salvato nella cartella in cui è salvato il codcie

#Pacchetti da istallare:
#install.packages("knitr")

#Librerie:
library(knitr)

setwd("C:/lab/") # Windows
# Generà il report
stitch("C:/lab/R_code.greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
# Mi genererà un file con estension .tex

