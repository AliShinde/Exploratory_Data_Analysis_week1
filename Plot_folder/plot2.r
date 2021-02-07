#Reading the dataset 
datafile <- read.table("D:/EDA/EDA_spe/household_power_consumption.txt",
                       header = TRUE, sep = ";",comment.char = "")
#Converting the date column to the class "DATE" from "CHARACTER"
datafile$Date <- as.Date(datafile$Date, format = "%d/%m/%Y")

#Subsetting the data for the required dates i.e 1st and 2nd Feb 2007
req_data <- subset(datafile, Date == as.Date("01/02/2007",format = "%d/%m/%Y")
                   | Date == as.Date("02/02/2007", format = "%d/%m/%Y"))
#Plotting the histogram and saving as a png file
x <- as.numeric(req_data$Global_active_power)
#Combining date with time
req_class <- paste(req_data$Date, req_data$Time)

#Converting to Date/Time class
req_datetime <- as.POSIXct(req_class, tz = Sys.timezone())
png(filename = "plot2.png", width = 480,height = 480, units = "px")
plot(req_datetime,x, type = "l", ylab = "Global Active Power(kilowatts)",
     xlab = "")
dev.off()