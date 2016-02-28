# tidydata
Data cleaning script for tidying human activity recognition using smartphone sensors (UCI HAR dataset)

## Script description
run_analysis.R is a script designed to be executed in the main directory of the UNZIPPED UCI HAR dataset. It utilizes the data.table package for fast manipulation of larger datasets. The speed benefit for the given dataset is questionable but I prefer the grouping syntax so use it here.
dplyr package is also loaded for selecting specific columns as this is easier than in the data.table package.

Line references
9-11  activity labels are read in and converted to character class

13-17 measurement id's of interest are read in. Measures of means and standard deviations are selected by performing a Grep for mean/Mean and Std/std. Labels are extracted from the raw data in a separate vector to simplify naming the columns in the master data.table

20-24 training data set is read into id.train, activity.train and obs.train
26-28 measures of mean and standard deviation are selected from the training measurements.

30-32 training data set is merged into the data.train data table, with column names being applied

35-39 Testing data set is read into id.test, activity.test and obs.test
41-43 measures of mean and standard deviation are selected from the testing observations.

45-47 testing data set is merged into the data.test data table, with column names being applied

49-51 training and testing data tables are merged using the data.table rbind equivalent rbindlist

53-55 activity values are recoded as activity factors with descriptive labels

57-60 generate data.means data table containing means of all measurement columns, calculated by activity and id. setkeys generates primary and secondary key for the data table for sorting by activity first and by id second. 

61 write.table command to create data_tidy.txt file in the working directory

##Result
The file data_tidy.txt consists of 30 volunteers * 6 activities = 180 rows of 81 columns ("id", "activity", and 79 measurement features).
