# Install a package
# install.packages("worldmet")

# Call the necessary libraries
library(worldmet)
library(openair)
library(tidyverse)

# Section 4 Access meteorological data
getMeta(lat = 38.7, lon = -9.17, returnMap = T) # Porto

lisb_met <- importNOAA(code = "085350-99999", year = 2017)


# Wind rose ---------------------------------------------------------------
pdf("03_output/fig/lisb_met_windrose.pdf", 5, 5)
windRose(lisb_met)
dev.off()

windRose(lisb_met, type = "month", layout = c(4, 3),
         paddle = F,
         grid.line = 20)


# Temporal variations -----------------------------------------------------

pdf("03_output/fig/lisb_met_tvar_norm.pdf", 10, 7)
timeVariation(lisb_met, pol = c("air_temp", "RH"),
              normalise = T)
dev.off()

myOutput <- timeVariation(lisb_met, pollutant = "air_temp")

myOutput$data$day.hour # are the weekday and hour results
myOutput$data$hour ## are the diurnal results
myOutput$data$day ## are the weekday results
myOutput$data$month ## are the monthly results

## just the diurnal variation
plot(myOutput, subset = "hour")
## day and hour
plot(myOutput, subset = "day.hour")
## weekday variation
plot(myOutput, subset = "day")
## monthly variation
plot(myOutput, subset = "month")

