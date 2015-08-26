library(dplyr)
library(reshape2)

LHC = read.csv("./Datos/Raw/LHC.csv")
COLA = read.csv("./Datos/Raw/Cola.csv")
PESO =read.csv("./Datos/Raw/Peso.csv")

LHC = LHC %>% select(-ENERO)
LHC = melt(LHC, id.vars = c("Tina", "Resguardo", "Silvestre", "MARCA"))
COLA = melt(COLA, id.vars = c("Tina", "Resguardo", "Silvestre", "MARCA"))
PESO = melt(PESO, id.vars = c("Tina", "Resguardo", "Silvestre", "MARCA"))

LHC$variable = gsub("LHC.", "", LHC$variable)
COLA$variable = gsub("COLA.", "", LHC$variable)
PESO$variable = gsub("PESO.", "", LHC$variable)

LHC = LHC %>% rename(LHC = value, Mes = variable)
COLA = COLA %>% rename(COLA = value, Mes = variable)
PESO = PESO %>% rename(PESO = value, Mes = variable)

DATA = cbind(LHC, COLA = COLA[, 6], PESO = PESO[, 6])

DATA = DATA %>%
       mutate(Fecha = rep(seq(as.Date("2015-01-20"),
                               by = "months", length.out = 6), each = 64))
DATA = DATA %>%
        mutate(CambioTina = factor(DATA$Fecha > as.Date("2015-04-01"),
                                   levels = c(FALSE, TRUE),
                                   labels = c("Antes", "Despues"),
                                   ordered = T)) %>%
        mutate(TinaGrande = factor(Tina)) %>%
        mutate(Silvestre= factor(Silvestre))
levels(DATA$Silvestre) = c("UMA", "Silvestre")
levels(DATA$TinaGrande) = rep(1:4, each = 3)

write.csv(DATA, "Datos/Tidy/Datos.csv", row.names = F)
