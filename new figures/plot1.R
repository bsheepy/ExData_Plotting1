#
#  plot1.R
#
#  To make plot 1 
#

# download data

if(!dir.exists("./data")){dir.create("./data")}
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataURL, "./data/epc.zip")

# read it in
epcdata <- read.table(unz("./data/epc.zip", "household_power_consumption.txt"), header = TRUE, na.strings = "?", sep = ";")

# fix dates
epcdata$Date<-as.Date(epcdata$Date,"%d/%m/%Y")

# subset by dates
ndates<-as.Date(c("2007/02/01", "2007/02/02"), "%Y/%m/%d")
epcdata<-epcdata[epcdata$Date %in% ndates,]

# making the graph
hist(epcdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()
