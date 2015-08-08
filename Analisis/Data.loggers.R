# Data loggers
DL1 = read.csv("Datos/SBT data loggers/1174337.csv", skip = 1)
DL2 = read.csv("Datos/SBT data loggers/1296583.csv", skip = 1)
DL3 = read.csv("Datos/SBT data loggers/1296588.csv", skip = 1)
DL4 = read.csv("Datos/SBT data loggers/1296589.csv", skip = 1)
DL5 = read.csv("Datos/SBT data loggers/2271278.csv", skip = 1)

DL1 = xts(DL1[, 3:4], as.POSIXct(DL1[, 2], format = "%m/%d/%Y %H:%M:%S %p"))
DL2 = xts(DL2[, 3:4], as.POSIXct(DL2[, 2], format = "%m/%d/%Y %H:%M:%S %p"))
DL3 = xts(DL3[, 3:4], as.POSIXct(DL3[, 2], format = "%m/%d/%Y %H:%M:%S %p"))
DL4 = xts(DL4[, 3:4], as.POSIXct(DL4[, 2], format = "%m/%d/%Y %H:%M:%S %p"))
DL5 = xts(DL5[, 3:4], as.POSIXct(DL5[, 2], format = "%m/%d/%Y %H:%M:%S %p"))

Temp = cbind(DL1[, 1], DL2[, 1], DL3[, 1], DL4[, 1], DL5[, 1])
Luz =  cbind(DL1[, 2], DL2[, 2], DL3[, 2], DL4[, 2], DL5[, 2])
names(Temp) = paste("Data Logger", 1:5, sep = " ")
names(Luz) = paste("Data Logger", 1:5, sep = " ")

dygraph(apply.daily(Temp, mean, na.rm = T)) %>% dyRoller()
dygraph(apply.daily(Luz, mean, na.rm = T)) %>% dyRoller()
