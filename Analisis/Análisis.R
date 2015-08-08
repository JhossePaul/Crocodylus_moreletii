################################################################################
#      Evaluación del crecimiento en cautiverio de Crocodylus moreletii        #
#                        en ausencia de refugio                                #
################################################################################
## Análisis de datos por Biol. Jhosse Paul Márquez Ruíz
# Paqueterias ####
library(RColorBrewer)
library(xts)
library(dygraphs)

# Limpieza de datos
LHC = read.csv("./Datos/Tidy/LHC.csv")
ID = LHC[, 1:5]
LHC = t(LHC[, -(1:5)])
colnames(LHC) = ID$MARCA
LHC = xts(LHC,
          order.by = seq.Date(from = as.Date("2015-01-200"),
                              by = "months", length.out = 6)
          )

colores = brewer.pal(12, "Set3")

dygraph(data = LHC[, ID$Tina == 1],
        main = "LHC", xlab = paste("Tina:", 1), group = "LHC") %>%
        dyAxis("x", rangePad = 20) %>%
        dyLegend(show = "never") %>%

        dyOptions(drawPoints = T, pointSize = 2,
                  colors = [1])
