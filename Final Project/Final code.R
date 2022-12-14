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
#This is a mess
summary.stats <- sapply(curlew.data$`OBSERVATION COUNT`, mean, simplify = TRUE, USE.NAMES= TRUE)
?sapply


#RDA
library(vegan)
library(spdep)
library(adespatial)
colnames(curlew.weather)
count.mat <- as.matrix(num.curlew.data)
num.weather.data <-as.numeric(as.character(weather.data))
weather.mat <- as.matrix(num.weather.data)
countbyweather.rda <- rda(count.mat, weather.mat)
#This is the part I cannot get... specifically the aem, where did this dataframe come from in practice/HW and how do I recreate
#If this would work, this would be lovely
Countweather.rda <- rda(count.mat, as.data.frame(curlew.weather), weather.mat)
Countweather.rda 
anova(Countweather.rda, perm.max = 10000)
RsquareAdj(Countweather.rda)

?rda
#JK, I guess an RDA isn't going to work. Very sad, crying a little :( 
#I don't have the heart to delete so I'm leaving it



#GLMM (sad)
library(MASS)
library(MuMIn)
library(mgcv)
?glmmPQL
colnames(curlew.weather)
#converting to df and killing N/As
curlew.weather.df <- as.data.frame(curlew.weather)
curlew.weather.df <- na.omit(curlew.weather.df)
#removing specific columns for analysis
obs.count <- curlew.weather.df$`OBSERVATION COUNT`
weather.rain <- curlew.weather.df$rain
obs.count < as.numeric(obs.count)
locations <- curlew.weather$Site
temp<- curlew.weather$tmax
temp <- as.numeric(temp)
#i think this is messing up my variable length, so omitted
#obs.count <- na.omit(obs.count)
#weather.rain <- na.omit(weather.rain)
#locations <- na.omit(locations)

#variable lengths don't match up, error? 
#Otherwise, data would show count in respect to the locations and their subsequent rainfall or count in respect to location and max monthly temp
glm.count.location.rain <- glm(obs.count~ locations + weather.rain, family = Gamma, random = list(ID=~ 1))
glm.count.location.temp <- glm(obs.count~ locations + temp, family = Gamma, random = list(ID=~ 1))



#Nope... maybe a linear model?? (send help)
count.by.weather<-lm(obs.count ~ temp + weather.rain, data = curlew.weather)
#This should theoretically give summary stats for the lm and above should provide a figure... 
summary(count.by.weather)

#What this model should look like (I didn't rename variables, just wanted to make it work so you could see what/how I did it.)
curl.fnl <- as.data.frame(cbind(curlew.weather$`OBSERVATION COUNT`, curlew.weather$tmax, curlew.weather$rain))
curl.fnl <- curl.fnl[complete.cases(curl.fnl), ]
curl.fnl$V1 <- gsub("X", 0,curl.fnl$V1) #getting rid of the X's that were a plague on your data.
count.by.weather<-lm(as.numeric(as.character(curl.fnl$V1)) ~ as.numeric(as.character(curl.fnl$V2)) + as.numeric(as.character(curl.fnl$V3)))
#This should theoretically give summary stats for the lm and above should provide a figure... 
summary(count.by.weather)



?glm
?lm
  
