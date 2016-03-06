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

##creates plot with first meter
plot(y$Time,
     y$Sub_metering_1,
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")

##add lines to display second meter data
lines(y$Time,
      y$Sub_metering_2,
      type = "l",
      col = "red")

##add lines to display third meter data
lines(y$Time,
      y$Sub_metering_3,
      type = "l",
      col = "blue")

##add legend
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex = 0.8,
       inset = c(0.15, 0.0),
       y.intersp = 1.5,
       bty = "n",
       lwd = 1,
       col = c("black", "red", "blue"))

##copy plot to png device and save to disk
dev.copy(png, file = "plot3.png", width = 480, height = 480)

##close graphic device
dev.off()