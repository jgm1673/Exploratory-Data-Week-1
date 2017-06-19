## Week 1 Exercise, Plot 1 
## Read in file from current directory
power<-read.table("household_power_consumption.txt", sep=";", header=TRUE,
                  colClasses = c("character", "character", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric" ), na.strings="?")
## Select columns of interest

base<-select(power, Date, Time, Global_active_power)

## Change Date from character to POSIXct
base$Date<-as.POSIXct(strptime(base$Date, format = "%d/%m/%Y"))

## using dplyr package, get the data for the two days

library(dplyr)
feb<-filter(base, Date==as.POSIXct("2007-2-2") | Date==as.POSIXct("2007-2-1"))

## open png file
png(filename = "Plot1.png", width=480, height=480)

## create histogram

hist(feb$Global_active_power, col="red", main="Global Active Power", 
       xlab="Global Active Power (kilowatts)")
## close device
dev.off()
