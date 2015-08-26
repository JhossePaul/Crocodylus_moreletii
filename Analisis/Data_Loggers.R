library(xts)
library(dplyr)

# Data loggers
Tina1 = read.csv("../Datos/Tidy/Data Loggers//1174337.csv", skip = 1)
Tina2 = read.csv("../Datos/Tidy/Data Loggers//1296583.csv", skip = 1)
Tina3 = read.csv("../Datos/Tidy/Data Loggers//1296588.csv", skip = 1)
Ambiental = read.csv("../Datos/Tidy/Data Loggers//1296589.csv",
                     skip = 1)
Tina4 = read.csv("../Datos/Tidy/Data Loggers//2271278.csv", skip = 1)

Tina1 = xts(Tina1[, 3:4],
            as.POSIXct(Tina1[, 2], format = "%m/%d/%Y %H:%M:%S %p"))
Tina2 = xts(Tina2[, 3:4],
            as.POSIXct(Tina2[, 2], format = "%m/%d/%Y %H:%M:%S %p"))
Tina3 = xts(Tina3[, 3:4],
            as.POSIXct(Tina3[, 2], format = "%m/%d/%Y %H:%M:%S %p"))
Ambiental = xts(Ambiental[, 3:4],
                as.POSIXct(Ambiental[, 2], format = "%m/%d/%Y %H:%M:%S %p"))
Tina4 = xts(Tina4[, 3:4],
            as.POSIXct(Tina4[, 2], format = "%m/%d/%Y %H:%M:%S %p"))

Temp = cbind(Tina1[, 1], Tina2[, 1], Tina3[, 1], Ambiental[, 1], Tina4[, 1])
Luz =  cbind(Tina1[, 2], Tina2[, 2], Tina3[, 2], Ambiental[, 2], Tina4[, 2])
Temp = apply.daily(Temp, mean, na.rm = T)
Luz = apply.daily(Luz, mean, na.rm = T)
names(Temp) = names(Luz) = c("Tina 1", "Tina 2", "Tina 3", "Ambiental", "Tina 4")
