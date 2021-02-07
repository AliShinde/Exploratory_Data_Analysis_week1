#Reading the dataset 
datafile <- read.table("D:/EDA/EDA_spe/household_power_consumption.txt",
                       header = TRUE, sep = ";",comment.char = "")
#Converting the date column to the class "DATE" from "CHARACTER"
datafile$Date <- as.Date(datafile$Date, format = "%d/%m/%Y")

#Subsetting the data for the required dates i.e 1st and 2nd Feb 2007
req_data <- subset(datafile, Date == as.Date("01/02/2007",format = "%d/%m/%Y")
                   | Date == as.Date("02/02/2007", format = "%d/%m/%Y"))
#Setting margins to adjust 4 plots

x <- as.numeric(req_data$Global_active_power)
#Combining date with time
req_class <- paste(req_data$Date, req_data$Time)
#Converting to Date/Time class
req_datetime <- as.POSIXct(req_class, tz = Sys.timezone())
png(filename = "plot4.png", width = 480,height = 480, units = "px")
par(mfrow = c(2,2), mar = c(4,4,2,1))
with({
  #The first plot i.e topleft
  plot(req_datetime,x, type = "l", ylab = "Global Active Power(kilowatts)",
       xlab = "")
  #the second plot i.e topright
  plot(req_datetime,req_data$Voltage, xlab = "datetime", ylab = "Voltage",
       type = "l")
  #the third plot i.e bottom left
  plot(req_datetime, req_data$Sub_metering_1, xlab = "",
       ylab = "Energy sub metering", type = "l")
  points(req_datetime, req_data$Sub_metering_2, col = "red", type = "l")
  points(req_datetime, req_data$Sub_metering_3, col = "blue", type = "l")
  #Adding the legend on the topright corner
  legend("topright", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1,
         cex = 0.7, bty = "n")
  #the fourth plot i.e bottom right
  plot(req_datetime, req_data$Global_reactive_power, xlab = "datetime",
       ylab = "Global_reactive_power", type = "l")  
})
dev.off()

