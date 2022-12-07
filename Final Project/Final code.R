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

'COUNTY' <- names(weather)[names(weather) == 'site'] 
names(weather)

#Separating dates into yr month day; renaming to match in each dataset
#Cannot figure out why COUNTY yyyy and mm show up empty?????
?strsplit

strsplit(list(curlew$`OBSERVATION DATE`), "-")

dates <- data.frame(do.call("rbind", strsplit(as.character(curlew$`OBSERVATION DATE`), "-", fixed = TRUE)))
"yyyy" <- names(curlew)[names(curlew) == 'X1'] 
"mm" <- names(curlew)[names(curlew) == 'X2']

Location.date <- cbind


curlew.weather <- merge(curlew.data, weather.data, by cbind(COUNTY, yyyy, mm))


  