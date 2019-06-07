##reading in the data
temporary<- tempfile()
file<-download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temporary)
data <- read.table(unzip(temporary), header = TRUE, sep = ";")
head(data)
library(dplyr)

#filter for desired rows
data$Date<- as.Date.factor(data$Date, format="%d/%m/%Y")
head(data)
data1<- filter(data, Date== "2007-2-1")
data2<- filter(data, Date=="2007-2-2")
data_final<- rbind(data1,data2)

#make Global_active_power of class = numeric
data_final$Global_active_power<- as.numeric(data_final$Global_active_power)

#making histogram
hist(data_final$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kiloWatts)" )

#Saving Plot
windows()
png("plot1.png", width = 480, height = 480)
hist(data_final$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kiloWatts)")
dev.off()
