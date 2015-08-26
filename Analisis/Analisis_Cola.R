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

Datos = read.csv("./Datos/Tidy/Datos.csv")
Cola = dcast(Datos, TinaGrande + Tina + MARCA + Resguardo + Silvestre ~ Fecha,
             value.var = "COLA")

ID = Cola[, 1:5]
Cola_XTS = t(Cola[, -(1:5)])
colnames(Cola_XTS) = ID$MARCA
Cola_XTS = xts(Cola_XTS, order.by = as.Date(rownames(Cola_XTS)))

# model = lmer(COLA ~ Resguardo + (1|TinaGrande/Tina/MARCA), data = Datos)
model_COLA = lme(COLA ~ Resguardo, Datos, ~ 1|TinaGrande/Tina/MARCA,
            na.action = na.exclude)
