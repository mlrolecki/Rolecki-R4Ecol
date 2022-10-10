# First, recreate Figure 4 from Herron et al. (2019). De novo origins of multicellularity in response to predation. Scientific Reports.
  # Search datadryad.org by the paper title and download the dataset. It will include .csv files and R scripts, organized by figure.
  # Save the script and change the working directory on lines 8 and 115 to match your GitHub repository. (6 points)
  # Export and save the plot you've created. (2 points)
  # Zoom into your plot to look at the distribution for different strains.

# Do all of the strains in the plot have the same distributions (yes/no)? (2 pt)

#No, strains B211, B203, and B204 have a much wider distribution than the other strains

# Based on these observations of your strain distributions, why did the authors use a Kruskal-Wallis test rather than ANOVA to compare the strains? (2 pts)

#One assumption of the ANOVA test is that there is equal variance between the groups, while the Kruskal-Wallis test does not assume normalcy, and allows you to analyze data with different variances based on standard deviation.
#based on rank/median, not standard deviation. 

# Use the fitdist() and gofstat() functions to compare the poisson, negative binomial, and logistic distributions for:
  # (1) - The number of cells of progeny (data$Num.Cells.Progeny)
  # (2) - The replication time (data$RepTime.sec)
      # 3 points each
    #HINT- "Num.Cells.Progeny" has defined breaks. To display results, use the formula with the "chisqbreaks" argument as follows:
      #gofstat(list(fit.1, fit.2, fit.3, etc), chisqbreaks=c(1,2,4,8,16,32,64))

library(fitdistrplus)
library(logspline)
data <- read.csv(file=("C:/GitHub/Rolecki-R4Ecol/Week 5/Figure4Data.csv"), header=T)
data <-na.omit(data)
?fitdist 

fit.1 <- fitdist(data$Num.Cells.Progeny, distr="nbinom")
fit.2 <- fitdist(data$Num.Cells.Progeny, distr="pois")
fit.3 <- fitdist(data$Num.Cells.Progeny, distr="logis")
gofstat(list(fit.1, fit.2, fit.3), chisqbreaks=c(1,2,4,8,16,32,64))


fit.4 <- fitdist(data$RepTime.sec, distr="nbinom")
fit.5 <- fitdist(data$RepTime.sec, distr="pois")
fit.6 <- fitdist(data$RepTime.sec, distr="logis")
gofstat(list(fit.4, fit.5, fit.6))


# Based on the AIC scores, which distribution is the best fit for: (4 pts)
  # (1) - The number of cells of progeny (data$Num.Cells.Progeny)?

# The logistic distribution is a better fit for number of progeny

  # (2) - The replication time (data$RepTime.sec)?

# The negative binomial is a better fit for the replication time

# Plot a generic histogram for the replication time (data$RepTime.sec) (2 pt)

hist(data$RepTime.sec, main = "Frequency of Replication Time", xlab = "Replication time")

# Based on the patterns of this histograms and Figure 4:
  #Give one hypothesis for an evolutionary process represented by the two tallest bars in your histogram. (6 pts)
  # Don't cheat by looking at the paper! 
    # This hypothesis does not need to be correct - it only needs to be ecologically rational based these two figures.

#One hypothesis is that the species, over many generations, is diverging into two subspecies with two different standard replication times.
#The times that occur at 50000 and 200000 units might be the most evolutionarily advantageous to the organism, for one reason or another.
#This could be because the faster replication time increases the rate of reproduction, allowing these faster replication genes to be passed on more prevalently
#and the longer replication time may be able to allocate more resources to the offspring, even if they have less of them over time, causing them to be more fit and likely to survive. 

#r/K selection within a species, eh? I like it.






