#Plot 4
plot4 <- function() {
  
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
  
  #Plot 4
  png(filename = "C:/Users/thomaswalle-hansen/Documents/RProg/ExData_Plotting1/figure/plot4.png", width = 480, height = 480, units = "px", bg="transparent")
  
  #Set up 2x2 grid
  par(mfrow = c(2, 2), mar = c(8, 4, 2, 2), cex=0.8)
  
  #Top left - plot 2
  plot(data$DateTime, data$Global_active_power, type= "l", main ="", xlab="",ylab="Global Active Power (kilowatts)")
  
  #Top right
  plot(data$DateTime, data$Voltage, type= "l", main ="", xlab="datetime",ylab="Voltage")
  
  #Bottom left - plot 3
  plot(data$DateTime, data$Sub_metering_1, type= "l", main ="", xlab="",ylab="Energy sub metering")
  lines(data$DateTime,data$Sub_metering_2, type="l", col="red")
  lines(data$DateTime,data$Sub_metering_3, type="l", col="blue")
  legend(x="topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("Black","Red","Blue"), lwd=1, bty = "n", cex=0.9)
  
  #Bottom right
  plot(data$DateTime, data$Global_reactive_power, type= "l", main ="", xlab="datetime",ylab="Global_reactive_power")
  
  
  #Close device and reset locale
  dev.off()
  Sys.setlocale("LC_TIME",loc)

}