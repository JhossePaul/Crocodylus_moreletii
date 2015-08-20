################################################################################
#      Evaluación del crecimiento en cautiverio de Crocodylus moreletii        #
#                        en ausencia de refugio                                #
################################################################################
## Análisis de datos por Biol. Jhosse Paul Márquez Ruíz
# Paqueterias ####
library(dplyr)
library(xts)
library(dygraphs)
library(reshape2)
library(rCharts)
library(lme4)
library(ggplot2)

LHC = read.csv("./Datos/Tidy/LHC.csv")
ID = LHC[, 1:5]
LHC = t(LHC[, -(1:5)])
colnames(LHC) = ID$MARCA
LHC = xts(LHC,
          order.by = seq.Date(from = as.Date("2015-01-200"),
                              by = "months", length.out = 6)
          )


# dygraph(data = LHC[, ID$Tina == 1],
#         main = "LHC", xlab = paste("Tina:", 1), group = "LHC") %>%
#         dyAxis("x", rangePad = 20) %>%
#         dyLegend(show = "never") %>%
#         dyOptions(drawPoints = T, pointSize = 2)

muertos = apply(LHC, 2, function(x) length(na.omit(x))) == 0
# LHC = LHC[, !muertos]
LHC = melt(as.data.frame(LHC))

LHC$Tina = factor(rep(ID[!muertos, "Tina"], each = 6))
LHC$Resguardo = factor(rep(ID[!muertos, "Resguardo"], each = 6))
LHC$Silvestre = factor(rep(ID[!muertos, "Silvestre"], each = 6))
names(LHC)[1:2] = c("Marca", "LHC")
LHC$Marca = factor(LHC$Marca)
LHC$Tiempo = rep(1:6, length(unique(LHC$Marca)))
LHC$TinaGrande = factor(LHC$Tina)
levels(LHC$TinaGrande) = rep(1:4, each = 3)

# ggplot(LHC, aes(x = factor(Marca), y = LHC)) +
#         facet_grid(. ~ TinaGrande + Tina, scales = "free") +
#         geom_boxplot(aes(color = factor(Resguardo))) +
#         theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
#         labs(title = "Longitud Hocico-Cloca") +
#         labs(x = "Marca", y = "LHC", color = "Resguardo")

model = lmer(LHC ~ Resguardo + (1|TinaGrande/Tina/Marca), data = LHC)
anova(model)
summary(model)


