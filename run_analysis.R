library(plyr)

## 0.
## download and unzip data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,
              method='curl',
              destfile='getdata-projectfiles-UCI HAR_Dataset.zip')
unzip('getdata-projectfiles-UCI HAR_Dataset.zip')
setwd("UCI HAR Dataset")

## 1:
## Merges the training and the test sets
## to create one data set.

## read data
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_test <- read.table("test/subject_test.txt")
subject_train <- read.table("train/subject_train.txt")

## bind test and train togheter
X_data <- rbind(X_test, X_train)
y_data <- rbind(y_test, y_train)
subject_data <- rbind(subject_test, subject_train)

## 2:
## Extracts only the measurements on the mean and
## standard deviation for each measurement.

## retrive places in features where "-mean()" or "-std()" is present
features <- read.table("features.txt")
mean_std_indeces <- grep("-(mean|std)\\(\\)", features[, 2])

## subset X_data
X_data_mean_std <- X_data[, mean_std_indeces]

## 3:
## Uses descriptive activity names
## to name the activities in the data set

## read activities
## (corrispondence btw activity name and numeric identifier)
activities <- read.table("activity_labels.txt")

## give descriptive names
y_data[, 1] <- activities[y_data[, 1], 2]

## 4:
## Appropriately labels the data set
## with descriptive variable names.

## read features and then
## rename X_data variable by features
old_names <- as.character(names(X_data))
new_names <- as.character(features$V2)
setnames(X_data, old_names, new_names)

## some more column renaming
names(subject_data) <- "subject_id"
names(y_data)  <- "activity"
complete_data <- cbind(subject_data, y_data, X_data_mean_std)

## 5:
## creates a second, independent tidy data set
## with the average of each variable
## for each activity and each subject.

activity_subject_avg_data <- ddply(complete_data, .(subject_id, activity),
                                   function(x) colMeans(x[, 3:68]))

## Write to file
write.table(activity_subject_avg_data, "activity_subject_avg_data.txt", row.name=FALSE)
