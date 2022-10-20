# Load the "anytime" and "ggplot2" packages to complete this week's assignment.

library(anytime)
library(ggplot2)

# Read the "Plankton_move_average" CSV in from GitHub. 
# These are df from the Great Lakes Environmental Research Laboratory plankton sampling.

setwd("C:/GitHub/R4Ecol_2022/Week7")

df <- read.csv("Plankton_move_average.csv")
head(df)

#Used the following lines to format the date and remove NAs from the dfset:
df$Date <- as.Date(df$Date, origin = "0001-01-01") # Setting values to "day zero".
df <- na.omit(df)

#Plot these population df over time with the following code:
ggplot(df)  +
  xlab("Numeric Date") + ylab("Density Individuals")+
  geom_line(df=df, aes(Date, D.mendotae), color="black", alpha = 0.7, size=1)+
  geom_line(df=df, aes(Date, LimncalanusF+LimncalanusM), color="orange",  alpha = 0.7, size=1)+ # adding males and females together, hint: this is actually spelled Limnocalanus
  geom_line(df=df, aes(Date, Bythotrephes), color="sky blue",  alpha = 0.7, size=1)+
  geom_line(df=df, aes(Date, Bythotrephes), color="sky blue",  alpha = 0.7, size=1)+
  theme_bw() 

# Export this plot to have on hand for reference in the next section of the assignment (and upload with your script).

# (1) - Which species is most likely to be r-selected prey and which its primary predator? (2 pts)
# What is one relationship the third species MIGHT have to the first two? (2 pts)

#The species shown using the black line (D.mendotae) is likely to be r-selected due to it's wide fluctuations in population, showing large birth rates and death rates.
#The primary predator is the orange line (Limnocalanus), as it is shown to react directly to the fluctuations in the prey abundance. 
#The third species may be a tertiary predator that relies not only on these two species for food, but many others as well. 
#That's why the curve is much shallower; there is a lesser population, they rely less on only these two species, and they are less drastically effected by the other two species. 

#Now copy/paste in the Lotka-Volterra function, plotting script, and load the "deSolve" package from the tutorial:

library(deSolve)

LotVmod <- function (Time, State, Pars) {
  with(as.list(c(State, Pars)), {
    dx = x*(alpha - beta*y)
    dy = -y*(gamma - delta*x)
    return(list(c(dx, dy)))
  })
}

Pars <- c(alpha = 2, beta = 0.5, gamma = .2, delta = .6) #This is the line we will change
State <- c(x = 10, y = 10)#For now keep this the same.
Time <- seq(0, 100, by = 1)#For now keep this the same.
out <- as.data.frame(ode(func = LotVmod, y = State, parms = Pars, times = Time)) #This is the operation that creates the Lotka-Volterra model based on our specified parameters.
matplot(out[,-1], type = "l", xlab = "time", ylab = "population")
legend("topright", c("Rabid foxes", "Cute bunnies"), lty = c(1,2), col = c(1,2), box.lwd = 0)


# (2) - What do alpha, beta, gamma, and delta represent in this function? (4 pts)

#alpha- the rate of prey population growth
#beta- rate of predation
#gamma- rate of prey consumption (pop stability)
#delta- rate of prey consumption (pred die off)

# (3) - By only changing values for alpha, beta, gamma, and/or delta
# change the default parameters of the L-V model to best approximate the relationship between Limncalanus and D.mendotae, assuming both plots are on the same time scale.
# What are the changes you've made to alpha, beta, gamma, and delta from the default values; and what do they say in a relative sense about the plankton df? (4 pts)
# Are there other paramenter changes that could have created the same end result? (2 pts)
# Export your final L-V plot with a legend that includes the appropriate genus and/or species name as if the model results were the real plankton df, 
# and upload with your script. (hint - remember which one is the predator and which is the prey)

Pars <- c(alpha = 1.1, beta = 0.4, gamma = .8, delta = .81) #This is the line we will change
State <- c(x = 10, y = 10)#For now keep this the same.
Time <- seq(0, 100, by = 1)#For now keep this the same.
out <- as.data.frame(ode(func = LotVmod, y = State, parms = Pars, times = Time)) #This is the operation that creates the Lotka-Volterra model based on our specified parameters.
matplot(out[,-1], type = "l", xlab = "time", ylab = "population")
legend("topright", c("Limnocalanus", "D.mendotae"), lty = c(1,2), col = c(1,2), box.lwd = 0)


#I have decreased alpha and beta while increasing gamma and delta. 
#This shows the population growth and rate of predation were both low, while the rate of consumption and predator die off were high.
#This depicts the short lifespan and relative r-selection of the species, in which they have lots of offspring and many do not survive. 
#Yes, there are a variety of changes that could lead to the same outcome. If the alpha and beta were increased, the gamma and delta would just have to be increased to reflect that. 
