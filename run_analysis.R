install.packages("plyr")
install.packages("dplyr",dependencies=TRUE);
library("dplyr")

setwd("C:/Users/wilsonee/Documents/Coursera/Getting and Cleaning Data/Project")

####### ----------- STEP 1 ----------- #######

## DATA FRAME OF ACTIVITY LABELS (NAMES)
activity_labels<-read.table(file="./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep=" ")
names(activity_labels) <- c("activity_id","activity_name")
View(activity_labels)

## DATA FRAME OF ACTIVITIES 
activity<-read.table(file="./UCI HAR Dataset/test/y_test.txt",header=FALSE,sep=" ")
names(activity) <- c("activity_id")
View(activity)

## JOIN THE ACTIVITY WITH ITS LABEL (THE ORDER IS IMPORTANT HERE)
activity_with_labels <- inner_join(activity,activity_labels)

## DATA FRAME OF SUBJECTS
subjects<-read.table(file="./UCI HAR Dataset/test/subject_test.txt",header=FALSE,sep=" ")
names(subjects) <- c("subject_id")
View(subjects)

## COMBINE 2 DATAFRAME SUBJECT AND ACTIVITY
subject_activity <- data.frame(subjects,activity_with_labels)
View(subject_activity)

####### ----------- STEP 2 ----------- #######

## READ FEATURES.TXT INTO A DF AND EXTRACT THE SECOND COLUMN (DATA LABELS)
raw_data_labels_df <-read.table(file="./UCI HAR Dataset/features.txt",header=FALSE,sep=" ") 
raw_data_labels <- as.vector(raw_data_labels_df[,2])
raw_mean_std_labels <- raw_data_labels[grep("mean|std",raw_data_labels) ]
col_width <- 16
valid_columns <- ifelse(c(raw_data_labels) %in% raw_mean_std_labels,col_width,-col_width)

## READ THE RAW DATA INTO A DF AND USE THE NAMES VECTOR TO NAME THE COLUMNS
raw_data<-read.fwf("./UCI HAR Dataset/test/X_test.txt", widths = valid_columns)
names(raw_data) <- raw_mean_std_labels
View(raw_data)


####### ----------- STEP 3 ----------- #######

## COMBINE OUTPUT OF STEP 1 and STEP 2

tidy_data_test <- data.frame(subject_activity,raw_data)
View(tidy_data_test)
rm(raw_data)
rm(subject_activity)
tidy_data_avg_test<-arrange(aggregate(tidy_data_test[,4:82],
                      by=list(tidy_data_test$subject_id,tidy_data_test$activity_name),
                      FUN=mean),Group.1,Group.2)
names(tidy_data_avg_test)[1]<-"subject_id"
names(tidy_data_avg_test)[2]<-"activity_name"


View(tidy_data_avg_test)






