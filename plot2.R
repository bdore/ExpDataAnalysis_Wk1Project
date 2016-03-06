##loads necessary library
library(data.table)

##Switches to english weekdays
Sys.setlocale("LC_ALL","English")

##reads in the data, remove NA's
x <- fread("household_power_consumption.txt", na.strings = "?")

##subsets only the necessary days
y <- x[x$Date == "1/2/2007" | x$Date == "2/2/2007"]

##converts 'Date' and 'Time' character variables to appropriate date classes
y$Date <- as.Date(y$Date, "%d/%m/%Y")
y$Time <- paste(y$Date, y$Time, sep = " ")
y$Time <- as.POSIXct(y$Time, format="%Y-%m-%d %H:%M:%S")

##plot1
plot(y$Time, y$Global_active_power,
     type = "l",
     xlab="",
     ylab = "Global Active Power (killowatts)")

##copy plot to png device and save to disk
dev.copy(png, file = "plot2.png", width = 480, height = 480)

##close graphic device
dev.off()