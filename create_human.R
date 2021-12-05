###########################################################################################################################################
## Author: Ashwini Joshi
## Date: 28-Nov-2021
## Description: Data wrangling exercise of open data science course week-5.
## The datasets used in this exercise is saved in the last week's exercise.
###########################################################################################################################################

# Required packages
library(dplyr)
library(tidyr)
library(stringr)


# set working directory
setwd("D:/Helsinki/Courses/OpenDataScience/IODS-project/data")

# read “Human.csv” dataset saved last week
human <- read.table("human.csv", sep=',', header=TRUE)

# structure of the data 
str(human)

# dimension of data
dim(human) # 195 rows(observations) and 19 columns (variables)

# 'human' data is created by combining two datasets from 'http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/'.
# one dataset was about human development index and other dataset about gender inequality index.
# Description of this new 'human' dataset variables. 

# The data combines several indicators from most countries in the world

# "Country" = Country name
# 
# # Health and knowledge
# 
# "GNI_Cap" = Gross National Income per capita
# "LifeExpect" = Life expectancy at birth
# "ExpEduYr" = Expected years of schooling 
# "MMR" = Maternal mortality ratio
# "ABR" = Adolescent birth rate
# 
# # Empowerment
# 
# "PercentParlRepre" = Percentage of female representatives in parliament
# "edu2F" = Proportion of females with at least secondary education
# "edu2M" = Proportion of males with at least secondary education
# "LabF" = Proportion of females in the labour force
# "LabM" " Proportion of males in the labour force
# 
# "edu2Ratio" = edu2F / edu2M
# "LabRatio" = LabF / LabM

str(human$GNI_Cap) # structure of GNI_Cap column

# Convert GNI_Cap variable to numeric by changing ',' to '.'
human <- data.frame(human) %>%
  mutate(GNI_Cap = as.numeric(str_replace(GNI_Cap, ",", "")))


# List of required variables
ReqVar <- c("Country", "GNI_Cap", "LifeExpect", "ExpEduYr" , "MMR", "ABR", "PercentParlRepre", "edu2Ratio", "LabRatio" )


# use human data of required variables only
human <- human[,ReqVar]

# Remove rows with missing values
human <- na.omit(human)

print(human$Country)
# Last 7 rows are for regions and not countries so they are removed.
human <- human[1:155,]

# set Country as rownames
rownames(human) <- human$Country

# remove the Country variable
human <- select(human, -Country)

# save the data as 'human'
write.table(human, "human.csv", sep=',', col.names = TRUE, row.names = TRUE)