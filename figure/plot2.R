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

#making the plot
#to get correct scale on y-axis
data_final$Global_active_power<- data_final$Global_active_power/500

par(mar= c(2,4,0,1))
par(oma= c(3,0,2,0))
plot(data_final$Global_active_power~ data_final$combine, type = "l", ylab = "Global Active Power (kiloWatts)")


#Saving Plot
windows()
png("plot2.png", width = 480, height = 480)
plot(data_final$Global_active_power~ data_final$combine, type = "l", ylab = "Global Active Power (kiloWatts)", xlab="")
dev.off()
