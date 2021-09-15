library(openair)
library(tidyverse)


# Trends functions from openair package -----------------------------------

pdf("03_output/fig/trend_nox.pdf", 10, 6)
trendLevel(mydata, pol = 'nox')
dev.off()

# Another example from the book NOx by wind direction
pdf("03_output/fig/trend_nox_by_wd.pdf", 10, 6)
trendLevel(mydata, pol = 'nox', y = 'wd',
           border = 'white',
           cols = 'jet')
dev.off()

# A plot of mean O3 concentration shown by season and by daylight/nightime hours

pdf("03_output/fig/trend_no3_by_season_day.pdf", 8, 6)
trendLevel(mydata, x = 'season', y = 'daylight', pol = 'o3')
dev.off()

# O3 concentration by season and hour
trendLevel(mydata, x = "season", y = "hour", 
           pollutant = "o3",
           cols = "increment")

