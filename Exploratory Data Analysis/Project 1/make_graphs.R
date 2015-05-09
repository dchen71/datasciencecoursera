make_graphs = function(){
    #Reads and filters the data to date  = 2/1/2007 and 2/2/2007
    library('sqldf')
    fileurl = "household_power_consumption.txt"
    data = read.csv.sql(fileurl, sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",sep=';',header=TRUE)
    sqldf() #think this closes the connection?
    
    #Converts date/time to R liked types
    data$DateTime = strptime(paste(data$Date,data$Time),format="%d/%m/%Y %H:%M:%S")
    
    #Plot 1, histogram of Global Active Power
    png(filename = "plot1.png", height = 480, width = 480)
    plot1 = hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", main=paste("Global Active Power"), col="red")
    dev.off()
    
    #Plot 2, plot of global active power vs dates
    png(filename = "plot2.png", height = 480, width = 480)
    plot2 = plot(x = data$DateTime, y = data$Global_active_power, type = "l", xlab="", ylab="Global Active Power(kilowatts)")
    dev.off()
    
    #Plot 3, Sub_metering 1/2/3 vs dates
    png(filename = "plot3.png", height = 480, width = 480)
    plot3 = plot(x = data$DateTime, y = data$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
    points(x=data$DateTime, y = data$Sub_metering_2, type = "l",col="red")
    points(x=data$DateTime, y = data$Sub_metering_3, type="l", col="blue")
    legend("topright",pch='-',col=c("black","red","blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    dev.off()
    
    #Plot 4, four plots in one, plot1/plot3/plot4a/plot4b
    png(filename = "plot4.png", height = 480, width = 480)    
    par(mfrow = c(2,2))
    plot2 = plot(x = data$DateTime, y = data$Global_active_power, type = "l", xlab="", ylab="Global Active Power")
    plot4a = plot(data$DateTime, data$Voltage,type = "l",xlab = "datetime",ylab="Voltage")
    plot3 = plot(x = data$DateTime, y = data$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
    points(x=data$DateTime, y = data$Sub_metering_2, type = "l",col="red")
    points(x=data$DateTime, y = data$Sub_metering_3, type="l", col="blue")
    legend("topright",pch='-',col=c("black","red","blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot4b = plot(data$DateTime, data$Global_reactive_power,type = "l",xlab = "datetime",ylab="Global_reactive_power")
    dev.off()
    
    
}