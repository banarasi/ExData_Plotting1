##install.packages("sqldf")
library(sqldf)
## Set current directory
# setwd("/rprog/exData/)
#This script assumes household_power_consumption.txt file available in the current 
# folder


#Function to read the data
readData<-function(fileName){
  #Read data from the dates 2007-02-01 and 2007-02-02
  sql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  cols=c("character","character","numeric","numeric","numeric","numeric",
         "numeric","numeric","numeric")
  
  epcData <- read.csv2.sql(fileName,sql,sep=";",stringsAsFactors=FALSE,colClasses=cols,blank.lines.skip=TRUE,na.strings="?")
  str(epcData)
  #Add new column DataTime in POSIXlt
  epcData$DateTime<-strptime(paste(epcData$Date,epcData$Time),"%d/%m/%Y %H:%M:%S")
  return (epcData)
}

# Read Data
epcData <- readData("household_power_consumption.txt")

##Plot4
# Open the file device
png(filename = "plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

plot(epcData$DateTime,epcData$Global_active_power,type="l",xlab="",ylab="Global Active Power")

plot(epcData$DateTime,epcData$Voltage,type="l",ylab="voltage",xlab="datetime")


plot(epcData$DateTime,epcData$Sub_metering_1,type="l",xlab="",ylab="Energy sub merging")
lines(epcData$DateTime,epcData$Sub_metering_2,col="red")
lines(epcData$DateTime,epcData$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty="n")

plot(epcData$DateTime,epcData$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

# Close the file device
dev.off()
