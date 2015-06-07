# Code for plot3
#
# please set working directory to the directory where 
# household_power_consumption.txt is located
#
# using grep we locate the data we need to read
begindate <- grep("1/2/2007", readLines("./household_power_consumption.txt"))[1]
enddate <- grep("3/2/2007", readLines("./household_power_consumption.txt"))[1]
#
ds <- read.table(file="./household_power_consumption.txt", sep=";", na.strings="?", skip=begindate-1, nrows=enddate-begindate)
# using paste and strptime we convert time columns
ds$V10 <- strptime(paste(ds$V1,ds$V2),"%d/%m/%Y %H:%M:%S")
#
# save to png
Sys.setlocale("LC_TIME", "English")
png("./plot3.png", width=480, height=480)
with(ds, plot(ds$V10, ds$V7, type = "n", xlab="", ylab="Energy sub metering", main=""))
with(ds, lines(ds$V10, ds$V7, col = "black"))
with(ds, lines(ds$V10, ds$V8, col = "red"))
with(ds, lines(ds$V10, ds$V9, col = "blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()