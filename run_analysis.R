## ------------------------------ run_analysis.R ------------------------------ ##
## This is the main script to be run to perform the data cleanup. This assumes  ##
## the data set has been downloaded and is placed in your working directory. I  ##
## have used my personal directory as the wd. If you run this script, please    ##
## update the wd to the one you use.                                            ##
##                                                                              ##
## This script uses three functions, which are coded in three different R files ##
##  - get_subject_activity.R                                                    ##
##  - get_raw_data.R                                                            ##
##  - get_avg_data.R                                                            ##
##                                                                              ##
## Also, unlike the instructions, in this script we actually merge the datasets ##
## in the last step instead of the first. The reason for doing that is if you do##
## merging (rbind) at the last, you'll be working on smaller datasets and hence ##
## your script will run faster. This does not alter the results.                ##
## ------------------------------ run_analysis.R ------------------------------ ##

library("dplyr")
setwd("C:/Users/wilsonee/Documents/Coursera/Getting and Cleaning Data/tidydata")

###### ----------------------------- Step 1 ------------------------------- ######
# Source the get_subject_activity function. This returns a data frame merging the
# subjects and activity. training & test data are held in different files.
source("get_subject_activity.R")
# Call get_subject_activity with the parameter 'train' to get training data
subject_activity_train <- get_subject_activity("train")
# Call get_subject_activity with the parameter 'test' to get test data
subject_activity_test <- get_subject_activity("test")

###### ----------------------------- Step 2 ------------------------------- ######
# Source the get_raw_data function. This returns a data frame containing only the
# mean and standard deviation fields. training & test data are held in different 
# files.
source("get_raw_data.R")
# Call get_raw_data with the parameter 'train' to get training data
raw_data_train <- get_raw_data("train")
# Call get_raw_data with the parameter 'test' to get test data
raw_data_test <- get_raw_data("test")

###### ----------------------------- Step 3 ------------------------------- ######
# Source the get_avg_data function. This returns a data frame of raw data 
# aggregated on subject & activity. We pass the data frames received from step 1 
# and step2.
source("get_avg_data.R")
# Call get_avg_data with the df's obtained from step1 and step 2 for training
avg_data_train <- get_avg_data(subject_activity_train,raw_data_train)
# Call get_avg_data with the df's obtained from step1 and step 2 for test
avg_data_test <- get_avg_data(subject_activity_test,raw_data_test)

###### ----------------------------- Step 4 ------------------------------- ######
# Here we merge the two df's for training and test. These are now small df's - 
# we have selected only the required columns and also aggregated them. We order
# the output by subject id and activity name
tidy_data <- arrange(rbind(avg_data_train,avg_data_test),subject_id,activity_name)

###### ----------------------------- Step 5 ------------------------------- ######
# Finally, we export the df into a csv file
write.csv(tidy_data,file="tidy_data.csv",row.names=F)