d1<-mutate(d1, Date=paste(Date, " ", Time))
library(dplyr)
library(lubridate)

#read data
d<-read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors = F)

# replace ? with NA
d[d=="//?"]<-NA 

# Merge date and Time fields
d<-mutate(d, Date=paste(Date, " ", Time))

# and parse them
d<-mutate(d, Date=parse_date_time(Date, "%d/%m/%Y %H:%M:%S"))

# Select the date range we are looking at
d<-filter(d, Date>="2007-02-01"&Date<"2007-02-03")

# Change the class of the other columns to numeric
d[3:9] <- d[3:9] %>% mutate_each(funs(as.numeric))

# change the class of time (from chracter to time)
#d$Time<-strptime(d$Time, format="%H:%M:%S")

#as.POSIXct(paste(date, time), format="%d/%m/%Y %H:%M:%S")

#plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(d$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="Red")
dev.off() ## Close device

#plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(d$Global_active_power~d$Date, type="l", xaxt="n", ylab = "Global Active Power (kilowatts)", xlab="")
ticks_at<-c(min(d$Date),median(d$Date),max(d$Date))
axis(side=1, at=ticks_at, labels=c("Thu","Fri","Sat"))
dev.off() 

# Plot 3
png(filename = "plot3.png", width = 480, height = 480)
plot(d$Sub_metering_1~d$Date, type="l", xaxt="n", ylab="Energy sub metering", xlab="")
lines(d$Sub_metering_2~d$Date, col="red")
lines(d$Sub_metering_3~d$Date, col="blue")
axis(side=1, at=ticks_at, labels=c("Thu","Fri","Sat"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red", "blue"), lty=1)
dev.off() 

# Plot 4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))

plot(d$Global_active_power~d$Date, type="l", xaxt="n", ylab = "Global Active Power", xlab="")
axis(side=1, at=ticks_at, labels=c("Thu","Fri","Sat"))

plot(d$Voltage~d$Date, type="l", xaxt="n", ylab = "Voltage", xlab="datetime")
axis(side=1, at=ticks_at, labels=c("Thu","Fri","Sat"))

plot(d$Sub_metering_1~d$Date, type="l", xaxt="n", ylab="Energy sub metering", xlab="")
lines(d$Sub_metering_2~d$Date, col="red")
lines(d$Sub_metering_3~d$Date, col="blue")
axis(side=1, at=ticks_at, labels=c("Thu","Fri","Sat"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red", "blue"), lty=1)

plot(d$Global_reactive_power~d$Date, type="l", xaxt="n", ylab = "Global_reactive_power", xlab="datetime")
axis(side=1, at=ticks_at, labels=c("Thu","Fri","Sat"))

dev.off()
