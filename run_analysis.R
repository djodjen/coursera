#######
#created by: Mariya Atanasova
#2/21/2015
###

library(dplyr)

setwd("C:/coursera/CleaningData")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "CleaningDataAssignment.zip")

##Manual step: unzipping the CleaningDataAssignment.zip file into the current directory

featuresName <- "features.txt"

### reading the features names
features <- read.table(featuresName, stringsAsFactors=FALSE)
featuresNames <- features$V2

## reading and labeling the training data
trainName <- "train/X_train.txt"
trainData <- read.table(trainName, stringsAsFactors=FALSE)
#names(trainData) <- featuresNames

## reading and labeling the test data
testName <- "test/X_test.txt"
testData <- read.table(testName, stringsAsFactors=FALSE)
#names(testData) <- featuresNames

##merging the train and test data
mergedData <- rbind(trainData, testData)
head(mergedData)

### Extracts only the measurements on the mean and standard deviation for each measurement. 
meanNames <- grep("mean", featuresNames)
stdNames <- grep("std", featuresNames)
meanAndStdNames <- featuresNames[c(meanNames, stdNames)]

###making the names clean by removing _, -, () , and white space)
cleanMeanAndStdNames <- gsub("_", "", meanAndStdNames);
cleanMeanAndStdNames <- gsub("-", "", cleanMeanAndStdNames);
cleanMeanAndStdNames <- gsub("\\(", "", cleanMeanAndStdNames);
cleanMeanAndStdNames <- gsub("\\)", "", cleanMeanAndStdNames);


###creating the clean dataset
meanAndSDTsubset <- select(mergedData, meanNames, stdNames)
names(meanAndSDTsubset) <- cleanMeanAndStdNames
head(meanAndSDTsubset)

###saving the dataset:
write.table(meanAndSDTsubset, file="TidyDataset.txt", row.names=FALSE)

