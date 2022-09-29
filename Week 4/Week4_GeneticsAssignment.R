# Look at the plot and model results for our Dryad data in the tutorial. Part 1: Without knowing which points represent which groups, 
  # give one explanation for why these data might be difficult to draw spatial inferences about genes.(3 points)

#Without knowing what groups the points represent, it would be difficult to determine why the genes of these groups may be grouped together

  # Part 2: Despite the drawbacks, give the result or interpretation that you feel most confident in (3 points), and EXPLAIN WHY (4 points).

#Looking at the black points, we could presume the genes in these groups represent those that are important for each oragnism and is not specific to only a singular group. 
#This s shown by the black points not being clustered, but spread out across the plot.


# For your scripting assignment we will use the "ge_data" data frame found in the "stability" package.
  # Install the "stability" package, load it into your R environment, and use the data() function to load the "ge_data". (2 points)
install.packages("stability")
library(stability)
data("ge_data")


# Create two linear models for Yield Response: one related to the Environment and one to the Genotype. (2 points each)
  # 'Yield Response' in this dataset is a measure of phenotype expression.
  # Hint: Look at the help file for this dataset.

setwd("C:/GitHub/Rolecki-R4Ecol/Week 4")
write.csv(df,file="week 4 assignment.csv")

?ge_data
?stability

lmEnv <- lm(ge_data$Yield~ge_data$Env)
lmGen <- lm(ge_data$Yield~ge_data$Gen)



# Test the significance of both models and look at the model summary. (3 points each)
  # Which model is a better fit to explain the yield response, and WHY? (6 points)
  # Hint: Does one model seem more likely to be over-fitted?

mod.fac <- lm(ge_data$Yield~ge_data$Env)
anova(mod.fac)
summary(mod.fac)

mod.fac <- lm(ge_data$Yield~ge_data$Gen)
anova(mod.fac)
summary(mod.fac)

#The environmental model is a better fit to explain the yield response. The R value is higher and the p value is lower. 
#The genetic model is overfit because there is too much data trying to be explained.

# Which environment would be your very WORST choice for generating a strong yield response? (2 points)