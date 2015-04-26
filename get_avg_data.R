## ------------------------------ get_avg_data.R ------------------------------ ##
## This function receives a two df's - a subject_activity df and a raw_data df. ##
## We cbind the two data frames and aggregate it on subject id and activity name##
##                                                                              ##
## The aggregated df is returned to the caller                                  ##
## ------------------------------ get_avg_data.R ------------------------------ ##

get_avg_data <- function(subject_activity,raw_data)
{
  # cbind the input data frames
  combined_data <- data.frame(subject_activity,raw_data)
  # aggregate the combined_data on subject_id and activity_name, calculating the
  # mean of all other columns
  combined_data_avg <- aggregate(combined_data[,4:82],
                                 by = list(combined_data$subject_id,combined_data$activity_name),
                                 FUN= mean)
  # while aggregating, we lose the column names of the columns on which we are 
  # aggregating. So we reintroduce the column names
  names(combined_data_avg) <- c("subject_id","activity_name",paste("mean_",names(raw_data),sep="") )
  # return the aggregated df to the caller
  return(combined_data_avg)
}