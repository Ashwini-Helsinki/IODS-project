################################################################################
## Author: Ashwini Joshi
## Date: 12-Nov-2021
## Description: Data wrangling exercise of open data science course week-2
################################################################################

#Required R packages or libraries
library(dplyr)

# Read the data in data1
data1 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",sep="\t",header= TRUE)

# Structure of data1
str(data1)
# Data has 60 variables with 183 observations. Gender is a character data type column. All other columns are integers.


# Dimension of data1
dim(data1)
# Dimension of data is 183 rows and 60 columns. One row for each observation and one column for each variable. 


# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(data1, one_of(deep_questions))
data1$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(data1, one_of(surface_questions))
data1$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(data1, one_of(strategic_questions))
data1$stra <- rowMeans(strategic_columns)


# Create column 'attitude' by scaling 'Attitude' column
data1$attitude = data1$Attitude / 10


# choose the required columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(data1, one_of(keep_columns))

# the stucture of the new dataset
str(learning2014)


# select rows where points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

# set working directory
setwd("D:/Helsinki/Courses/OpenDataScience/IODS-project/")

# Write the analysis data
write.csv(learning2014, "data/learning2014.csv", col.names = TRUE, row.names = FALSE)


# Read the analysis data again
data2 <- read.csv("data/learning2014.csv",header = TRUE)

# structure of analysis data
str(data2)

# Check the structure using head() command
head(data2)

# The structure and dimension of the data are as expected.

