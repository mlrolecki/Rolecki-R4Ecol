# Read in the "Toscano_Griffen_Data.csv" data from GitHub and load the three packages we used in the tutorial this week.
# The paper these data came from is uploaded to Canvas as "Toscano&Griffen_2014_JAE..."
library(MASS)
library(MuMIn)
library(mgcv)

setwd("C:/GitHub/Rolecki-R4Ecol/Week 6")

df <- read.csv("Toscano_Griffen_Data.csv")
head(df)

# First create models with the same (y) and method (GLMM) as the published paper, using the GLMM function from the tutorial. 
  #Create two different models using the same 3 predictor (x) variables from the dataset. (4 points each) 
    # In one model only include additive effects.
    # In the other model include one interactive effect.
    # Use a binomial distribution and block as a random effect in both models to match the paper's analyses. Remember ?family to find distribution names.

glmm.mod <- glmmPQL(activity.level~toadfish.cue.treatment, family = "logit", random = ~ 1 | block, data = df)

glmm.mod1 <- glmmPQL(activity.level~toadfish.cue.treatment+carapace.width+claw.width, family = binomial, random = ~ 1 | block, data = df)

glmm.mod2 <- glmmPQL(activity.level~toadfish.cue.treatment*carapace.width*claw.width, family = binomial, random = ~ 1 | block, data = df)

?family

# The authors used proportional consumption of prey as the (y) in their model, but did not include this in the dataset.
  # So we are going to create it - run the following line, assuming df= your data frame (feel free to change that):
df$prop.cons <- df$eaten/df$prey 

# (Q1) - The code in line 8 is performing two operations at once. What are they? (2 pts)

#The code is first dividing the number of prey eaten by number of prey given, turning it into a proportion.
#This data is then named df$prop.cons using the <-

# (Q2) - Did the interactive effect change which variables predict proportional consumption? How, specifically, did the results change? (5 pts)

#The interactive effect made it so that all variables were placed against one another to predict prop consumption. 
#This caused there to be 8 variables instead of only 4. The residual was 0.41020, 
#as opposed to the additive model which had a residual of0.41645. The additive effect had a higher residual, meaning it wasn't as good of a fit. 
summary(glmm.mod1)
summary(glmm.mod2)
#If you look at the summary from each model, the predictors are significant in the additive and not in the interactive, suggesting an overfit for the interactive.

# (Q3) - Plot the residuals of both models. Do you think either model is a good fit? Why or why not? (3 pts)

plot(glmm.mod1$residuals, ylim = c(-.1,.1))
plot(glmm.mod2$residuals, ylim = c(-.1,.1))

#Neither is a good fit for this data, as there is a distinct pattern in the residual plot. 

# Re-run both models as generalized additive models instead (using gam). Then compare the AIC of both models. (4 points each)

gam.mod1 <- gam(activity.level~toadfish.cue.treatment+carapace.width+claw.width, family = binomial, random = list(ID=~ 1), data = df)
summary(gam.mod1)
AIC(gam.mod1)

gam.mod2 <- gam(activity.level~toadfish.cue.treatment*carapace.width*claw.width, family = binomial, random = list(ID=~ 1), data = df)
summary(gam.mod2)
AIC(gam.mod2)


# (Q4) - Which model is a better fit? (2 pt)

#Model 1, or the additive effect model, is a better fit, as the AIC is lower.

# (Q5) - Based on the residuals of your generalized additive models, how confident are you in these results? (2 pts)


plot(gam.mod1$residuals, ylim = c(-.1,.1))
plot(gam.mod2$residuals, ylim = c(-.1,.1))

#I am relatively confident that the results for the gam model show a good fit, as the residual data shows no distinct pattern.
#This means that there is likely no underlying correlation that is not being accounted for. 




