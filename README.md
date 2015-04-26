# tidydata

The purpose of this R script is to extract and clean up the data provided in [this link] (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The data provided in the zip file contains measurements from 30 volunteers, who wore a smartphone on their waist. The captured data contains 560 different measurements. Further, the data set is split randomly into two parts, with 70% of the volunteers generating training data and the remaining 30% generating the test data.

From the data provided, I produce a single merged dataset combining both the training and test datasets. I also extract only the measurements related to mean and standard deviation. I have also provided descriptive names for the activities and the measurements.

The output data is in txt format, which can be read into R using read.table

`tidy_data <- read.table(file="tidy_data.txt",header=TRUE)`