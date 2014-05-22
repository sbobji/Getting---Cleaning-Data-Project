Run_Analysis.R

Below steps were followed to complete this project:

1) Unzip the file into the R's working directory. check if the files are extracted into a folder "UCI HAR Dataset"
2) R code was written and saved as "Run_Analysis.R"
3) The following variables are used in the script.

testX, testY, testSubject, trainX, trainY, trainSubject - representing the X, Y and subject for test and train

mergedTestData, mergedTrainData - representing the merged values of test and train
4)Data Transformations -All the test and train data are merged and mergedData is created with activity names (except for the features) and only the features that have mean and standard deviation .

A data table dt is created from the mergedData to be used later to get the mean of the various measurements based on activity and subject.

The activity names are later applied and written to file.

6) Run the r source file by using the source command.
It will scan through all the test and train files and merge them to one and create a file tidyData.txt file which is comma delimited and has the activity, subject and the average of various measurements.
7) Final consoidated table tidy_DataSet.txt is written 