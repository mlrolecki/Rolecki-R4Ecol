# Now it is time to create your own data frame using the tools we have learned this week.
# First, resave this script as: your last name_Week1_Assignment
  # e.g. mine would be Wilson_Week1_Assignemnt


# Create 3 numeric vectors and 2 character vectors that are each 15 values in length with the following structures:
  # One character vector with all unique values
  # One character vector with exactly 3 unique values
  # One numeric vector with all unique values
  # One numeric vector with some repeated values (number of your choosing)
  # One numeric vector with some decimal values (of your choosing)

a <- c("pink","purple","green","yellow","orange","white","black","blue","brown","beige","gray","red","lilac","aqua","cyan")
b <- c("house","house","house","house","house","house","house","apartment","apartment","apartment","condo","condo","condo","condo","condo")
c <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
d <- c(100,100,111,113,111,144,156,111,100,144,155,167,176,111,100)
e <- c(1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.1,2.2,2.3,2.4,2.5,2.6)

# Bind the vectors into a single data frame, rename the columns, and make the character vector with unique values the row names.

data <- cbind(a,b,c,d,e)
data
df <- as.data.frame(data)
df

colnames(df) <- c("Colors", "Repeated characters", "Numbers", "Numbers repeating","Decimals")
df
row.names(df) <- df$"Colors" #I have never seen this syntax before...very cool that it worked. FYI, you don't need the quotes around colors here.
df


# Remove the character vector with unique values from the data frame.

df <- df[,-1]
df

# Add 1 row with unique numeric values to the data frame.

Chelsea <- data.frame('house',16,100,4.9)
Chelsea
df

colnames(Chelsea) <- colnames(df)    
rbind(df, Chelsea)

#HELP! This is the only part I couldn't get to work :)
row.names(df) <- c(row.names(df[1:14,]),"Another color") # It worked!
df

# Export the data frame as a .csv file 

# Generate summary statistics of your data frame and copy them as text into your script under a new section heading.

####
summary(df) #So close! The numeric columns should have summary statistics with them below.
nrow(df)
ncol(df)
 
#nrow(df) [1] 15
#ncol(df) [1] 4
#> summary(df)
#> #Repeated characters   Numbers          Numbers repeating 
#Length:15           Length:15          Length:15         
#Class :character    Class :character   Class :character  
#Mode  :character    Mode  :character   Mode  :character  
#Decimals        
#Length:15         
#Class :character  
#Mode  :character

# Push your script and your .csv file to GitHub in a new "Week1" folder.

setwd("C:/GitHub/Rolecki-R4Ecol/data")

getwd()


write.csv(df,file="week 1 real")
