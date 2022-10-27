# For this week it's time to start exploring your own ideas and questions in R.
  # There are at least five options in the dataset to create the following comparisons.

# (Q1 - 12 pts) Use the dataset from the tutorial to complete one redundancy analysis (RDA) with variance partitioning on a different community (NOT the nematodes).
  # Explain the ecological importance of your significant predictor variables, or the importance if none are significant for your community.

library(readxl)

setwd("C:/GitHub/Rolecki-R4Ecol/Week 8")

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


abiotic.means$Group.1==invert.means$Group.1


library(vegan)
colnames(abiotic.unmerged)
ord <- rda(invert.unmerged1 ~ pH + totalN + Perc_ash + Kalium + Magnesium + Ca + Al + TotalP + OlsenP, abiotic.unmerged1)
ord

anova(ord)
plot(ord)  
# (Q2 - 12 pts) Then use the dataset from the tutorial to create a linear model related to your RDA. Try multiple predictors to find the best fit model.
  # Explain the ecological importance of the significant predictors, or lack of significant predictors.

# (Q3 - 6 pts) Provide a 3-4 sentence synthesis of how these results relate to one another and the value of considering both together for interpreting biotic-abiotic interactions.


