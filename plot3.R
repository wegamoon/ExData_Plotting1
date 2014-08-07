# Plot 3
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

# Set data type (to numeric)
ds2$Sub_metering_1 <- as.numeric(ds2$Sub_metering_1)
ds2$Sub_metering_2 <- as.numeric(ds2$Sub_metering_2)
ds2$Sub_metering_3 <- as.numeric(ds2$Sub_metering_3)

Sys.setlocale("LC_TIME", "C")   # Set Locale

# Plotting
par(mfrow=c(1,1))
with(ds2, plot(DT, Sub_metering_1, type='n',
               xlab='', ylab='Energy sub metering'))
with(ds2, points(DT, Sub_metering_1, type='l', col='black'))
with(ds2, points(DT, Sub_metering_2, type='l', col='red'))
with(ds2, points(DT, Sub_metering_3, type='l', col='blue'))
legend('topright', col=c('black', 'red', 'blue'), lty=1,
       legend =c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# export (plot 3)
dev.copy(png, file ='plot3.png', 
         width=480, height=480)   #Copy to my plot to PNG file
dev.off()