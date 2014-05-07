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

### plot 2
png("./plot2.png", width=480, height=480)
with(df, {
	plot(datetime, Global_active_power, 
		ylab="Global Active Power (kilowatts)", xlab="", type="l")
})
dev.off()

q(save="n")
