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

if (!file.exists("household_power_consumption.txt")){
  unzip(zipFile)
}


## Read all data from file 
##############################
Alldata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")

## Filter data for 2 days with limited coulmns 
powerdata <- subset(Alldata, 
                    as.Date(Date, "%d/%m/%Y")==as.Date("01/02/2007","%d/%m/%Y") | 
                      as.Date(Date, "%d/%m/%Y")==as.Date("02/02/2007","%d/%m/%Y"),  
                    select = c("Date", "Time", "Sub_metering_1","Sub_metering_2", "Sub_metering_3")
)

rm(Alldata)

powerdata$Date <- as.Date(powerdata$Date,"%d/%m/%Y")
powerdata<-cbind(powerdata, "DateTime" = as.POSIXct(paste(powerdata$Date, powerdata$Time)))

png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(powerdata,plot(Sub_metering_1~DateTime, type="l", xlab= "", ylab="Energy Sub Metering"))
with(powerdata,lines(Sub_metering_2 ~ DateTime, col = 'Red'))
with(powerdata,lines(Sub_metering_3 ~ DateTime, col = 'Blue'))
legend("topright", lty=1, lwd =3, col=c("black","red","blue") ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()
rm(powerdata)

