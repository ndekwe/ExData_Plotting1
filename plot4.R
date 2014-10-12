print("TO BE DONE MANUALLY")
print("Before running the scripts make sure you have <<sqldf>> package installed ")
print( "This package will be used while loading the dataset subset <<read.csv.sql>>")

#install.packages("sqldf")
# Loading the data
data <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * from file WHERE Date in ('1/2/2007', '2/2/2007')",sep = ";", header = TRUE)

#closing "sql" connection
#close()

library(plyr)

Date_and_Time <- paste(data$Date, data$Time)
Date_and_Time <-as.Date(Date_and_Time)


data$Date_and_Time <- Date_and_Time
# The following column is the one to be used by all expected graphs
data$DateTime <- strptime(paste(data$Date, data$Time, sep=","), format="%d/%m/%Y,%H:%M:%S")
joursDeSemaines <- weekdays(data$DateTime)

############ GRAPHS CONSTRUCTION###############
## Plot 4
par(mfrow = c(2,2))
# Plotting Global Active Power
plot(data$DateTime,data$Global_active_power,type = "l",ylab = "Global Active Power",xlab = "")

# Plotting Voltage
plot(data$DateTime,data$Voltage,type = "l",ylab = "Voltage",xlab = "datetime")

# Plotting Energy sub metering
plot(data$DateTime, data$Sub_metering_1, type = "l",ylab = "Energy sub metering", xlab = "")
lines(data$DateTime, data$Sub_metering_2, type = "l",col = "Red")
lines(data$DateTime, data$Sub_metering_3, type = "l",col = "Blue")

#Plotting Global reactive power
plot(data$DateTime,data$Global_reactive_power,type = "l",ylab = "Global_reactive_power",xlab = "datetime")

# Saving in ".png" format
dev.copy(png,file = "plot4.png")
# Device disconnection
dev.off()
print("Please get plot4.png under your working directory")
par(mfrow = c(1,1))



