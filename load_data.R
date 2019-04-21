library(dplyr)

load_data <- function(){
     if (file.exists("exdata-data-household_power_consumption.zip")){
          df <- read.table(unzip("exdata-data-household_power_consumption.zip","household_power_consumption.txt"),sep =";", header= TRUE)
     } else if (file.exists("household_power_consumption.txt")){
          df <- read.table("household_power_consumption.txt",sep = ";", header = TRUE)
     } else {
          temp <- tempfile()
          download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
          df <- read.table(unzip(temp,"household_power_consumption.txt"),sep =";", header= TRUE)
     }
     
     
     # Reading the txt file and creating tidy data set for plotting
     df <- tbl_df(df)
     df <- filter(df, Date == "2/2/2007" | Date == "1/2/2007")
     df <- mutate(df, Date_Time = paste(Date, Time, sep = " "))
     df$Date_Time <- strptime(df$Date_Time, "%d/%m/%Y %H:%M:%S")
     df[,3:9] <- lapply(df[,3:9], as.character)
     df[,3:9] <- lapply(df[,3:9], as.numeric)
     
     saveRDS(df, file ="plot_data.rds")
#     return(df)
}
