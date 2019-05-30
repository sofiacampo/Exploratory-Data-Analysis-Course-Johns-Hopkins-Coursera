#1.Identification
#File Name: SofiaCampo_Exploratory_Data_Analysis_Week1.R
#Creator: Sofia Campo
#Course: Exploratory Data Analysis Project Week1, Johns Hopkins Data Science Specialization
#Date: May 2019

#------------------------------------------------------------------------------------
#2.plot4
#------------------------------------------------------------------------------------
#load libraries
library("data.table")

#set working directory
setwd("C:/Users/sofiacampo/OneDrive/DOCUMENTS/EDUCACAO/2018_JOHNS_HOPKINS/4_EXPLORATORY_DATA_ANALYSIS/WEEK1/PROJECT1/exdata_data_household_power_consumption/")

#read data file household_power_consumption.txt
consumption <-read.table(file = "household_power_consumption.txt", stringsAsFactors = FALSE,na.strings="?", header = TRUE, sep =";")

#convert data type from character to numeric
consumption$Time <- format(consumption$Time, format="%H:%M:%S")
cols_to_change = c(3:9)
consumption[ , cols_to_change] <- apply(consumption[ , cols_to_change], 2, 
                                        function(x) as.numeric(as.character(x)))

#subset data to 2007-02-01 and 2007-02-02
subsetconsumption <- subset(consumption, Date %in% c("1/2/2007","2/2/2007"))
subsetconsumption$Date <- as.Date(subsetconsumption$Date, format="%d/%m/%Y")
datetime <-paste(as.Date(subsetconsumption$Date), subsetconsumption$Time)
subsetconsumption$Datetime <-as.POSIXct(datetime)

#plot histogram
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subsetconsumption, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.off()