# For this week it's time to start exploring your own ideas and questions in R.
  # There are at least five options in the dataset to create the following comparisons.

# (Q1 - 12 pts) Use the dataset from the tutorial to complete one redundancy analysis (RDA) with variance partitioning on a different community (NOT the nematodes).
  # Explain the ecological importance of your significant predictor variables, or the importance if none are significant for your community.

library(readxl)

setwd("C:/GitHub/Rolecki-R4Ecol/Week 9")

abiotic.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Abiotic factors")
abiotic <- as.data.frame(abiotic.tibble)

invert.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Invertebrate_community")
invert <- as.data.frame(invert.tibble)
head(invert)

abiotic.names <- paste(abiotic$Land_Use, abiotic$Parcel)
abiotic$names <- abiotic.names


invert.names <- paste(invert$Landuse, invert$Parcel)
invert$names <- invert.names

abiotic.means <- aggregate(x = abiotic, by = list(abiotic$names), FUN = "mean")
invert.means <- aggregate(x = invert, by = list(invert$names), FUN = "mean")

head(abiotic.means)
head(invert.means)

abiotic.invert <- merge(abiotic.means, invert.means, by = "Group.1", all = FALSE)

abiotic.unmerged <- abiotic.invert[,7:15]
invert.unmerged <- abiotic.invert[,19:50]


#abiotic.means1 <- abiotic.unmerged[,-16] 
#abiotic.means2 <- abiotic.means1[,-1:-6] 
#abiotic.means1 <- sapply(abiotic.means2, as.numeric ) 
#abiotic.means1 <- as.data.frame(abiotic.means2) 

#invert.means1 <- invert.unmerged[,-1:-3]
#invert.means2 <- invert.means1[,-70]
#invert.means2 <- sapply(invert.means2, as.numeric)
#invert.means2 <- as.data.frame(invert.means2)


abiotic.unmerged1<- sapply(abiotic.unmerged, as.numeric)
abiotic.unmerged1 <- as.data.frame(abiotic.unmerged1)
invert.unmerged1 <- sapply(invert.unmerged, as.numeric)
invert.unmerged1 <- as.data.frame(invert.unmerged1)



library(vegan)
colnames(abiotic.unmerged)
ord <- rda(invert.unmerged1 ~ pH + totalN + Perc_ash + Kalium + Magnesium + Ca + Al + TotalP + OlsenP, abiotic.unmerged1)
ord

anova(ord)
plot(ord)  

ord <- rda(invert.unmerged1 ~., abiotic.unmerged1[,-8:-9]) 
ord.int <- rda(invert.unmerged1 ~1, abiotic.unmerged1[,-8:-9])



step.mod <- ordistep(ord.int, scope = formula(ord), selection = "both")
step.mod$anova

step.R2mod <- ordiR2step(ord.int, scope = formula(ord), selection = "forward")


#None of the predictor variables are significant. 
#This means that the abiotic factors, as individuals, do not have a significant statistical effect on the invertebrate communities.
#This is important because it shows that the variables likely have a combined effect on the invertebrate species makeup in the community, 
#rather than one factor driving the differentiation between plots.
#I would have run a next model with your best one or two predictors (perc ash and kalium) to see if those alone produce a significant result.
#What you did is good enough for the assignment though.


# (Q2 - 12 pts) Then use the dataset from the tutorial to create a linear model related to your RDA. Try multiple predictors to find the best fit model.
  # Explain the ecological importance of the significant predictors, or lack of significant predictors.

library(fitdistrplus)
library(logspline)

#Kind of getting confused here I'm not sure what I am supposed to plot... Plotting data from tutorial as linear model to compare to above findings!

plants.tibble <- read_excel("Penaetal_2016_data.xlsx", sheet = "Data_intro_exp_4_species")
plants <- as.data.frame(plants.tibble)

abiotic$Parcel <- unique(abiotic$Parcel)

soil.plants <- merge(abiotic, plants, by = "Parcel")

View(soil.plants)

library(fitdistrplus)
library(logspline)


mod1 <- lm(Leaves ~ pH + totalN + Kalium + Magnesium + Ca + Al + TotalP + Land_use + Species_code,soil.plants)
summary(mod1)
anova(mod1)
AIC(mod1)

summary(mod1)$adj.r.squared

mod2 <- lm(Leaves ~ pH + totalN + Kalium + Species_code,soil.plants)
summary(mod2)
anova(mod2)
AIC(mod1,mod2)

mod3 <- lm(Leaves ~ pH + totalN + Species_code,soil.plants)
summary(mod3)
anova(mod3)
AIC(mod2, mod3)
plot(mod3$residuals)
summary(mod3)$adj.r.squared

mod4 <- lm(Leaves ~ pH*totalN*Kalium + Species_code,soil.plants)
summary(mod4)
anova(mod4)
AIC(mod2,mod3,mod4)
plot(mod4$residuals)
summary(mod4)$adj.r.squared

mod5 <- lm(Leaves ~ pH + Kalium + totalN*Species_code,soil.plants)
summary(mod5)
anova(mod5)
AIC(mod2,mod3,mod4,mod5)
plot(mod5$residuals)
summary(mod5)$adj.r.squared

#So which model is best? it was mod1 but you started ignoring it.

# (Q3 - 6 pts) Provide a 3-4 sentence synthesis of how these results relate to one another and the value of considering both together for interpreting biotic-abiotic interactions.

#The model depicting the abiotic-plant relationship showed a significant relationship between potassium, nitrogen, and plant species as a function of leaf growth. (leaf growth as a function of the others)
#This depicts the importance of these nutrients on the subsequent biomass of the leaves when the levels of these nutrients and plant species are changed.
#Comparatively, there were no distinct predictor values within the abiotic-invertebrate relationship.
#This shows that there is likely an overall effect of the variables combined, as well as outside factors that were not considered.
#This shows may be more relevant to explore the interactions between invertebrates and other data, such as vegetation or the nematode community. 
#As this data was collected within an ecological system, it is important to investigate how all of the variables interact. 
#Even if there isn't a distinct correlation, knowing there is an additive effect only goes to show to the importance of all factors within the system. 
