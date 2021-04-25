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
png("plot2.png", width = 480, height = 480)

plot(x = a.1$dateTime, 
     y = a.1$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")  

dev.off()

