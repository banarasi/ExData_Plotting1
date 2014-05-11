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

##Plot2
# Open the file device
png(filename = "plot2.png", width = 480, height = 480)

plot(epcData$DateTime,epcData$Global_active_power,type="l",xlab="",ylab="Global Active Power (killowatts)")

# Close the file device
dev.off()
