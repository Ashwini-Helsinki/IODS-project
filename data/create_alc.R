###########################################################################################################################################
## Author: Ashwini Joshi
## Date: 19-Nov-2021
## Description: Data wrangling exercise of open data science course week-3.
## The data used in this exercise is taken from the UCI Machine Learning Repository, Student Performance Data (incl. Alcohol consumption) page.
## Original source: Paulo Cortez, University of Minho, GuimarÃ£es, Portugal, http://www3.dsi.uminho.pt/pcortez
###########################################################################################################################################

# Required packages
library(dplyr)

# Set working directory
setwd("D:/Helsinki/Courses/OpenDataScience/IODS-project/data/")

# Read student-mat.csv (Math course) and student-por.csv (Portuguese language course) datasets
matdata <- read.table("student-mat.csv", sep=";", header=TRUE)

# Dimension and structure of dataset
dim(matdata) # 395 rows and 33 columns
str(matdata)

# Read student-mat.csv (Math course) and student-por.csv (Portuguese language course) datasets
pordata <- read.table("student-por.csv", sep=";", header=TRUE)

# Dimension and structure of dataset
dim(pordata) # 649 rows and 33 columns
str(pordata) 

# Columns which are not part of student identifier
Notjoinby <- c("failures", "paid", "absences", "G1", "G2", "G3")

# Column names of Maths dataset
allcolnames <- colnames(matdata)

# common columns to use as identifiers = (allcolnames - Notjoinby)
join_by <- allcolnames[!(allcolnames %in% Notjoinby)]

# join the two datasets by the selected identifiers
math_por <- inner_join(matdata, pordata, by = join_by, suffix = c(".math", ".por"))

# structure of joined data
str(math_por)

# Dimension of joined data
dim(math_por)


# create new data for saving information about alcohol consumption
alc <- math_por

# for every column name not used for joining take average from Maths and Por data.
for(column_name in Notjoinby) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column  vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)

# Alcoholo use by taking average of daily and weekly
alc$alc_use = apply(cbind(alc$Dalc, alc$Walc),1,mean)

# Binary variable indicating high alcohol consumption
alc$high_use = ifelse(alc$alc_use> 2, 'TRUE','FALSE')

# Save joined data
write.table(math_por,'Joindata.csv', sep=',',col.names = TRUE, row.names = FALSE)

# glimpse at the joined data. It has 370 rows.
glimpse(math_por)

# Save modified data
write.table(alc,'Alcdata.csv', sep=',',col.names = TRUE, row.names = FALSE)


# glimpse at the modified data
glimpse(alc)