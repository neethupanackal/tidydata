#########################################################################
#   
#
#
#
##########################################################################


get_subject_activity <- function(file = "test")
{

  ## DATA FRAME OF ACTIVITY LABELS (NAMES)
  activity_labels<-read.table(file="./UCI HAR Dataset/activity_labels.txt",header=FALSE,sep=" ")
  names(activity_labels) <- c("activity_id","activity_name")
    
  ## DATA FRAME OF ACTIVITIES 
  file_path <-  paste(c("./UCI HAR Dataset/",file,"/y_",file,".txt"),collapse="")
  activity<-read.table(file=file_path,header=FALSE,sep=" ")
  names(activity) <- c("activity_id")
  
  
  ## JOIN THE ACTIVITY WITH ITS LABEL (THE ORDER IS IMPORTANT HERE)
  activity_with_labels <- inner_join(activity,activity_labels)
  
  ## DATA FRAME OF SUBJECTS
  file_path <-  paste(c("./UCI HAR Dataset/",file,"/subject_",file,".txt"),collapse="")
  subjects<-read.table(file=file_path,header=FALSE,sep=" ")
  names(subjects) <- c("subject_id")
    
  ## COMBINE 2 DATAFRAME SUBJECT AND ACTIVITY
  data.frame(subjects,activity_with_labels)
    
}