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
LHC = dcast(Datos, TinaGrande + Tina + MARCA + Resguardo + Silvestre ~ Fecha,
            value.var = "LHC")

ID = LHC[, 1:5]
LHC_XTS = t(LHC[, -(1:5)])
colnames(LHC_XTS) = ID$MARCA
LHC_XTS = xts(LHC_XTS, order.by = as.Date(rownames(LHC_XTS)))

# model = lmer(LHC ~ Resguardo + (1|TinaGrande/Tina/MARCA), data = Datos)
model_LHC = lme(LHC ~ Resguardo, Datos, ~ 1|TinaGrande/Tina/MARCA,
                 na.action = na.exclude)
