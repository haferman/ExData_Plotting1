## For cousera "Exploratory Data Analysis" plot 3
## See full description at https://github.com/haferman/ExData_Plotting1
##
## move into working directory and download dataset

setwd("~/Z-R/ExData")
if(!file.exists('household_power_consumption.zip')){
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,destfile = "household_power_consumption.zip")
}

## setup file for reading
unzip("household_power_consumption.zip")
f <- file("household_power_consumption.txt")

## read data, subsetting the dates from 2007-02-01 and 2007-02-02
powerdata <- read.table(text = grep("^[1,2]/2/2007", readLines(f), value = TRUE), 
                        col.names = c("Date", "Time", "Global_active_power", 
                                      "Global_reactive_power", "Voltage", "Global_intensity",
                                      "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                        sep = ";", header = TRUE, na.strings="?")

# reformat date
powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y")

# create date-time field
datetime <- paste(as.Date(powerdata$Date), powerdata$Time)
powerdata$datetime <- as.POSIXct(datetime)

## plot to screen
with(powerdata, {
  plot(Sub_metering_1 ~ datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ datetime, col = 'Red')
  lines(Sub_metering_3 ~ datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# write to png file
png(filename='plot3.png',width=480,height=480,units='px')
with(powerdata, {
  plot(Sub_metering_1 ~ datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ datetime, col = 'Red')
  lines(Sub_metering_3 ~ datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()