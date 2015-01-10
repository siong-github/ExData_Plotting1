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

#Plot and save to plot2.png
png(filename="plot2.png", width=480, height=480,units="px")
plot(DTderiv$DateTime,DTderiv$Global_active_power, type="l",xlab="",ylab="Global Active Power(kilowatts)")
dev.off()

