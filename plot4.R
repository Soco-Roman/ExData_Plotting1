## Change the language of the plot
Sys.setlocale("LC_ALL", "English")
# libraries
library(data.table)

# read table
a <- data.table::fread(input = "D:/Course/Data/4/household_power_consumption.txt",
                       na.strings = "?")

# subset the specific dates
a.1 <- subset(a, Date == "1/2/2007" | Date == "2/2/2007")

# change date and time format
a.1[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Convert Global active power data into numeric format
a.1[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Plot 1, PNG file
png("plot4.png", width = 480, height = 480)

# for 4 plots in the same image
par(mfrow = c(2,2))

# plot 1
plot(x = a.1$dateTime, 
     y = a.1$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power") 

# plot 2
plot(x = a.1$dateTime,
     y = a.1$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# plot 3
plot(x = a.1$dateTime,
     y = a.1$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(x = a.1$dateTime,
      y = a.1$Sub_metering_2,
      col = "red")
lines(x = a.1$dateTime,
      y = a.1$Sub_metering_3,
      col = "blue")
legend("topright",
       col = c("black", "red", "blue"),
       legend = c ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1),
       lwd = c(1,1))

# plot 4
plot(x = a.1$dateTime,
     y = a.1$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()
