library(data.table)

#Read subject test data
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
#Set friendly column name
colnames(testSubject) <- "subject"

#Read test data
testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/y_test.txt")
#Set friendly column name
colnames(testY) <- "label"

#Read subject train data
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
#Set friendly column name
colnames(trainSubject) <- "subject"
#Read train data
trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/y_train.txt")
colnames(trainY) <- "label"

#Read features
features <- read.table("UCI HAR Dataset/features.txt")
colnames(features) <- c("id","feature")

#Read activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activityLabels) <- c("label","activity")

#merge test data
mergedTestData <- cbind(testSubject,testX,testY);
#merge train data
mergedTrainData <- cbind(trainSubject,trainX,trainY);
#merge test and train data
mergedTmpData <- rbind(mergedTestData, mergedTrainData)

#Identify mean and std cols
meanColumns <- grep(".*-mean.*\\(\\)|.*-std\\(\\)$",features$feature)
interestedColumns <- meanColumns + 1
interestedColumns <- c(1,interestedColumns, 563)

#Merge with activity and only mean cols
mergedData <- merge(mergedTmpData[,interestedColumns],activityLabels, by="label")

activityName <- gsub("[\\(\\)]","",features$feature)
activityName<- gsub("[,-]","_",activityName)

#Create data table
dt <- data.table(mergedData)
#data set with the average of each variable for each activity and each subject. 
tidyDataSet <- dt[, list(V1=mean(V1),V2=mean(V2), V3=mean(V3), V41=mean(V41),
                      V42=mean(V42), V43=mean(V43), V81=mean(V81),V82=mean(V83),
                      V121=mean(V121), V122=mean(V122), V123=mean(V123), V161=mean(V161), V162=mean(V162),
                      V163=mean(V163), V201=mean(V201), V202=mean(V202), V214=mean(V214), V215=mean(V215),
                      V227=mean(V227), V228=mean(V228), V240=mean(V240), V241=mean(V241), V253=mean(V253),
                      V254=mean(V254), V266=mean(V266), V267=mean(V267), V268=mean(V268), V294=mean(V294),
                      V295=mean(V295), V296=mean(V296), V345=mean(V345), V346=mean(V346), V347=mean(V347),
                      V373=mean(V373), V374=mean(V374), V375=mean(V375), V424=mean(V424), V425=mean(V425),
                      V426=mean(V426), V452=mean(V452), V453=mean(V453), V454=mean(V454), V503=mean(V503),
                      V504=mean(V504), V513=mean(V513), V516=mean(V516), V517=mean(V517), V526=mean(V526),
                      V529=mean(V529), V530=mean(V530), V539=mean(V539), V542=mean(V542), V543=mean(V543),
                      V552=mean(V552) ), by=c("activity","subject")]

#Friendly names
tNames <- names(tidyDataSet)[3:length(names(tidyDataSet))]
tNamesIndex <-  as.numeric(gsub("V","",tNames))
setnames(tidyDataSet, c("activity", "subject", activityName[tNamesIndex]));

#create data file
write.table(tidyDataSet, "tidy_DataSet.csv", sep=",", row.names = FALSE )
