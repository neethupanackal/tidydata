#########################################################################
#   
#
#
#
##########################################################################

get_raw_data <- function(file = "test")
{
  ####### ----------- STEP 2 ----------- #######
  
  ## READ FEATURES.TXT INTO A DF AND EXTRACT THE SECOND COLUMN (DATA LABELS)
  raw_data_labels_df <-read.table(file="./UCI HAR Dataset/features.txt",header=FALSE,sep=" ") 
  raw_data_labels <- as.vector(raw_data_labels_df[,2])
  raw_mean_std_labels <- raw_data_labels[grep("mean|std",raw_data_labels) ]
  col_width <- 16
  valid_columns <- ifelse(c(raw_data_labels) %in% raw_mean_std_labels,col_width,-col_width)
  
  ## READ THE RAW DATA INTO A DF AND USE THE NAMES VECTOR TO NAME THE COLUMNS
  file_path <-  paste(c("./UCI HAR Dataset/",file,"/X_",file,".txt"),collapse="")
  raw_data<-read.fwf(file_path, widths = valid_columns)
  names(raw_data) <- raw_mean_std_labels
  return(raw_data)
  
}  
  