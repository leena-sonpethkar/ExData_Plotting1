library(dplyr)


## Get the data/zip file from url given
#########################################

# download zip file
zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata_data_household_power_consumption.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file 
#dataPath <- "D:/R Program/Exploratory_Data/ExData_Plotting1/exdata_data_household_power_consumption"
dataPath <- "exdata_data_household_power_consumption"
#if (!file.exists(dataPath)) {

if (!file.exists("household_power_consumption.txt")){
  unzip(zipFile)
}


## Read data 
##############################
Alldata <- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";")
  nm <- names(Alldata)
#powerdata <- subset(Alldata, as.Date(Date, "%d/%m/%y" )==("01/02/2007"), select(Date, Time, Global_active_power, Voltage))
  ax <- dim(Alldata)
  
powerdata <- subset(Alldata, 
                    as.Date(Date, "%d/%m/%y")==as.Date("01/02/2007","%d/%m/%y") | 
                    as.Date(Date, "%d/%m/%y")==as.Date("02/02/2007","%d/%m/%y"),  
                    select = c("Date", "Time", "Global_active_power", "Voltage")
                    )
#, select(Date, Time, Global_active_power, Voltage))

rm(Alldata)

xx <- dim(powerdata)

