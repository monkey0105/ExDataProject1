download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "prj1.zip")
unzip("prj1.zip")
unlink("prj1.zip")
raw <- read.table("household_power_consumption.txt", 
                  header = TRUE, sep = ";", dec = ".", stringsAsFactors = F)
data <- raw[which(raw[[1]] == "1/2/2007" | raw[[1]] == "2/2/2007"), ]
data[[1]] <- paste(data[[1]], data[[2]])
data <- data[,-2]
for(i in 1:7){
  if(i == 1) {
    data[[i]] <- strptime(data[[i]], format = "%d/%m/%Y %H:%M:%OS")
  } else{
    data[[i]] <- as.numeric(data[[i]])
  } 
}
# plot4
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2), pty = "s")
# 1
plot(data[[1]], data[[2]], type = "l", 
     ylab = "Global Active Power", xlab = NA)
# 2
plot(data[[1]], data[[4]], type = "l", 
     ylab = "Voltage", xlab = "datetime")
# 3
with(data, plot(Date, Sub_metering_1, type = "l", col = "black",
                ylab = "Energy sub metering", xlab = NA)) 
with(data, lines(Date, Sub_metering_2, type = "l", col = "red"))
with(data, lines(Date, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = names(data)[6:8], lty = 1, bty = "n", 
       col = c("black", "red", "blue"), cex = 0.6)
# 4
plot(data[[1]], data[[3]], type = "l", 
     ylab = "Global_reactive_power", xlab = "datetime")
dev.off()
