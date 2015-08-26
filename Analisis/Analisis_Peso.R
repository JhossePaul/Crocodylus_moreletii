################################################################################
#      Evaluación del crecimiento en cautiverio de Crocodylus moreletii        #
#                        en ausencia de refugio                                #
################################################################################
## Análisis de datos por Biol. Jhosse Paul Márquez Ruíz
# Paqueterias ####
library(reshape2)
library(xts)
library(dygraphs)
library(nlme)
library(lme4)

Datos = read.csv("../Datos/Tidy/Datos.csv")
Peso = dcast(Datos, TinaGrande + Tina + MARCA + Resguardo + Silvestre ~ Fecha,
            value.var = "PESO")

ID = Peso[, 1:5]
Peso_XTS = t(Peso[, -(1:5)])
colnames(Peso_XTS) = ID$MARCA
Peso_XTS = xts(Peso_XTS, order.by = as.Date(rownames(Peso_XTS)))

# model = lmer(Peso ~ Resguardo + (1|TinaGrande/Tina/MARCA), data = Datos)
model_Peso = lme(PESO ~ Resguardo, Datos, ~ 1|TinaGrande/Tina/MARCA,
                na.action = na.exclude)
