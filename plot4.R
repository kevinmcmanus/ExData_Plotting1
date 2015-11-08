library(sqldf)

f=file("household_power_consumption.txt")
attr(f,"file.format")<-list(sep=";",header=T)


#read whole table and deal with NA values
#dfall=read.table("household_power_consumption.txt",stringsAsFactors = F, na.strings = "?",header = T, sep=";")


#assuming the dates are in m/d/yyyy format
#and all we want is 2007-02-01 through 2007-02-02:
df=sqldf("select * from f where Date='1/2/2007' or Date='2/2/2007'",stringsAsFactors=F)


dft <- data.frame(
        datetime=strptime(paste(df$Date,df$Time),format="%d/%m/%Y %T"),
        df[,3:9]
)

png(file="plot4.png")
par(mfrow=c(2,2))
plot(dft$datetime,dft$Global_active_power,ylab="Global Active Power", type="l",xlab="")
plot(dft$datetime,dft$Voltage, ylab="Voltage",xlab="datetime",type = "l")
plot(  ylab="Energy sub metering",xlab="",
       dft$datetime, dft$Sub_metering_1, type="l",col="black")
lines(dft$datetime, dft$Sub_metering_2, type="l",col="red")
lines(dft$datetime, dft$Sub_metering_3, type="l",col="blue")
legend("topright",
       lty=rep(1,3),
       pch=NULL,
       col=c("black","red","blue"), 
       legend=c("Sub Metering 1","Sub Metering 2","Sub Metering 3")
)
plot(dft$datetime,dft$Global_reactive_power, ylab="Global Reactive Power",xlab="datetime",type = "l")
dev.off()