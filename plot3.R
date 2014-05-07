library(data.table)
library(plyr)

### read the massive file using fread of data.table
### convert the date component so that we can filter the 
### data for the given 2 days of Feb 2007 and then convert
### Date & Time into timestamp for further exploration

df0 = fread("household_power_consumption.txt", na.strings="?")
df0$dt = as.Date(df0$Date, "%d/%m/%Y")

df = as.data.frame(subset(df0, dt >= as.Date("2007-02-01", "%Y-%m-%d") & 
									dt <= as.Date("2007-02-02", "%Y-%m-%d")))
df$datetime = strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

### convert all the character columns, we use sapply and column numbers
df[, 3:9]=sapply(df[, 3:9], as.numeric)

### df is a data frame with the necessary raw data for the exploration

### plot 3
png("./plot3.png", width=480, height=480)
with(df, {
	plot(datetime, Sub_metering_1, 
		ylab="Energy sub metering", xlab="", type="l")
	lines(datetime, Sub_metering_2, col="red")
	lines(datetime, Sub_metering_3, col="blue")
	legend("topright", lty=1, col=c("black", "red", "blue"),
				legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
dev.off()

q(save="n")
