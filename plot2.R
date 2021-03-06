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


#plot 2
png(filename = "plot2.png", width = 480, height = 480)
plot(d$Global_active_power~d$Date, type="l", xaxt="n", ylab = "Global Active Power (kilowatts)", xlab="")
ticks_at<-c(min(d$Date),median(d$Date),max(d$Date))
axis(side=1, at=ticks_at, labels=c("Thu","Fri","Sat"))
dev.off() 
