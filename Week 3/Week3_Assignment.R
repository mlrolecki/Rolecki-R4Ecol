# (1) Approximately how many hours ahead of Sunbury was the peak flow in Lewisburg during the 2011 flood? (2 pt)
  
#About 8 hours ahead

# (2) Give one reason why information on the time between peak flow events up- and downstream could be valuable? (4 pts)

#In the future, this information could allow disaster management teams to warn and reach those in the downstream areas in time to 
#rescue people from severe floods, in the case of hurricanes and other extreme weather conditions that would cause this anomoly. 

# Package scavenger hunt! (12 pts each)

## (3) Using Google and ONLY packages from GitHub or CRAN:
    # Find a package that contains at least one function specifically designed to measure genetic drift.
    # Copy-paste into your script - and run - an example from the reference manual for a function within this package related to a measure of genetic drift. 
        # Depending on the function, either upload a plot of the result or use print() and copy/paste the console output into your script.
    # After running the function example, manipulate a parameter within the function to create a new result. 
        # Common options might be allele frequency, population size, fitness level, etc. 
        # Add the results of this manipulation to your script (if in the console) or upload the new plot.
       
          # By manipulating these parameters you can see how it impacts the results.
          # This type of manipulation is one example of how theoretical ecology and modelling are used to predict patterns in nature.
install.packages("learnPopGen")
library(learnPopGen)

genetic.drift(p0=0.5, Ne=20, nrep=10, time=100, show="p", pause=0.1)
#Example:
genetic.drift()
object<-genetic.drift(p0=0.7,show="heterozygosity")
plot(object,show="genotypes")

#I tried to save this... not going well
#Edit, resaved using export function; would like to revisit code pdf saving process
setwd("C:/GitHub/Rolecki-R4Ecol/Week 3")
pdf( file = "Genetic drift plot 1", width = 6, height = 6)
genetic.drift()
object<-genetic.drift(p0=0.7,show="heterozygosity")
plot(object,show="genotypes")
dev.off()


#Changing allele frequency and adding pop size
genetic.drift()
object<-genetic.drift(p0=0.7,Ne= 1000,show="heterozygosity")
plot(object,show="genotypes")

## (4) Using Google and ONLY packages from GitHub or CRAN:
    # Find a package that will generate standard diversity metrics for community ecology, specifically Simpson's Diversity Index.
    # Copy-paste into your script - and run - an example from the reference manual for a function to calculate Simpson's diversity. 
        # Depending on the example usage of the function, either upload a plot of the result or use print() and copy/paste the console output into your script.
    # After running the function example, modify your script to generate another diversity metric that is NOT part of the example. 
        # If there are two diversity metrics in the example script, neither of these will count as the modified script.
        # Hint: If the function can "only" caluclate Simpson's diversity, the inverse of Simpson's diversity is another common metric. 
        # Add the results of this manipulation to your script (if in the console) or upload the new plot.
        
          # Diversity metrics are frequently used in community ecology for reasons ranging from a quick comparison between sites to understanding community stability.
          # Their calculation can be very tedious by hand - and very fast with a package designed for the operation.



