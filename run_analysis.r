
#load datasets, will need to change wd
testDataX <- read.table("./test/X_test.txt", stringsAsFactors = FALSE, header=FALSE)
trainDataX <- read.table("./train/X_train.txt", stringsAsFactors = FALSE, header=FALSE)
testDataY <- read.table("./test/Y_test.txt", stringsAsFactors = FALSE, header=FALSE, col.names = "ActivityNumber")
trainDataY <- read.table("./train/y_train.txt", stringsAsFactors = FALSE, header=FALSE, col.names = "ActivityNumber")
variableNames <- read.table("features.txt", stringsAsFactors = FALSE, header = FALSE)
activityLabels <- read.table("activity_labels.txt", stringsAsFactors = FALSE, header = FALSE, col.names = c("ActivityNumber", "ActivityName"))
subjectsTest <- read.table("./test/subject_test.txt", stringsAsFactors = FALSE, header=FALSE, col.names = "SubjectIdentifier")
subjectsTrain <- read.table("./train/subject_train.txt", stringsAsFactors = FALSE, header=FALSE, col.names = "SubjectIdentifier")

#combine measurements datasets
measurementData <- rbind(testDataX, trainDataX)

#attach column names to the dataset
colnames(measurementData) <- variableNames$V2

#combine activity identifiers from test and training data
activityIds <- rbind(testDataY, trainDataY)

#combine subject ids from test and training data
subjects <- rbind(subjectsTest, subjectsTrain)


#extract feature's with relavant measurements in their names 
#match on mean and stnd devs
#store colnumbers
meanColnames <- as.numeric(grep( "mean[^Freq]", colnames(measurementData)))
stdColnames <- as.numeric(grep( "std()", colnames(measurementData)))
colNumbersToUse <- c(meanColnames, stdColnames)


#extract only the relavant columns
combinedData <- measurementData[,colNumbersToUse]

#add activity identifier to measurements
combinedData <- cbind(activityIds, combinedData)

#add subject as the first column
combinedData <- cbind(subjects, combinedData)

#merge-in the activity Label -> changing ordering
combinedData <- merge(combinedData, activityLabels, by.x="ActivityNumber", by.y="ActivityNumber", sort = FALSE)

#update column names to more descriptive ones
colnames(combinedData) <- c("ActivityNumber",
                            "SubjectIdentifier",
                            "MeanBodyAccel-X",
                            "MeanBodyAccel-Y",
                            "MeanBodyAccel-Z",
                            "MeanGravityAccel-X",
                            "MeanGravityAccel-Y",
                            "MeanGravityAccel-Z",
                            "MeanBodyAccelJerk-X",
                            "MeanBodyAccelJerk-Y",
                            "MeanBodyAccelJerk-Z",
                            "MeanBodyGyro-X",
                            "MeanBodyGyro-Y",
                            "MeanBodyGyro-Z",
                            "MeanBodyGyroJerk-X",
                            "MeanBodyGyroJerk-Y",
                            "MeanBodyGyroJerk-Z",
                            "MeanBodyAccelMagnitude",
                            "MeanGravityAccelMagnitude",
                            "MeanBodyAccelJerkMagnitude",
                            "MeanBodyGyroMagnitude",
                            "MeanBodyGyroJerkMagnitude",
                            "MeanBodyAccel_F-X",
                            "MeanBodyAccel_F-Y",
                            "MeanBodyAccel_F-Z",
                            "MeanBodyAccelJerk_F-X",
                            "MeanBodyAccelJerk_F-Y",
                            "MeanBodyAccelJerk_F-Z",
                            "MeanBodyGyro_F-X",
                            "MeanBodyGyro_F-Y",
                            "MeanBodyGyro_F-Z",
                            "MeanBodyAccelMagnitude_F",
                            "MeanBodyBodyAccelJerkMagnitude_F",
                            "MeanBodyBodyGyroMagnitude_F",
                            "MeanBodyBodyGyroJerkMagnitude_F",
                            "StdBodyAccel-X",
                            "StdBodyAccel-Y",
                            "StdBodyAccel-Z",
                            "StdGravityAccel-X",
                            "StdGravityAccel-Y",
                            "StdGravityAccel-Z",
                            "StdBodyAccelJerk-X",
                            "StdBodyAccelJerk-Y",
                            "StdBodyAccelJerk-Z",
                            "StdBodyGyro-X",
                            "StdBodyGyro-Y",
                            "StdBodyGyro-Z",
                            "StdBodyGyroJerk-X",
                            "StdBodyGyroJerk-Y",
                            "StdBodyGyroJerk-Z",
                            "StdBodyAccelMagnitude",
                            "StdGravityAccelMagnitude",
                            "StdBodyAccelJerkMagnitude",
                            "StdBodyGyroMagnitude",
                            "StdBodyGyroJerkMagnitude",
                            "StdBodyAccel_F-X",
                            "StdBodyAccel_F-Y",
                            "StdBodyAccel_F-Z",
                            "StdBodyAccelJerk_F-X",
                            "StdBodyAccelJerk_F-Y",
                            "StdBodyAccelJerk_F-Z",
                            "StdBodyGyro_F-X",
                            "StdBodyGyro_F-Y",
                            "StdBodyGyro_F-Z",
                            "StdBodyAccelMagnitude_F",
                            "StdBodyBodyAccelJerkMagnitude_F",
                            "StdBodyBodyGyroMagnitude_F",
                            "StdBodyBodyGyroJerkMagnitude_F",
                            "ActivityName")

#final result = subject X activity X average
library("dplyr")
tidyData <- group_by(combinedData, SubjectIdentifier, ActivityNumber, ActivityName)
tidyData <- summarise_each(tidyData, funs(mean))

#write out data file to wd
write.table(tidyData, "TidyActivityData", quote = FALSE, row.names = FALSE)