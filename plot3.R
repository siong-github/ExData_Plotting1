library(data.table)
#One observation per minute, therefore from 01/02/2007 to 02/02/2007 total number of observations is 2days*24hours*60mins = 2880 observations
time_interval <- difftime(as.POSIXct("2007/02/03"),as.POSIXct("2007/02/01"),units="mins")
rows_to_read <- as.numeric(time_interval)
DT <-  fread("household_power_consumption.txt",skip="1/2/2007",nrows=rows_to_read,na.strings =c("?",""))
setnames(DT, colnames(fread("household_power_consumption.txt",nrows=0)))

#Check out subset (how many rows and dates we have)
#table(DT$Date)

#Change date to posix format
Datederiv <- as.Date(DT$Date,format="%d/%m/%Y")
Timederiv <- DT$Time
DateTime <- as.POSIXct(paste(as.character(Datederiv),as.character(Timederiv)))
DTderiv <- DT
DTderiv$DateTime <- DateTime

#Plot and save to plot3.png
png(filename="plot3.png", width=480, height=480,units="px")
with(DTderiv,plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(DTderiv,lines(DateTime,Sub_metering_2,type="l",col="red"))
with(DTderiv,lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),pch =c("-","-","-"),col=c("black","red","blue"))
dev.off()
