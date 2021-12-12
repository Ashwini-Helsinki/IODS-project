###########################################################################################################################################
## Author: Ashwini Joshi
## Date: 10-Dec-2021
## Description: Data wrangling exercise of open data science course week-6.
###########################################################################################################################################

# Required packages
library(dplyr)
library(tidyr)
library(stringr)
setwd("D:/Helsinki/Courses/OpenDataScience/IODS-project/")

###########################################################################################################################################

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# BPRS data is taken from Davis (2002). The data has information about 40 male subjects randomly assigned to one of two treatment groups. Each subject was rated
# on the brief psychiatric rating scale (BPRS) measured before treatment began (week 0) and then at weekly intervals for eight weeks. The BPRS assesses
# the level of 18 symptom constructs such as hostility, suspiciousness, hallucinations and grandiosity; each of these is rated from one (not present) to seven
# (extremely severe). The scale is used to evaluate patients suspected of having schizophrenia.

# save BPRS data in the 'data' folder of IODS project.
write.table(BPRS, "data/BPRS.csv",sep=',',row.names = FALSE,col.names = TRUE)

# Dimension of the BPRS data
dim(BPRS)

# column names of the data
names(BPRS)

# structure of the data
str(BPRS)

# look at the data briefly
glimpse(BPRS)
head(BPRS)


# summary of variables
summary(BPRS[,3:11])

# glimpse or head of data show that each row represents 1 patient completely. 
# Patient ID, Patient's treatement and every weeks brps measuments are given in each row.
# First 2 columns are for treatment id and patient id, column 3 onwards show one week's measument of all the patients.
# The data summary shows minimum, maximum, mean and 3 quantiles of observations of all the patients in each week. 
# It can be seen that, mean is decreasing each week as the treatment progresses.  


# Convert categorical variables 'treatment' and 'subject' to factors.
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert the data from wide to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# create a column of the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
head(BPRSL)

# summary of variables
summary(BPRSL)

# initial rows of the long-form data show that each row is now 1 'brps' measurement for 1 patient. 
# In the wide form each row represented all weeks' observations of 1 patient.
# Summary of this long form shows quantiles, min, max and mean values of all 'bprs' values together. 
# In the wide form, one week was shown by 1 column so the summary of that column was from 1 weeks observation.

# save BPRS long data in the 'data' folder of IODS project.
write.table(BPRSL, "data/BPRSL.csv",sep=',',row.names = FALSE,col.names = TRUE)

###########################################################################################################################################


# Repeat the above analysis for RATS data
# Read the data 
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

# save RATS data in the 'data' folder of IODS project.
write.table(RATS, "data/RATS.csv",sep=',',row.names = FALSE,col.names = TRUE)

# RATS data is from a nutrition study conducted in three groups of rats (Crowder and Hand, 1990). The three groups were put on different diets, and
# each animal’s body weight (grams) was recorded repeatedly (approximately weekly, except in week seven when two recordings were taken) over a 9-week
# period.

# Dimension of the RATS data
dim(RATS)

# column names of RATS data
names(RATS)

# structure of RATS data
str(RATS)

# look at RATS data briefly
glimpse(RATS)
head(RATS)

# summary of variables
summary(RATS)


# glimpse or head of data show that each row represents 1 rat completely. 
# Rat ID, its group and every measument are given in each row.
# First 2 columns are for group and rat is, column 3 onward show one weekday's measurement of all the patients.
# The data summary shows minimum, maximum, mean and 3 quantiles of observations of all the rats in each weekday. 
# A clear increasing trend in measurements can be seen.  



# Convert categorical variables 'ID' and 'Group' to factors.
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)


# Convert the data from wide to long form
RATSL <-  RATS %>% gather(key = WDs, value = Weight, -Group, -ID)

# create a column of the week number
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WDs,3,length(WDs))))

# Take a glimpse at the RATSL data
glimpse(RATSL)
head(RATSL)


# summary of variables
summary(RATSL)

# initial rows of the long-form data show that each row is now 1 measurement for 1 rat. 
# In the wide form each row represented all observations of 1 rat.
# Summary of this long form shows quantiles, min, max and mean values of all 'Weight' values together. 
# In the wide form, one week was shown by 1 column so the summary of that column was from 1 week's observation.

# save RATS long data in the 'data' folder of IODS project.
write.table(RATSL, "data/RATSL.csv",sep=',',row.names = FALSE,col.names = TRUE)
###########################################################################################################################################
