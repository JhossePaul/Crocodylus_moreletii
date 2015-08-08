################################################################################
#      Evaluación del crecimiento en cautiverio de Crocodylus moreletii        #
#                        en ausencia de refugio                                #
################################################################################
## Análisis de datos por Biol. Jhosse Paul Márquez Ruíz
# Paqueterias ####
library(XLConnect)
library(dplyr)
library(xts)
library(dygraphs)

# Limpieza de datos
Cocodrilos = readWorksheetFromFile("./Datos/datos.xlsx", 1)
Cocodrilos[Cocodrilos == "x"] = NA

Cocodrilos = Cocodrilos %>%
        select(1:22) %>%
        rename(Tina = ENERO) %>%
        filter(!is.na(Cocodrilos[, 1])) %>%
        group_by(Tina, MARCA) %>%
        mutate_each(funs(as.numeric))

rownames(Cocodrilos) = paste(Cocodrilos$Tina, Cocodrilos$MARCA)

LHC = Cocodrilos %>%
        select(grep("LHC", names(Cocodrilos))) %>%
        split(f = Cocodrilos$Tina)
COLA = Cocodrilos %>%
        select(grep("COLA", names(Cocodrilos))) %>%
        split(f = Cocodrilos$Tina)
PESO = Cocodrilos %>%
        select(grep("PESO", names(Cocodrilos))) %>%
        split(f = Cocodrilos$Tina)

