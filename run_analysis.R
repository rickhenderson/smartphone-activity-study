# run_analysis.R
# Read in raw data and perform some cleaning
# to generate a tidy dataset of mean values grouped by activity and subject.

# Get and Clean Data
# Created by Rick Henderson
# Created on: March 15, 2016
# Completed on: March 26, 2016

# I read some tips and tricks from: 
# https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
# * There is no need to read in the data in the Inertial folders.

library(dplyr)

# Codebook: Read in the features file and store them in a data frame.
message("Reading in features.txt.")
features <- read.delim("ucidata/features.txt", header=FALSE, sep=" ")

# Codebook: Set the names of the columns for the feature table to featureCode and feature.
colnames(features) <- c("featureCode", "feature")

# Codebook: Read in the train data to merge.
# Warning: 69 MB of data to read in takes a bit of time.
message("Reading in training data...")
X_train <- read.table("ucidata/train/X_train.txt") # 7352 obs
y_train <- read.table("ucidata/train/y_train.txt") 
# y file only contains values 1 - 6, so they are activity IDs!

# Rename the variable for activity ID
names(y_train) <- c("activityID")

# Read in the subject_train.txt file to get subject IDs.
subject_train <- read.table("ucidata/train/subject_train.txt") 

# Rename the variable for the subject ID
names(subject_train) <- c("subjectID")

# Set the variable names for the test data from the feature list
# This completes step 4 of the project for the train data.
names(X_train) <- features$feature 

# Combine the Y_train with X_train as an extra column to add participant id as first column
traindataset <- cbind(y_train, X_train)

# Combine the training data with the subject data
traindataset <- cbind(subject_train, traindataset)

# Read all the testing data into a data frame and clean it up similar to the training data
message("Reading in test data...")
X_test <- read.table("ucidata/test/X_test.txt")
y_test <- read.table("ucidata/test/y_test.txt")

# Rename the variable for activity ID
# This completes step 4 of the project for the test data.
names(y_test) <- c("activityID")

# Read in the subject_test.txt file to get subject IDs.
subject_test <- read.table("ucidata/test/subject_test.txt") 

# Rename the variable for the subject ID
names(subject_test) <- c("subjectID")

# Set the variable names for the test data from the feature list
names(X_test) <- features$feature 

# Combine the y_test with X_test as an extra column to add participant id as first column
testdataset <- cbind(y_test, X_test)

# Combine the training data with the subject data
testdataset <- cbind(subject_test, testdataset)

# Extract just the values that are measurements of mean and standard deviation.
# Completes step 2 of the project.
testdataset <- testdataset[, grep("mean()|std()", names(testdataset) )]
traindataset <- traindataset[, grep("mean()|std()", names(traindataset) )]

# Combine the y_test with X_test as an extra column to add participant id as first column
testdataset <- cbind(y_test, testdataset)
traindataset <- cbind(y_train, traindataset)
# Combine the testing data with the subject data
testdataset <- cbind(subject_test, testdataset)
traindataset <- cbind(subject_train, traindataset)

message("Both testing and training datasets are now reduced and completed.")

# Combine both datasets **********************************************************************
message("Combining both training and test data to maintain variables.")
alldata <- rbind(testdataset, traindataset)

# Read in the activities list
message("Starting code cleanup / loading data...")
message("Reading activity_labels.txt")
activities <- read.delim("ucidata/activity_labels.txt", header=FALSE, sep=" ", stringsAsFactors = TRUE)

# Codebook: Set the column names for the activities data frame
colnames(activities) <- c("activityID", "activity")

# Merge the Activity Labels into the full dataset to replace the activityID codes.
# Code could be improved here to use some sort of loop or vector technique
alldata$activityID <- gsub("1", "WALKING", alldata$activityID)
alldata$activityID <- gsub("2", "WALKING_UPSTAIRS", alldata$activityID)
alldata$activityID <- gsub("3", "WALKING_DOWNSTAIRS", alldata$activityID)
alldata$activityID <- gsub("4", "SITTING", alldata$activityID)
alldata$activityID <- gsub("5", "STANDING", alldata$activityID)
alldata$activityID <- gsub("6", "LAYING", alldata$activityID)

# Convert the data frames to table_dataframes for simpler management.
activities <- tbl_df(activities)
features <- tbl_df(features)
alldata <- tbl_df(alldata)

# Step 5: Creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

# Group the data by subjectID and activityID
by_actsub <- group_by(alldata, subjectID, activityID)

# Calculate the average for *all* variables for each group.
avg_by_actsub <- summarise_each(by_actsub, funs(mean))

message("Analysis complete. Writing out table containing average measurements grouped by subject and activity.")
write.table(avg_by_actsub, "avg_by_actsub_tidy.txt", row.name=FALSE, sep=" ")

message("* The file avg_by_actsub_tidy.txt has been written into the current working directory. *")

# Remove un-needed data frames to make things cleaner
message("Removing unneeded data frames from memory...")
rm(X_train)
rm(y_train)
rm(X_test)
rm(y_test)
rm(subject_test)
rm(subject_train)
rm(testdataset, traindataset)
rm(features, activities, alldata, by_actsub)
message("DONE!")
