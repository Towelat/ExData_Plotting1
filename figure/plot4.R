##reading in data
temporary<- tempfile()
file<-download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temporary)
data <- read.table(unzip(temporary), header = TRUE, sep = ";")
head(data)
library(dplyr)
library(ggplot2)

#filter for desired rows
data$Date<- as.Date.factor(data$Date, format="%d/%m/%Y")
head(data)
data1<- filter(data, Date== "2007-2-1")
data2<- filter(data, Date=="2007-2-2")
data_final<- rbind(data1,data2)

#filter for complete data only
data_final <- data_final[complete.cases(data_final),]

#making Global_active_power a numeric class
data_final$Global_active_power<- as.numeric(data_final$Global_active_power)

# changing class of Date and Time columns
data_final$Date <- as.Date(data_final$Date, format="%Y/%m/%d")  

data_final$Time<- as.character(data_final$Time)

data_final$combine <- paste(data_final$Date,data_final$Time)
data_final$combine <- as.POSIXct(data_final$combine)
head(data_final)

# making columns of class numeric
data_final$Sub_metering_1<- as.numeric(data_final$Sub_metering_1)
data_final$Sub_metering_2<- as.numeric(data_final$Sub_metering_2)
data_final$Sub_metering_3<- as.numeric(data_final$Sub_metering_3)
data_final$Global_reactive_power<- as.numeric(data_final$Global_reactive_power)
data_final$Voltage<- as.numeric(data_final$Voltage)
#making the plot

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,1,0))
with(data_final, {
    plot(data_final$combine, data_final$Global_active_power/500, type= "l", ylab = "Global Active Power", xlab = "")
    plot(data_final$Voltage~ data_final$combine, type = "l", ylab = "Voltage", xlab="datetime")
    plot(data_final$Sub_metering_1~ data_final$combine, type="l",
         ylab="Energy sub metering", xlab="", ylim=c(0,35))
    lines(data_final$Sub_metering_2/5 ~ data_final$combine,col='Red')
    lines(data_final$Sub_metering_3~ data_final$combine,col='Blue')
    legend("topright",col=c("black", "red", "blue"), lwd=c(1,1,1), bty = "n", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
    plot(data_final$combine,data_final$Global_reactive_power/500, type = "l", ylab= "Global_reactive_power", xlab = "datetime", ylim=c(0.0,0.5))
})

#Saving Plot
windows()
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,1,0))
with(data_final, {
    plot(data_final$combine, data_final$Global_active_power/500, type= "l", ylab = "Global Active Power", xlab = "")
    plot(data_final$Voltage~ data_final$combine, type = "l", ylab = "Voltage", xlab="datetime")
    plot(data_final$Sub_metering_1~ data_final$combine, type="l",
         ylab="Energy sub metering", xlab="", ylim=c(0,35))
    lines(data_final$Sub_metering_2/5 ~ data_final$combine,col='Red')
    lines(data_final$Sub_metering_3~ data_final$combine,col='Blue')
    legend("topright",col=c("black", "red", "blue"), lwd=c(1,1,1), bty = "n", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
    plot(data_final$combine,data_final$Global_reactive_power/500, type = "l", ylab= "Global_reactive_power", xlab = "datetime", ylim=c(0.0,0.5))
})

dev.off()
