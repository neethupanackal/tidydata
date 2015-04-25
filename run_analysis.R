
library("dplyr")
setwd("C:/Users/wilsonee/Documents/Coursera/Getting and Cleaning Data/tidydata")


source("get_subject_activity.R")
subject_activity_train <- get_subject_activity("train")
subject_activity_test <- get_subject_activity("test")


source("get_raw_data.R")
raw_data_train <- get_raw_data("train")
raw_data_test <- get_raw_data("test")


source("get_avg_data.R")
avg_data_train <- get_avg_data(subject_activity_train,raw_data_train)
avg_data_test <- get_avg_data(subject_activity_test,raw_data_test)


tidy_data <- arrange(rbind(avg_data_train,avg_data_test),subject_id,activity_name)
View(tidy_data)

write.csv(tidy_data,file="tidy_data.csv",row.names=F)
