#Final project code!
#I have concerted all of my data into excel form
#Next I must read it in (done!), merge the data, and figure out how to get locations to match up between the weather and bird data

library(readxl)
setwd("C:/GitHub/Rolecki-R4Ecol/Final Project")

curlew.data <- read_excel("Curlew data.xlsx", sheet = "Edited Curlew")
weather.data <- read_excel("Curlew data.xlsx", sheet = "Weather")

#weather data and curlew data matched up in four locations 

curlew <- as.data.frame(curlew.data)
weather <- as.data.frame(weather.data)


