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

#plot 2
plot(d1$date_dt, d1$Global_active_power, 
     type = "l", 
     xlab = NA, 
     ylab = "Global Active Power (kilowatts)")


# copy to PNG
dev.copy(png, file = "Exdata_Plotting1\\plot2.png", 
         width = 480, height = 480)

dev.off()
