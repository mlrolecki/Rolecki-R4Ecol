# With the data frame you created last week you will:


unique.char<- c("pink","purple","green","yellow","orange","white","black","blue","brown","beige","gray","red","lilac","aqua","cyan")
group.char<- c("house","house","house","house","house","house","house","apartment","apartment","apartment","condo","condo","condo","condo","condo")
unique.num<- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15)
rep.num<- c(100,100,111,113,111,144,156,111,100,144,155,167,176,111,100)
dec.num<- c(1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2,2.1,2.2,2.3,2.4,2.5,2.6)

df <- as.data.frame(cbind(unique.char,group.char,uniqu.num,rep.num,dec.num))
df$uniqu.num <- as.numeric(as.character(df$uniqu.num))
df$rep.num <- as.numeric(as.character(df$rep.num))
df$dec.num <- as.numeric(as.character(df$dec.num))



# Create a barplot for one numeric column, grouped by the character vector with 3 unique values
  # Add error bars with mean and standard deviation to the plot
  # Change the x and y labels and add a title
  # Export the plot as a PDF that is 4 inches wide and 7 inches tall.

df.mean <- aggregate(df$rep.num ~df$group.char, FUN = "mean")
df.mean

colnames(df.mean) <- c("Factor","Mean")
df.mean

barplot(df.mean$Mean)

barplot(df.mean$Mean, names.arg = df.mean$Factor)

df.sd <- aggregate(df$rep.num ~df$group.char, FUN = "sd")
colnames(df.sd) <- c("Factor","Standard.Dev")
df.sd

b.plot <- barplot(df.mean$Mean, names.arg = df.mean$Factor)

arrows(b.plot, df.mean$Mean-df.sd$Standard.Dev,
       b.plot, df.mean$Mean+df.sd$Standard.Dev,angle=90,code=3)

b.plot <- barplot(df.mean$Mean, names.arg = df.mean$Factor, ylim = c(0,250))

arrows(b.plot, df.mean$Mean-df.sd$Standard.Dev,
       b.plot, df.mean$Mean+df.sd$Standard.Dev,angle=90,code=3)

barplot(df.mean$Mean, names.arg = df.mean$Factor, xlab = "House type", ylab = "Number", main = "My Least favorite barplot plot",cex.main=0.8,ylim = c(0,200))
arrows(b.plot, df.mean$Mean-df.sd$Standard.Dev,
       b.plot, df.mean$Mean+df.sd$Standard.Dev,angle=90,code=3) #But why least favorite? :(

#### Create a scatter plot between two of your numeric columns.

plot(df$dec.num ~ df$uniqu.num)
plot(df$dec.num ~ df$uniqu.num, xlab = "Number of things we do in this class", ylab = "Number of times I get confused", main = "I promise I like this class", col = (123.96), pch = (7))
#What happened to the fantastic logrithmic version? This feels less optimistic...

# Change the point shape and color to something NOT used in the example.
  # Change the x and y labels and add a title
  # Export the plot as a JPEG by using the "Export" button in the plotting pane.

# Upload both plots with the script used to create them to GitHub.
  # Follow the same file naming format as last week for the script.
  # Name plots as Lastname_barplot or Lastname_scatterplot. Save them to your "plots" folder.


setwd("C:/GitHub/Rolecki-R4Ecol/data")
getwd()
write.csv(df,file="week 2 Assignment")

#almost perfect! Forgot to specify the PDF dimensions. 