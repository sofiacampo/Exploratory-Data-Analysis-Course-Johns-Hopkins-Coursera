#1.Identification
#File Name: SofiaCampo_Exploratory_Data_Analysis_Week1.R
#Creator: Sofia Campo
#Course: Exploratory Data Analysis Project Week1, Johns Hopkins Data Science Specialization
#Date: May 2019

#------------------------------------------------------------------------------------
#2.plot1
#------------------------------------------------------------------------------------
#load libraries
library("data.table")

#set working directory
setwd("C:/Users/sofiacampo/OneDrive/DOCUMENTS/EDUCACAO/2018_JOHNS_HOPKINS/4_EXPLORATORY_DATA_ANALYSIS/WEEK1/PROJECT1/exdata_data_household_power_consumption/")

#read & check data file household_power_consumption.txt
consumption <-read.table(file = "household_power_consumption.txt", stringsAsFactors = FALSE,na.strings="?", header = TRUE, sep =";")
head(consumption)
summary(consumption)
sapply(consumption, typeof)

#convert data type from character to numeric
consumption$Time <- format(consumption$Time, format="%H:%M:%S")
cols_to_change = c(3:9)
consumption[ , cols_to_change] <- apply(consumption[ , cols_to_change], 2, 
                                        function(x) as.numeric(as.character(x)))

#subset data to 2007-02-01 and 2007-02-02
subsetconsumption <- subset(consumption, Date %in% c("1/2/2007","2/2/2007"))
subsetconsumption$Date <- as.Date(subsetconsumption$Date, format="%d/%m/%Y")

#plot histogram
png("plot1.png", width=480, height=480)
hist(subsetconsumption$Global_active_power, col="Red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()
