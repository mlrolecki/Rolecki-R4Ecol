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
pdf( file = "Genetic drift plot 1.pdf", width = 6, height = 6)
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

install.packages("diverse")
library(diverse)

path_to_file <- system.file("extdata", "PantheonEdges.csv", package = "diverse")
X <- read_data(path = path_to_file)
#hill numbers
diversity(data=X, type="td", q=1)
#rao stirling with differente arguments
diversity(data=X, type="rao-stirling", method="euclidean", alpha=0, beta=1)
#more than one diversity measure
diversity(data=X, type=c('bp','s'))

#?? Unsure how to use p() function!)

#Simpson's index and berger-parker index

#berger.parker.D berger.parker.I  simpson.D simpson.I simpson.R
#Canada             0.3162393        3.162162 0.13174182 0.8682582  7.590604
#Chile              0.3846154        2.600000 0.20923077 0.7907692  4.779412
#China              0.3838384        2.605263 0.17480932 0.8251907  5.720519
#Latvia             0.4444444        2.250000 0.18954248 0.8104575  5.275862
#New Zealand        0.2142857        4.666667 0.06593407 0.9340659 15.166667
#Portugal           0.4285714        2.333333 0.28141136 0.7185886  3.553517
#Saudi Arabia       0.4857143        2.058824 0.32605042 0.6739496  3.067010
#South Africa       0.2647059        3.777778 0.09447415 0.9055258 10.584906
#Uruguay            0.5263158        1.900000 0.33918129 0.6608187  2.948276
#Vietnam            0.5454545        1.833333 0.30909091 0.6909091  3.235294



#Another diversity index: Roa stirling
path_to_file <- system.file("extdata", "PantheonEdges.csv", package = "diverse")
X <- read_data(path = path_to_file)
#hill numbers
diversity(data=X, type="td", q=1)
#rao stirling with differente arguments
diversity(data=X, type="rao-stirling", method="euclidean", alpha=0, beta=1)

#rao.stirling
#Canada          0.4304186
#Chile           0.3801775
#China           0.4084277
#Latvia          0.3827160
#New Zealand     0.4336735
#Portugal        0.3550170
#Saudi Arabia    0.3273469
#South Africa    0.4394464
#Uruguay         0.3130194
#Vietnam         0.3140496
