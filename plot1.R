source("load_data.R")
library(ggplot2)

#check if data file exists else create data for plot creation
if(file.exists("plot_data.rds")){
     data <- readRDS("plot_data.rds")
} else {
     load_data()
     data <- readRDS("plot_data.rds")
}

#Creating Plot 1
plot1 <- ggplot(data = data, aes(x = Global_active_power))+
     geom_histogram(fill = "pink")+
     labs( x= "Global Active Power (kilowatts)", y = "Frequency", title = "Global Active Power")
plot1
ggsave("plot1.png", plot = plot1)
dev.off()
