## -------------------------- get_subject_activity.R -------------------------- ##
## This function receives a parameter using which it determines whether to      ##
## read the training data or the test data.                                     ##
##                                                                              ##
## This function reads the activity labels, activity and subjects datasets and  ##
## combines them into a single df, without losing the order in which the data   ##
## was provided. This combined df is returned to the caller                     ##
## -------------------------- get_subject_activity.R -------------------------- ##

get_subject_activity <- function(file = "test")
{
  # read the activity labels (like standing, walking etc..) into a df
  activity_labels <- read.table(file="./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep=" ")
  # name the column of this df as 'activity_name'
  names(activity_labels) <- c("activity_id","activity_name")
    
  # read the activity file. this file is different for training and test. So we 
  # use the parameter 'file' passed to this function to determine the file path
  file_path <-  paste(c("./UCI HAR Dataset/",file,"/y_",file,".txt"),collapse="")
  activity<-read.table(file=file_path,header=FALSE,sep=" ")
  # name the column of this df as 'activity_id'
  names(activity) <- c("activity_id")
  
  # join the activity df and activity_labels df, to obtain the activity_with_labels 
  # df. inner_join is available in the dplyr package. Its important to note that
  # while performing the join we should to change the ordering of the activity df
  activity_with_labels <- inner_join(activity,activity_labels)
  
  # read the subjects file. this file is different for training and test. so we 
  # use the parameter 'file' passed to this function to determine the file path
  file_path <-  paste(c("./UCI HAR Dataset/",file,"/subject_",file,".txt"),collapse="")
  subjects<-read.table(file=file_path,header=FALSE,sep=" ")
  # name the column of this df as 'subject_id'
  names(subjects) <- c("subject_id")
    
  # finally cbind the subjects and activity_with_labels df and return to caller 
  data.frame(subjects,activity_with_labels)
    
}