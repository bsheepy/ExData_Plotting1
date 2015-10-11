#
#  plot3.R
#
#  To make plot 3 
#

# download data
if(!dir.exists("./data")){dir.create("./data")}
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataURL, "./data/epc.zip")

# read it in
epcdata <- read.table(unz("./epc.zip", "household_power_consumption.txt"), header = TRUE, na.strings = "?", sep = ";")

# fix dates
epcdata$DateTime<-paste(epcdata$Date, epcdata$Time, sep = " ")
epcdata$DateTime<-strptime(epcdata$DateTime, format = "%d/%m/%Y %H:%M:%S")
epcdata$Date<-as.Date(epcdata$Date,"%d/%m/%Y")

# subset by dates
ndates<-as.Date(c("2007/02/01", "2007/02/02"), "%Y/%m/%d")
epcdata<-epcdata[epcdata$Date %in% ndates,]

# plot the graph
plot(epcdata$DateTime, epcdata$Sub_metering_1, type = "n",xlab = "", ylab = "Energy sub metering")
lines(epcdata$DateTime, epcdata$Sub_metering_1, col = "black")
lines(epcdata$DateTime, epcdata$Sub_metering_2, col = "red")
lines(epcdata$DateTime, epcdata$Sub_metering_3, col = "blue")
title(main = "")
legend("topright", lty = 1 , col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file = "plot3.png")
dev.off()