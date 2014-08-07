# Plot 1, assignment 1

# This script draw a histgram 
# You need to prepare 'household_power_consumption.txt' on your
# working directory before running this script.

# read library "data.table"
library(data.table)

# read file
ds <- fread('household_power_consumption.txt',
            colClass = 'character', na.strings = '?')

# extract the data of 1/2/2007 and 2/2/2007
ds2 <- ds[ds$Date == '1/2/2007' | ds$Date == '2/2/2007']
rm(ds)

# Plotting
par(mfrow=c(1,1))
ds2$Global_active_power <- as.numeric(ds2$Global_active_power)
hist(ds2$Global_active_power, col ='red', 
     main ='Global Active Power',
     xlab ='Global Active Power (kilowatts)')

# export (plot 1)
dev.copy(png, file ='plot1.png', 
         width=480, height=480)   #Copy to my plot to PNG file
dev.off()