# Plot 4
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

# Set other data type
ds2$Global_active_power <- as.numeric(ds2$Global_active_power)
ds2$Global_reactive_power <- as.numeric(ds2$Global_reactive_power)
ds2$Voltage <- as.numeric(ds2$Voltage)
ds2$Sub_metering_1 <- as.numeric(ds2$Sub_metering_1)
ds2$Sub_metering_2 <- as.numeric(ds2$Sub_metering_2)
ds2$Sub_metering_3 <- as.numeric(ds2$Sub_metering_3)

# Make DT(date and time) colomn and convert to date format (POSIX.ct)
ds2[,DT:={d <- paste(Date, Time); as.POSIXct(d, format ="%d/%m/%Y %H:%M:%S")}]

Sys.setlocale("LC_TIME", "C")   # Set Locale

#Lay-out
par(mfrow=c(2, 2), mar=c(4, 4, 2, 1), oma=c(0, 0, 2, 0))

#Plot 4-1 (= Plot 2)
with(ds2, plot(DT, Global_active_power, type='l', 
               xlab ='',
               ylab = 'Global Active Power'))

#Plot 4-2
with(ds2, plot(DT, Voltage, type='l',
               xlab='datetime', ylab='Voltage'))

#Plot 4-3 (= Plot 3)
with(ds2, plot(DT, ds2$Sub_metering_1, type='n',
               xlab='', ylab='Energy sub metering'))
with(ds2, points(DT, Sub_metering_1, type='l', col='black'))
with(ds2, points(DT, Sub_metering_2, type='l', col='red'))
with(ds2, points(DT, Sub_metering_3, type='l', col='blue'))
legend('topright', col=c('black', 'red', 'blue'), lty=1,
       legend =c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), bty='n')

#Plot 4-4
with(ds2, plot(DT, Global_reactive_power, type='l',
               xlab='datetime', ylab ='Global_reactive_power'))

# export (plot 4)
dev.copy(png, file ='plot4.png', 
         width=480, height=480)   #Copy to my plot to PNG file
dev.off()