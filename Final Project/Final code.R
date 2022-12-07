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

#RENAMING COLUMN NAMES TO MATCH

names(weather)[names(weather) == 'site'] <-"COUNTY"
names(weather)

#Separating dates into yr month day; renaming to match in each dataset
#Cannot figure out why COUNTY yyyy and mm show up empty?????
#Matt thank you so much if you had not helped me fix my merge data I would have had a breakdown I appreciate you :)

?strsplit

strsplit(list(curlew$`OBSERVATION DATE`), "-")

dates <- data.frame(do.call("rbind", strsplit(as.character(curlew$`OBSERVATION DATE`), "-", fixed = TRUE)))


names(dates)[names(dates) == 'X1'] <- 'yyyy' 
names(dates)[names(dates) == 'X2'] <- "mm"
names(curlew)[names(curlew) == "COUNTY"] <- "Site"

curlew.date <- cbind(curlew,dates)


curlew.weather <- merge(curlew.date, weather, by = c("Site", "yyyy","mm"))


#NOW, DATA ANALYSIS!!!


  