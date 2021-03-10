## Import data

dball <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
# Filter for dates in scope
dbday <- subset(dball, Date == "1/2/2007"| Date == "2/2/2007")
# Join date and time columns and specify format
dbday$Date <- paste(dbday$Date, dbday$Time)
dbday$Date <- strptime(dbday$Date, format = "%d/%m/%Y %H:%M:%S")
colnames(dbday)[1] <- "DateTime"
# Drop Time column
dbday$Time <- NULL
# Substitute "?" with NA
grep("?", NA, dbday)
# Change column classes with numeric
dbday[,2:7] <- apply(dbday[,2:7], 2, function(x) as.numeric(as.character(x)))

## Ready to plot!

png("plot4.png")

  # Set matrix size
  par(mfrow = c(2,2))

  # Graph 1
  with(dbday, plot(DateTime, Global_active_power, 
                   type = "l", lty = 1, 
                   xlab = "",
                   ylab = "Global Active Power (in kilowatts)"))
  
  # Graph 2
  with(dbday, plot(DateTime, Voltage, 
                   type = "l", lty = 1, 
                   xlab = "datetime",
                   ylab = "Voltage"))
  
  # Graph 3
  with(dbday, plot(DateTime, Sub_metering_1, 
                   type = "l",
                   xlab = "",
                   ylab = "Energy sub metering")) 
  lines(dbday$DateTime, dbday$Sub_metering_2, col = "red")
  lines(dbday$DateTime, dbday$Sub_metering_3, col = "blue")
  legend("topright", 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col=c("black","red", "blue"),
         lty = 1)
  
  # Graph 4
  with(dbday, plot(DateTime, Global_reactive_power, 
                   type = "l", lty = 1, 
                   xlab = "datetime",
                   ylab = "Global_reactive_power"))
  
dev.off()