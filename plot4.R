## Week 1 Exercise, Plot 4 - 4-square plots
## Read in file from current directory
power<-read.table("household_power_consumption.txt", sep=";", header=TRUE,
                  colClasses = c("character", "character", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric" ), na.strings="?")
## Select columns of interest

#base<-select(power, Date, Time, Global_active_power, Global_reactive_power, Sub_metering_1, Sub_metering_2, Sub_metering_3)
power$Date<-as.POSIXct(strptime(power$Date, format = "%d/%m/%Y"))
power<-filter(power, Date==as.POSIXct("2007-2-2") | Date==as.POSIXct("2007-2-1"))

## Change Date and Time from character to POSIXct
library(dplyr)

result<-power %>% mutate(fixtime = as.POSIXct(strptime(paste(power$Date, " ", power$Time), 
        format = "%Y-%m-%d   %H:%M:%S")))

## open png
png(filename = "Plot4.png", width=480, height=480)
## plot
par(mfrow=c(2,2))
## 
## top left graph - same as plot 2 Global active power
plot(result$fixtime, result$Global_active_power,xlab="", 
     ylab="Global Active Power (kilowatts)", type="l")
## top right graph - 
plot(result$fixtime, result$Voltage, xlab="datetime", 
     ylab="Voltage", type ="l")
## bottom left graph - same as plot 3
plot(result$fixtime, result$Sub_metering_1,xlab="", 
     ylab="Energy sub metering (kilowatts)", type="l")
        lines(result$fixtime, result$Sub_metering_2, col="red")
        lines(result$fixtime, result$Sub_metering_3, col="blue")
        ## add the legend  

        legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")

## bottom right graph
plot(result$fixtime, result$Global_reactive_power, xlab="datetime", 
     ylab="Global_rective_power", type="l")
## close png
dev.off()

