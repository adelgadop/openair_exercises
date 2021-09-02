
# Call the necessary libraries
library(openair)
library(tidyverse)
library(colorspace)
library(gridExtra)



# Examples of time series plotting ----------------------------------------

timePlot(mydata, pollutant = c("nox", "o3"), y.relation = "free")

pdf("03_output/fig/timePlot_normalised.pdf", 8, 5)
timePlot(mydata, 
         pollutant = c("nox", "no2", "co", "so2", "pm10"),
         avg.time = "year", normalise = "1/1/1998", 
         lwd = 4, lty = 1,
         group = TRUE, ylim = c(0, 120))
dev.off()

pdf("03_output/fig/timePlot_arows.pdf", 10, 5)
timePlot(head(mydata, 48), pollutant = c("nox", "no2"), 
         windflow = list(scale = 0.1, lwd = 2, col = "turquoise4"), 
         lwd = 3, group = FALSE, 
         ylab = "concentration (ug/m3)")
dev.off()