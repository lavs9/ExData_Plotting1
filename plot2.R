source("load_data.R")
library(ggplot2)
library(scales)

#check if data file exists else create data for plot creation
if(file.exists("plot_data.rds")){
     data <- readRDS("plot_data.rds")
} else {
     load_data()
     data <- readRDS("plot_data.rds")
}


#Creating Plot 2
plot2 <- ggplot(data = data, aes(x= as.POSIXct(Date_Time,tz = "UTC"), y= Global_active_power))+
     geom_line()+
     labs(y = "Global Active Power (kilowatts)", x = "")+
     scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a"))
plot2
ggsave("plot2.png", plot = plot2)
dev.off()
