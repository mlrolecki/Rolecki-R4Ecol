# Load the packages from this week's tutorial.
#In the tutorial we looked at the community as a whole and the swimmers which ultimately matched a prediction we had for their distribution.


library(spdep)
library(adespatial)
library(vegan)


PatchLatLon.csv <- read.csv("PatchLatLon.csv", header=T)
Diptera.csv <- read.csv("Diptera.csv", header=T)
HabitatbyPatch.csv <- read.csv("HabitatbyPatch.csv", header=T)
Trichoptera.csv <- read.csv("Trichoptera.csv", header=T)

PatchLatLon.mat <- as.matrix(PatchLatLon.csv[,-1])
Diptera.mat <- as.matrix(Diptera.csv)
HabitatbyPatch.mat <- as.matrix(HabitatbyPatch.csv)
Trichoptera.mat <- as.matrix(Trichoptera.csv)

nb<-cell2nb(3,30,"queen") 
nb1 <- droplinks(nb, 19, sym=TRUE) 
nb2 <- droplinks(nb1, 22, sym=TRUE)
nb3 <- droplinks(nb2, 25, sym=TRUE)
nb4 <- droplinks(nb3, 30, sym=TRUE)

bin.mat <- aem.build.binary(nb4, PatchLatLon.mat, unit.angle = "degrees", rot.angle = 90, rm.same.y = TRUE, plot.connexions = TRUE)
plot(PatchLatLon.mat[,2]~PatchLatLon.mat[,3], xlim = rev(c(76.75,77)))

aem.ev <- aem(aem.build.binary=bin.mat)
aem.df <- aem.ev$vectors[c(-19,-22,-25,-30),]
aem.df

Space.rda <- rda(Diptera.mat, as.data.frame(aem.df))
Space.r2a <- RsquareAdj(Space.rda)$adj.r.squared

aem.fwd <- forward.sel(Diptera.mat,aem.df, adjR2thresh=Space.r2a)

aem.fwd$order

# space controlling for habitat- Conditional= 40%, constrained = 43%, unconstrained = 16%
SpaceNoHab.rda <- rda(Diptera.mat, as.data.frame(aem.df[,aem.fwd$order]), HabitatbyPatch.mat)
SpaceNoHab.rda 
anova(SpaceNoHab.rda, perm.max = 10000)
RsquareAdj(SpaceNoHab.rda)

#habitat controlling for space - cond = 79%, const = 4%, uncon= 16%
HabNoSpace.rda <- rda(Diptera.mat, HabitatbyPatch.mat, as.data.frame(aem.df[,aem.fwd$order]))
HabNoSpace.rda 
anova(HabNoSpace.rda, perm.max = 10000)
RsquareAdj(HabNoSpace.rda)

TriSpace.rda <- rda(Trichoptera.mat, as.data.frame(aem.df))
TriSpace.r2a <- RsquareAdj(TriSpace.rda)$adj.r.squared

Triaem.fwd <- forward.sel(Trichoptera.mat,as.data.frame(aem.df), adjR2thresh=TriSpace.r2a)

# space controlling for habitat- cond= 23%, const= 57%, uncon= 19%
TriSpaceNoHab.rda <- rda(Trichoptera.mat, as.data.frame(aem.df[,Triaem.fwd$order]), HabitatbyPatch.mat)
TriSpaceNoHab.rda 
anova(TriSpaceNoHab.rda, perm.max = 10000)
RsquareAdj(TriSpaceNoHab.rda)

#habitat controlling for space- cond= 78%, const= 2.5%, uncon= 19%
TriHabNoSpace.rda <- rda(Trichoptera.mat, HabitatbyPatch.mat, as.data.frame(aem.df[,Triaem.fwd$order]))
TriHabNoSpace.rda 
anova(TriHabNoSpace.rda, perm.max = 10000)
RsquareAdj(TriHabNoSpace.rda)


#Part 1: Look at two other subsets of the community and determine the relative influence of space and habitat on each following the methods in the tutorial. (10 points)
#The options include groupings by taxonomy, where Diptera (true flies) have the strongest flight ability, Trichoptera the 2nd strongest, 
    #Ephememeroptera are 3rd, and non insects are 4th...because they don't have wings.
#Groupings by habits include the swimmers (off limits for the assignment) as most mobile, sprawlers as 2nd (they move in search of food, but not quickly),
    #and the clingers come in last (they might move up and down on individual rocks).



#Part 2: What is your interpretation of the pattern for each group individually, and the two in comparison, based on their mobility? (5 points)

#First, 43% of Diptera occurrence can be explained by space (lat/long) while only 4% is explained hy habitat, when the variables are discrete.
#This shows that Diptera can inhabit a wider range of space than habitat, where they are more restricted. 
#Similarly, 57% of Trichoptera occurrence can be explained by space (lat/long) while only 2.5% is explained by habitat, when the variables are discrete. 
#This shows that Trichoptera can also inhabit a wider range of space, and is more limited by habitat. 
#Diptera and Trichoptera both are more commonly limited by habitat than space. 
#This makes sense, as both insects have flight ability and can move across space rather easily, while they more be more restricted by clinmate and environmental factors raised by habitat change. 

#Part 3: For each of your chosen groups of bugs, perform variable selection for the habitat data rather than the AEM data. Which habitat variables are significant for each? (10 points)
  # Definitions for the habitat column names:
    #Inorg = total suspended inorganic solids in the water column
    #Organ = total suspended organic solids in the water column
    #Chla = Chlorophyll a concentration from benthic rocks collected in-stream
    #BOM = total benthic organic matter in the sample
    #Depth = water depth
    #Flow	= water velocity where samples were collected
    #Fines = Percent of the substrate as "fines" i.e. small particles too small to measure
    #AveAr = The average size of rocks where each sample was collected


#Part 4: How do you expect selecting both the spatial and the habitat variables would change the results of the RDAs from Part 1 above? (5 points)
  #(You do not need to redo the RDAs, unless you *want* to.)