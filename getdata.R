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


