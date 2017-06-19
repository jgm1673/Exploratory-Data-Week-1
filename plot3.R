## Week 1 Exercise, Plot 3 - Sub_metering 1-3 vs. time 
## Read in file from current directory
power<-read.table("household_power_consumption.txt", sep=";", header=TRUE,
                  colClasses = c("character", "character", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric" ), na.strings="?")
## Select columns of interest

base<-select(power, Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)
base$Date<-as.POSIXct(strptime(base$Date, format = "%d/%m/%Y"))
base<-filter(base, Date==as.POSIXct("2007-2-2") | Date==as.POSIXct("2007-2-1"))

## Change Date and Time from character to POSIXct
library(dplyr)

result<-base %>% mutate(fixtime = as.POSIXct(strptime(paste(base$Date, " ", base$Time), 
         format = "%Y-%m-%d   %H:%M:%S")))

## open png
png(filename = "Plot3.png", width=480, height=480)
## plot
plot(result$fixtime, result$Sub_metering_1,xlab="", 
     ylab="Energy sub metering (kilowatts)", type="l")
lines(result$fixtime, result$Sub_metering_2, col="red")
lines(result$fixtime, result$Sub_metering_3, col="blue")
## add the legend  ****need to figure out colors
legend("topright", lty=1, col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## close png
dev.off()

