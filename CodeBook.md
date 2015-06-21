# Introduction

This code transforms data from the Human Activity Recognition Using Smartphones Dataset Version 1.0.
More information available in the README.txt present in download data.

## Getting a tydy dataseta:

0. Data are downloaded and unzipped
1. test and train data are first loaded usind `read.table` and then merged useing `rbind`
2. measurements on the mean and standard deviation are extracted: first the indices of features containg
the string ```"-mean()"``` or "-std()" are retrived, then a subset from merged data in step 2 is created accordingly.
3. descriptive activity names are sued to name the activities in the data set.
4. Variables are renamed accordingly to what they represent. Then a combined dataset is created that only include
the previously selected mean and standard deviation measurements.
5. An independent tidy data set with the average of each variable for each activity and each subject is created
and writted to file.

## Variables:

1. `X_train`, `y_train`, `X_test`, `y_test`, `subject_train`, `subject_test`, `features`, `activities` 
contain original data following the same naming sheme.
2. `X_data`, `y_data`, `subject_data`,  contain merged data from test and training
3. `X_data_mean_std` is a subset of X_data containg only measurements of mean and standard deviation
4. `complete_data` merge together `X_data_mean_std` with `y_data` and `subject_data`
5. `activity_subject_avg_data` contains the average of each variable for each activity and each subject.
6. Output is `activity_subject_avg_data.txt`
