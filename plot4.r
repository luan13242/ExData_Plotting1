# read data into memory.
fmt <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

my_data <- read.table("exdata-data-household_power_consumption\\household_power_consumption.txt", 
                      header = TRUE, 
                      stringsAsFactors = FALSE, 
                      sep = ";", 
                      colClasses = fmt, na.strings = "?")

# subset only dates required 
v1 <- grep("^1/2/2007", my_data$Date)
v2 <- grep("^2/2/2007", my_data$Date)
v <- c(v1, v2)
d <- my_data[v,]
# use table(d$Date) to check if all dates subset are right

# save memory
remove(my_data)

# convert string date to POSIXct
new_date <- paste(d$Date, d$Time)
date_dt <- as.POSIXct(new_date, format = "%d/%m/%Y %H:%M:%OS", tz="")

# d1 is the final data set to plot   
d1 <- cbind(d, date_dt)                 

# set plot to be 2x2
par(mfrow = c(2,2), mar = c(4,2,1,1))

# plot A
plot(d1$date_dt, d1$Global_active_power, 
     type = "l", 
     xlab = NA, 
     ylab = "Global Active Power (kilowatts)")

# plot B
plot(d1$date_dt, d1$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

# plot C
plot(d1$date_dt, d1$Sub_metering_1, type = "n", xlab = NA, ylab = "Energy sub metering")
lines(d1$date_dt, d1$Sub_metering_3, type = "l", col = "blue")
lines(d1$date_dt, d1$Sub_metering_2, type = "l", col = "red")
lines(d1$date_dt, d1$Sub_metering_1, type = "l", col = "black")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red","blue"))

# plot D
plot(d1$date_dt, d1$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")


# copy to PNG
dev.copy(png, file = "Exdata_Plotting1\\plot4.png", 
         width = 480, height = 480)

dev.off()
