## Week 1 Exercise, Plot 2 - Global Active Power vs time 
## Read in file from current directory
power<-read.table("household_power_consumption.txt", sep=";", header=TRUE,
                  colClasses = c("character", "character", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric" ), 
                  na.strings="?")
## Select columns of interest

base<-select(power, Date, Time, Global_active_power)
base$Date<-as.POSIXct(strptime(base$Date, format = "%d/%m/%Y"))
base<-filter(base, Date==as.POSIXct("2007-2-2") | Date==as.POSIXct("2007-2-1"))

## Change Date and Time from character to POSIXct
library(dplyr)

result<-base %>% mutate(fixtime = as.POSIXct(strptime(paste(base$Date, " ", base$Time), 
                format = "%Y-%m-%d   %H:%M:%S")))

## open png
png(filename = "Plot2.png", width=480, height=480)
## plot
plot(result$fixtime, result$Global_active_power,xlab="", 
     ylab="Global Active Power (kilowatts)", type="l")
## close png
dev.off()

