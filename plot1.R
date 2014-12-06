#Plot 1
plot1 <- function() {

#Download and read file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
con <- unz(temp, "household_power_consumption.txt")
data <- read.table(con, header=TRUE, sep=";", colClasses="character", na.strings="?", nrows = 2075259)
unlink(temp)

#Clean some dates and subset on relevant dates
data[,1] <- as.Date(data$Date,"%d/%m/%Y")
data <- subset(data, data$Date %in% as.Date(c("2007-02-01","2007-02-02")))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

#Change to numeric
data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,6] <- as.numeric(data[,6])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])
data[,9] <- as.numeric(data[,9])

#Change locale, save current in temp
loc <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","C")


#Plot 1
png(filename="C:/Users/thomaswalle-hansen/Documents/RProg/ExData_Plotting1/figure/plot1.png", width = 480, height = 480, units = "px", bg="transparent")
hist(data$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#Close device and reset locale
dev.off()
Sys.setlocale("LC_TIME",loc)

}