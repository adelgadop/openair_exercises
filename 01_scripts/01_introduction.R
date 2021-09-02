# Install packages (comment after the instalation)
# install.packages("tidyverse")
# install.packages("gridExtra") # join figures

# Call the necessary libraries
library(openair)
library(tidyverse)
library(colorspace)
library(gridExtra)


# Verify some functions of the openair package ----------------------------

# polarplot function

# Save the figure as pdf
pdf("03_output/fig/polarplot_mydata1.pdf",
    width = 4,
    height = 3.5)

polarPlot(mydata) # "mydata" is a DataFrame automatically available when 
# we call the library openair

dev.off() # close the device


# Wind Rose plots
pdf("03_output/fig/wrose_mydata.pdf", width = 5, height = 5)
windRose(mydata, cols = qualitative_hcl(4, palette = "Dark 3"))
dev.off()

pdf("03_output/fig/wrose_mydata_years.pdf", width = 10, height = 6)
windRose(mydata, type = 'year', layout = c(4, 2),
         cols = qualitative_hcl(4, palette = "Dark 3"))
dev.off()

pdf("03_output/fig/wrose_by_pm.pdf", width = 10, height = 4)
windRose(mydata, type = 'pm10', layout = c(4, 1),
         cols = qualitative_hcl(4, palette = "Dark 3"))
dev.off()


a <- windRose(mydata, angle = 22.5, bias.corr = FALSE, 
              main = 'without bias correction') # without bias correction
b <- windRose(mydata, angle = 22.5, 
              main = "with bias correction") # with bias correction (default)

pdf("03_output/fig/wrose_by_biascorr.pdf", width = 10, height = 5)
grid.arrange(a$plot, b$plot, nrow = 1, ncol = 2)
dev.off()

# Pollution Rose


pdf("03_output/fig/polrose_nox_so2.pdf", width = 10, height = 3)
pollutionRose(mydata, pol = 'nox', type = 'so2', layout = c(4, 1))
dev.off()

# Polar frequencies
pdf("03_output/fig/polfreq_year.pdf", width = 10, height = 9)
polarFreq(mydata, type = 'year')
dev.off()

pdf("03_output/fig/polfreq_nox.pdf", width = 5, height = 4)
polarFreq(mydata, pollutant = "nox", ws.int = 30, 
          statistic = "weighted.mean",
          offset = 80, trans = FALSE, 
          col = "heat")
dev.off()

# Percentile rose

pdf("03_output/fig/percRose_o3.pdf", width = 5, height = 6)
percentileRose(mydata, pol='o3')
dev.off()

pdf("03_output/fig/percRose_so2.pdf", width = 5.5, height = 5)
percentileRose(mydata, pollutant = "so2",
               percentile = c(25, 50, 75, 90, 95, 99, 99.9),
               col = "brewer1", key.position = "right", smooth = TRUE)
dev.off()

# if we need to plot by season and period of time (nighttime and daylight), we can do this:
pdf("03_output/fig/percRose_o3_by_season_day.pdf", width = 10, height = 6)
percentileRose(mydata, 
               type = c("season", "daylight"),  # this is important for openair
               pollutant = "o3",
               col = "Set3", mean.col = "black")
dev.off()

# conditional probability function
pdf("03_output/fig/percRose_cpf_so2.pdf", width = 5.5, height = 5)
percentileRose(mydata, poll="so2", percentile = 95, 
               method = "cpf",
               col = "darkorange", smooth = TRUE)
dev.off()
