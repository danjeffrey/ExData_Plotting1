# plot2.R generates a line chart of the global active power value by day of week

library(plyr)

# read the raw data:
alldata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# create a date/time field from the first two columns. 
# I can safely ignore time zone because everything will be 
# converted to the same time zone
allDataDateTime <- mutate(alldata, dttm = strptime(paste(as.character(Date), " ", as.character(Time)), format = "%d/%m/%Y %H:%M:%S"), Date = as.Date(Date))

# might as well free up some memory:
remove(alldata)

# Get a subset of the data for the desired dates:
# start time is 0:0:0 or midnight the morning of 2/1:
start <- strptime("2007-02-01", format = "%Y-%m-%d")
# add one day to set the end -- so we include all of 2/2/2007:
end <- strptime("2007-02-03", format = "%Y-%m-%d")
twoDaysData <- subset(allDataDateTime, dttm > start & dttm < end)

# might as well free up some memory:
remove(allDataDateTime)

# Now that we have reduced the data set, do the other column maintenance chores:

# convert the value columns into numeric values as needed:
twoDaysData <- mutate(twoDaysData, Global_active_power = as.numeric(as.character(Global_active_power)))
#twoDaysData <- mutate(twoDaysData, Global_reactive_power = as.numeric(as.character(Global_reactive_power)))
#twoDaysData <- mutate(twoDaysData, Voltage = as.numeric(as.character(Voltage)))
#twoDaysData <- mutate(twoDaysData, Global_intensity = as.numeric(as.character(Global_intensity)))
#twoDaysData <- mutate(twoDaysData, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
#twoDaysData <- mutate(twoDaysData, Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))
#twoDaysData <- mutate(twoDaysData, Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))

# create the graphics device:
png(file = "plot2.png", width = 480, height = 480)

# Create the plot
with(twoDaysData, plot(dttm, Global_active_power, type="l",xlab = "", ylab = "Global Active Power (kilowatts)"))

# free the device:
dev.off()


