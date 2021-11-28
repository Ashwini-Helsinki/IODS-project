###########################################################################################################################################
## Author: Ashwini Joshi
## Date: 28-Nov-2021
## Description: Data wrangling exercise of open data science course week-4.
## The datasets used in this exercise are taken from http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets
###########################################################################################################################################

# Required packages
library(dplyr)
library(tidyr)

# read “Human development” dataset
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
# 
# read “Gender inequality” dataset
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# look at the (column) names of “Human development” dataset
names(hd)

# look at the structure of “Human development” dataset
str(hd)

# print out summaries of the variables
summary(hd)

# rename column names to shorter names 
hd <-dplyr::rename(hd, HDI =Human.Development.Index..HDI., LifeExpext = Life.Expectancy.at.Birth, ExpEduYr= Expected.Years.of.Education, MeanEduYr= Mean.Years.of.Education ,  GNI_Cap=Gross.National.Income..GNI..per.Capita, RankDiff_GNI_HDI=GNI.per.Capita.Rank.Minus.HDI.Rank )

# the (column) names of  “Gender inequality” dataset
names(gii)

# the structure of  “Gender inequality” dataset
str(gii)

# summaries of the variables of  “Gender inequality” dataset
summary(gii)

# rename column names to shorter names 
gii <- dplyr::rename(gii, GII =Gender.Inequality.Index..GII., MMR = Maternal.Mortality.Ratio , ABR= Adolescent.Birth.Rate, PercentParlRepre= Percent.Representation.in.Parliament ,  edu2F =Population.with.Secondary.Education..Female., 
              edu2M =Population.with.Secondary.Education..Male., LabF=Labour.Force.Participation.Rate..Female., LabM=Labour.Force.Participation.Rate..Male.)


# mutate the gii data to create two more variables of ratio of female to male secondary education and labor force participation
gii <- data.frame(gii) %>%
  mutate(edu2Ratio = edu2F/edu2M)%>%
  mutate(edu2Ratio = edu2F/edu2M)



# join the two datasets with 'country' as identifier
human <- inner_join(hd, gii, by = "Country")

# set working directory
setwd("D:/Helsinki/Courses/OpenDataScience/IODS-project/")

# save the data as 'human'
write.table(human, "data/human.csv", sep=',', col.names = TRUE, row.names = FALSE)
