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

png("plot2.png")

with(dbday, plot(DateTime, Global_active_power, 
                 type = "l", lty = 1, 
                 ylab = "Global Active Power (in kilowatts)"))

dev.off()