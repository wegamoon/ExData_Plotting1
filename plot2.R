# Plotting 2

# You need to prepare 'household_power_consumption.txt' on your
# working directory before running this script.

# read library "data.table"
library(data.table)

# read file using fread
ds <- fread('household_power_consumption.txt',
            colClass = 'character', na.strings = '?')

# extract the data of 1/2/2007 and 2/2/2007
ds2 <- ds[ds$Date == '1/2/2007' | ds$Date == '2/2/2007']
rm(ds)

# Make DT(date and time) colomn and convert to date format (POSIX.ct)
ds2[,DT:={d <- paste(Date, Time); as.POSIXct(d, format ="%d/%m/%Y %H:%M:%S")}]

# Set Locale
Sys.setlocale("LC_TIME", "C") 

# set data type
ds2$Global_active_power <- as.numeric(ds2$Global_active_power)

# Plotting
par(mfrow=c(1,1))
with(ds2, plot(DT, Global_active_power, type='l', 
               xlab ='',
               ylab = 'Global Active Power (kilowatts)'))

# export (plot 2)
dev.copy(png, file ='plot2.png', 
         width=480, height=480)   #Copy to my plot to PNG file
dev.off()