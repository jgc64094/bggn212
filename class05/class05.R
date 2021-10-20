#' ---
#' title: "Class05: Data Visualization"
#' author: "Jose Chacon"
#' date: "October 13, 2021"
#' ---
#Today we are going to use ggplot2 package

#First we need to load the package! 
# install.packages("ggplot2")
library(ggplot2)

#We will use this inbuilt "cars" dataset first
head(cars)

#All ggplots have at least 3 layers,
# data +aes +geoms
ggplot(data=cars) +
  aes(x=speed, y=dist) + 
  geom_point() +
  geom_smooth(method="lm")
  labs(title="Stopping Distance of Old Cars",
       x="Speed(MPH)",
       y="stopping Distance(ft)")
#side note ggplot is not the only graphics system
#a very popular one is good old "base" R graphics
plot(cars)

#New dataset from bioboot
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)
#Q. Number of genes indicated by row?
nrow(genes)

#Q. Number of columns?
ncol(genes)

#Q. How many genes are upregulated?
table(genes$State)

#Q. What % are up?
#x <- (127/5196)*(100)
round(table(genes$State)/nrow(genes) * 100, 2)

#Lets make a figure
p <- ggplot(genes) +
  aes(x=Condition1, y= Condition2, col=State) +
  scale_colour_manual( values=c("turquoise","grey","orange") ) +
  geom_point() 

#Color choice below
#p + scale_colour_manual( values=c("turquoise","grey","orange") )
p + labs(title="Gene Expression Changes Upon Drug treatment", x= "Drug Treatment", y= "Control (no drug)")

#OPTIONAL Let's explore the gapminder dataset
#install.packages("gapminder")
library(gapminder)
head(gapminder)

#Let's make a new plot of your year vs life Exp
ggplot(gapminder) +
  aes(x=year, y=lifeExp, col=continent) +
  geom_jitter(width=0.3, alpha=0.4) +
  geom_violin( aes(group=year), alpha=0.2,
               draw_quantiles = 0.5)
        
# Install the plotly
#Install.packages("plotly")
#plotly is unavailable for pdf
#library(plotly)
#ggplotly()


  # install.packages("dplyr")
library(dplyr)
gapminder_2007 <- gapminder %>% filter(year==2007)
#trouble with running code
gapminder_2007
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y= lifeExp)+
  geom_point()

# Assignment 9 - Combining plots
#install.packages('patchwork')
library(patchwork)

# Setup some example plots 
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# Use patchwork to combine them here:
(p1 | p2 | p3) /
  p4



