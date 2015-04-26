## ------------------------------ get_raw_data.R ------------------------------ ##
## This function receives a parameter using which it determines whether to      ##
## read the training data or the test data.                                     ##
##                                                                              ##
## This function reads the features dataset and uses it to name the columns of  ##
## the raw data dataset. Also, it filters for the column names containing mean  ##
## and std provided. This filtered df is returned to the caller                 ##
## ------------------------------ get_raw_data.R ------------------------------ ##

get_raw_data <- function(file = "test")
{
  # read the features dataset into a df
  raw_data_labels_df <- read.table(file="./UCI HAR Dataset/features.txt",header=FALSE,sep=" ") 
  # extract the 2nd column of this df, which contains the labels
  raw_data_labels <- as.vector(raw_data_labels_df[,2])
  # extract the labels which we are interested in, that is mean & std 
  raw_mean_std_labels <- raw_data_labels[grep("mean|std",raw_data_labels) ]
  
  # here we intend to use a feature of read.fwf (fixed width file), which will help 
  # us in reading the data from the required columns only. In read.fwf if we provided
  # negative column widths, those columns are skipped. So here the idea is to have 
  # positive column widths only for the columns we are interested in and negative
  # column widths for everything else. Column width is 16
  col_width <- 16
  # for all data labels, which have mean or std (present in raw_mean_std_labels) set
  # positive (col_width), else use negative (-col_width)
  valid_columns <- ifelse(c(raw_data_labels) %in% raw_mean_std_labels,col_width,-col_width)
  
  # set the file path using the input 'file' parameter as the paths are different for 
  # training and test datasets
  file_path <-  paste(c("./UCI HAR Dataset/",file,"/X_",file,".txt"),collapse="")
  # read the raw data using the valid_columns as width, which we calculated above
  raw_data<-read.fwf(file_path, widths = valid_columns)
  # name the columns using the raw_mean_std_labels vector
  names(raw_data) <- raw_mean_std_labels
  # return the filtered raw data
  return(raw_data)
  
}  
  