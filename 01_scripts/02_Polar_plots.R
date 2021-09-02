# Install a package
install.packages('devtools')

# Install from GitHub the package 'openairmaps'
library(devtools)
install_github("davidcarslaw/openairmaps")

# Call the necessary libraries
library(openair)
library(tidyverse)
library(colorspace)
library(gridExtra)
library(openairmaps)


# Polar plots functions ---------------------------------------------------

polarPlot(mydata, pollutant = "nox", col = "jet", 
          key.position = "bottom",
          key.header = "mean nox (ug/m3)", 
          key.footer = NULL)


# using tidyverse we can use mathematical operations to create another variables
# inside our data frame

mydata <- mutate(mydata, ratio = so2 / nox) # tidyverse function
mydata$ratio2 <- mydata$so2 / mydata$nox # manually

summary(mydata$ratio)

# we can filter the data (command belonging dplyr package)
polarPlot(filter(mydata, ratio < 0.1), pollutant = "ratio")

pdf("03_output/fig/polarplot_so2_by_hour.pdf", width = 12, height = 12)
polarPlot(mydata, pollutant = "so2", type = "hour", min.bin = 2)
dev.off()

# Comparing two time periods ----------------------------------------------
port_talbot <- importAURN(site = "pt4", year = c(2012, 2019))

# polar differences
 
pdf("03_output/fig/polarplot_so2_diff.pdf", width = 5, height = 5)
polarDiff(before = selectByDate(port_talbot, year = 2012), 
          after = selectByDate(port_talbot, year = 2019), 
          pollutant = "so2")
dev.off()


# Polar plots on an interactive map ---------------------------------------

glimpse(polar_data)

polarMap(polar_data, 
         latitude = "latitude", 
         longitude = "longitude",
         type = "site")


polarMap(polar_data, 
         latitude = "latitude", 
         longitude = "longitude",
         type = "site", 
         provider = "Stamen.Toner")

