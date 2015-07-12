library(dplyr)

## --------------------------------Loading data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp, method = "curl")
list.files <- unzip(temp, list = TRUE) ## all available files

## ------------------------------- getting data 
data <- read.table(unz(temp, list.files[1, 1]), sep = ";", na.string = "?", 
                   colClasses = c("character", "character", rep("numeric", 7)), header = FALSE,
                   nrows = 10000, skip = 60000, col.names = c("Date", "Time", "Global_active_power",
                                                              "Global_reactive_power", 
                                                              "Voltage", "Global_intensity", 
                                                              "Sub_metering_1", "Sub_metering_2", 
                                                              "Sub_metering_3"))

## Dates
data <- mutate(data, Date = as.Date(Date, format = c("%d/%m/%Y")))
data$Time <- strptime(paste(data$Date, data$Time), format = c("%Y-%m-%d %H:%M:%S"))

## subseting
data <- subset(data, Date %in% as.Date(c("2007-02-01", "2007-02-02")))

## --------------------------------Making plot
png("plot1.png", width = 480, height = 480, units = "px")
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", 
     main = "Global Active Power")
dev.off()


