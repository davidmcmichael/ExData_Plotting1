## Create Plot 3 for Exploratory Data Analysis - Project 1

## Check if zip file already exists
filename <- "plot_data.zip"
if (!file.exists(filename)) {
  exdata <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                          destfile = filename,
                          method = "curl")
}

## Read and import datafile "household_power_consumption.txt" from the zip file
data <- read.csv(unz(filename, "household_power_consumption.txt"), header=T,
                 sep=";", stringsAsFactors=F, na.strings="?",
                 colClasses=c("character", "character", "numeric",
                              "numeric", "numeric", "numeric",
                              "numeric", "numeric", "numeric"))

## Format the date and time and subset the data for the dates 2007-02-01 and 2007-02-02
data$timestamp <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate <- strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate <- strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
data <- data[data$timestamp >= startDate & data$timestamp <= endDate, ]

## Create plot 3
png(filename="plot3.png", width=480, height=480) ## Open png device to create and save .png file of plot
plot(data$timestamp, data$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
lines(data$timestamp, data$Sub_metering_2, col="red")
lines(data$timestamp, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"))
dev.off() ## Close png Device