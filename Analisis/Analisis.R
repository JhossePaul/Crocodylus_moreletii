################################################################################
#      Evaluación del crecimiento en cautiverio de Crocodylus moreletii        #
#                        en ausencia de refugio                                #
################################################################################
## Análisis de datos por Biol. Jhosse Paul Márquez Ruíz
# Paqueterias ####
library(Matrix)
library(RColorBrewer)
library(dplyr)
library(xts)
library(dygraphs)
library(reshape2)
library(rCharts)
library(nlme)
library(ggplot2)

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
        dyOptions(drawPoints = T, pointSize = 2)



LHC = melt(as.data.frame(LHC))

LHC$Tina = rep(ID$Tina, each = 6)
LHC$Resguardo = as.factor(rep(ID$Resguardo, each = 6))
LHC$Silvestre = as.factor(rep(ID$Silvestre, each = 6))
names(LHC)[1:2] = c("Marca", "LHC")
LHC$Marca = as.factor(LHC$Marca)
LHC$Tiempo = rep(1:6, 64)
LHC$TinaGrande = as.factor(LHC$Tina)
levels(LHC$TinaGrande) = rep(1:4, each = 3)


model = lme(fixed = LHC ~ Tiempo + Resguardo, random = ~ 1| TinaGrande/Tina, data  = LHC, na.action = na.exclude)
summary(model)

ggplot(LHC, aes(x = factor(Marca), y = LHC)) +
        facet_grid(. ~ TinaGrande + Tina, scales = "free") +
        geom_boxplot(aes(color = factor(Resguardo))) +
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        labs(title = "Longitud Hocico-Cloca") +
        labs(x = "Marca", y = "LHC", color = "Resguardo")
