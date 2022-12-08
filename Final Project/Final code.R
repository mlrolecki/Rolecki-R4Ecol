#Final project code!
#I have concerted all of my data into excel form
#Next I must read it in, merge the data, and figure out how to get locations to match up between the weather and bird data

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
#Cannot figure out why COUNTY yyyy and mm show up empty????? <- code error!
#Matt thank you so much if you had not helped me fix my merge data I would have failed :)

?strsplit
#This will be used to split date into separate year/month/day columns

strsplit(list(curlew$`OBSERVATION DATE`), "-")

dates <- data.frame(do.call("rbind", strsplit(as.character(curlew$`OBSERVATION DATE`), "-", fixed = TRUE)))

#Renaming split columns
names(dates)[names(dates) == 'X1'] <- 'yyyy' 
names(dates)[names(dates) == 'X2'] <- "mm"
names(curlew)[names(curlew) == "COUNTY"] <- "Site"

#Merging dates
curlew.date <- cbind(curlew,dates)

#Merging dates and locations
curlew.weather <- merge(curlew.date, weather, by = c("Site", "yyyy","mm"))


#NOW, DATA ANALYSIS!!!
#Getting rid of non-numeric in curlew count data:
curlew.data$`OBSERVATION COUNT` <- gsub("X", "NA", curlew.data$`OBSERVATION COUNT`)
curlew.data.obscount1 <- subset(curlew.data, curlew.data$`OBSERVATION COUNT` !="NA")
as.data.frame(curlew.data.obscount1)
num.curlew.data <-as.numeric(as.character(curlew.data.obscount1$`OBSERVATION COUNT`))


#Histogram- shows the frequency of occurrance in terms of how many individuals occur together
#Shows that the birds are often found in low numbers (individual, pair, small group) but that there are likely breeding events that take place infrequently with hundreds of individuals. 
hist(num.curlew.data, xlab = "Curlew Count", ylab= "Frequency", col = 'skyblue3', breaks= 50, main= "Curlew Count Frequency")
?hist

  
