#########################################################################
#   
#
#
#
##########################################################################

get_avg_data <- function(subject_activity,raw_data)
{
  
  ## COMBINE OUTPUT OF STEP 1 and STEP 2
  combined_data <- data.frame(subject_activity,raw_data)
 
  combined_data_avg <- aggregate(combined_data[,4:82],
                                 by = list(combined_data$subject_id,combined_data$activity_name),
                                 FUN= mean)

  
  names(combined_data_avg) <- c("subject_id","activity_name",paste("mean_",names(raw_data),sep="") )
  return(combined_data_avg)
  
}