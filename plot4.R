source("load_data.R")
library(ggplot2)
library(scales)
library(gridExtra)

#check if data file exists else create data for plot creation
if(file.exists("plot_data.rds")){
     data <- readRDS("plot_data.rds")
} else {
     load_data()
     data <- readRDS("plot_data.rds")
}

data$Date_Time <- as.POSIXct(data$Date_Time,tz ="UTC")

#Creating Plot 1
p1 <- ggplot(data = data, aes(x= Date_Time, y= Global_active_power))+
     geom_line()+
     labs(y = "Global Active Power", x = "")+
     scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a"))
#p1

#Creating Plot 2
p2 <- ggplot(data = data, aes(x=Date_Time, y= Voltage))+
     geom_line(color = "green")+
     labs(x="datetime",y="Voltage")+
     scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a"))
#p2

#Creeating Plot 3
#Creating long subdata for legend for Plot3
data_sub <- data[,c(7:10)]
data_sub1 <- data_sub %>% gather(key = "meter_name",value ="value",1:3)
p3 <- ggplot(data = data_sub1)+
     geom_line(aes(x= Date_Time, y= value ,colour = meter_name))+
     labs(y = "Energy Sub Metering", x = "") +
     scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a"))+
     theme(legend.justification = c(1, 1), legend.position = c(1, 1), legend.title = element_blank())
#p3

#Creating Plot 4
p4 <- ggplot(data = data, aes(x=Date_Time, y=Global_reactive_power))+
     geom_line(color= "light blue")+
     labs(x = "datetime", y= "Global_reactive_power")+
     scale_x_datetime(breaks = date_breaks("1 day"), labels = date_format("%a"))
#p4     

#Creating Final Plot
plot4 <- grid.arrange(p1,p2,p3,p4,ncol=2,nrow=2)     
ggsave("plot4.png", plot = plot4)
dev.off()
