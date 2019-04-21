source("load_data.R")
library(ggplot2)
library(scales)
library(tidyr)

#check if data file exists else create data for plot creation
if(file.exists("plot_data.rds")){
     data <- readRDS("plot_data.rds")
} else {
     load_data()
     data <- readRDS("plot_data.rds")
}

#Creating subdata for legend
data_sub <- data[,c(7:10)]
data_sub$Date_Time <- as.POSIXct(data_sub$Date_Time)
data_sub1 <- data_sub %>% gather(key = "meter_name",value ="value",1:3)


#Creating Plot 3
plot3 <- ggplot(data = data_sub1)+
     geom_line(aes(x= Date_Time, y= value ,colour = meter_name))+
     labs(y = "Energy Sub Metering", x = "") +
     scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a"))+
     theme(legend.justification = c(1, 1), legend.position = c(1, 1), legend.title = element_blank())

plot3

ggsave("plot3.png", plot = plot3)
dev.off()
