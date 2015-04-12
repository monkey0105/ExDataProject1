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
# plot2
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(data[[1]], data[[2]], type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = NA)
dev.off()
