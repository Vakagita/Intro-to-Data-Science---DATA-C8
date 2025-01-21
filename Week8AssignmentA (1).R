# Math 17 - Week 9

setwd('C:/Vaishu/Math17/Lecture/Week9/')

# Review basing graphic tools in r
library(ggplot2)

data(mtcars)
attatch(mtcars)
X <- mtcars
View(x)

# how many cars and their number of cyclineder 
table(X$cyl)

#Anytime dont know what these variables are do
?mtcars

#how many automatic cars and how many are manual
table(X$am)

#Basic graphing tools in R
#gives scatter plot
plot(sort(X$mpg))

#Piping - does exactly what line 19 does
X$mpg |> sort() |> plot()

#graphing mpg versus how powerful the cars are
plot(X$hp, X$mpg)

# Makes into histogram
X$mpg |> hist()

#makes box plot
X$mpg |> boxplot(horizontal = T, xlab = 'mpg')


# Generating linear regression model - predictor is horse 
# power and response is MPG
plot(X$hp, X$mpg)
# Format is y versus x - do this first to get linear 
# regression model then assign it to model
# lm(data = mtcars, mpg ~ hp)
# Coefficients:
## 30.09886     -0.06823  
Model <- lm(data = mtcars, mpg ~ hp)
abline(Model)

# Another way to do this is with the curve command
# You can graphy anything on the graph
# can be any graph not just linear function
plot(X$hp, X$mpg)
curve(30.1 - 0.06823 *x, add = T)
abline(v = 150)
abline(h= 120)


# Talk more about GGPlot
# GG = Grammar of graphics
# Most effient way to create graphics
# Basic strategy of ggplot is done through piping strategy

# First step - tell where data is coming from and what variables you have
# Varaiables"
# aes = aesthetics
ggplot(mtcars, aes(x=hp, y = mpg)) +
  geom_point(size = 3, col = 'blue')

# can take this further and go back to mtcars data 
# frame and pipe that to ggplot
mtcars |> ggplot (aes(x=hp, y = mpg)) +
  geom_point(size = 3, col = 'darkgreen')

# You can save diff layers and go back t before layer
L1 = mtcars |> ggplot (aes(x=hp, y = mpg))
L1 + geom_point(size = 3, col = 'blue', shape = 10)

# One reason for ggplot is to learn more about data using graphs

# We have 3 kinds of cars in the data -
# $, 6, and 8 cylinder cars
# Lets see the differences between these 3 classes
# So we are exploring the data 
# This is called...
# EDA = Exploratory Data Analysis

ggplot(mtcars, aes(hp, mpg)) + geom_point(size = 3)

# understanding mpg vs.hp in terms of cylinders

# Coloring different according to number of cylinders of the car
ggplot(mtcars, aes(hp, mpg, color = factor(cyl))) +
  geom_point(size=3)
#Shows graph of trends of 4, 6, and 8 cylinder cars using colors

# Disagregate with different shapes 
ggplot(mtcars, aes(hp, mpg, shape = factor(cyl))) +
  geom_point(size=3)
# Same thing but shows trends using diff shapes


# Understanding mpg vs.hp in terms of whether cars 
# have automatic or manual transmissions
ggplot(mtcars, aes(hp, mpg, color = factor(am))) +
  geom_point(size=3)

# Facet graphs - seeing diff faces of graphs for diff groups
ggplot(mtcars, aes(hp, mpg)) + geom_point() +
  facet_wrap(~cyl)

# Create a new and if they are mainstream cars then they are not
# 8 cylinders. So its either true or fals
# So you can disaggregrate using true(6 cylinders) or false(8 cylinders)
# True if its a mainstream cars
mtcars$mainstream <- cyl <=6
View(mtcars)
# Error - saying Error: object 'cyl' not found

ggplot(mtcars, aes(hp, mpg)) + geom_point() + 
  facet_wrap(~mainstream)

# Diamond data set - that we are gonna be work with for homework
?diamonds
attach(diamonds)

# DS stands for data set
DS <- diamonds
View(DS)

#Lets say I want to buy a diamond and only want to spend 4K
# Pull a subset of the data sset
# want to spend at most 4K
DS_small <- subset(DS, price<=4000)
View(DS_small)

# We are gonna look at price in terms of how big the diamond is
# Graphing price versus how big the diamond is
# THen gonnna divide this into different faces of the graph by cut

ggplot(DS_small, aes(carat, price)) + geom_point() + facet_wrap(~color)
  # facet_wrap(~cut)

# Wanna look at the best cuts of diamonds within 
# price range dont want just fair
# Looking at it(Dissagregating) by color remember is D is the 
# best while J is the worst

#Know gonna grab a smaller set of data like maybe the F color within 4K
DS_smaller <- subset(DS, price <= 4000 & color == 'F')
View(DS_smaller)

# Now trying to look at those diamonds in data set
# Generating a point plot for these only 
ggplot(DS_smaller, aes(carat, price)) + geom_point()

# Alright two very good ways for disaggregrating data is by 
# coloring points on the graph then doing a faceted graph
# So can see different faces of the graph