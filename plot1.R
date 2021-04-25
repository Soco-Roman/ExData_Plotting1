library(data.table)
# read table
a <- data.table::fread(input = "D:/Course/Data/4/household_power_consumption.txt",
                       na.strings = "?")

# subset the specific dates
a.1 <- subset(a, Date == "1/2/2007" | Date == "2/2/2007")

# change date format
a.1$Date <- as.Date(a.1$Date, "%d/%m/%Y")

# Convert Global active power data into numeric format
a.1[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Plot 1, PNG file
png("plot1.png", width = 480, height = 480)

hist(a.1[, Global_active_power], 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.off()
