setwd("C:/Users/Behnam/Documents/Ben/Analytics Training/Data-Science-Coursera/Exploratory-Data-Analysis/Week-1/")

df <- read.table(file = "./household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, nrows = 10)
colclass <- sapply(df,class)

df <- read.table(file = "./household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
for (i in 1:ncol(df)) {
  class(df[[i]]) <- colclass[i]
}

if (!require("lubridate")) {
  install.packages("lubridate")
  library(lubridate)
}

df$Date_Time <- dmy_hms(paste(df$Date,df$Time,"-"))
df$Date <- NULL
df$Time <- NULL

if (!require("dplyr")) {
  install.packages("dplyr")
  library(dplyr)
}

d <- df %>% filter(Date_Time >= ymd_hms("2007-02-01 00:00:00") & Date_Time <= ymd_hms("2007-02-02 23:59:00"))

png('plot3.png',height = 480, width = 480)

plot(d$Date_Time, d$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(d$Date_Time, d$Sub_metering_2, type = "l", col = 2)
lines(d$Date_Time, d$Sub_metering_3, type = "l", col = 4)
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c(1,2,4), lty = c(1,1,1))

dev.off()
