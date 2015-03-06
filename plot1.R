## Create Plot 1 for Exploratory Data Analysis - Project 1

## Check if the necessary zip file already exists
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


## Subset the data for only the dates 2007-02-01 and 2007-02-02 and reformat the date
startDate <- as.Date("01/02/2007", format="%d/%m/%Y")
endDate <- as.Date("02/02/2007", format="%d/%m/%Y")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- data[data$Date >= startDate & data$Date <= endDate, ]

## Create the histogram plot
png(filename <- "plot1.png", width=480, height=480)  ## Open png device to create and save .png file of plot
hist(data$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", col="red")  
dev.off()  ## Close png device