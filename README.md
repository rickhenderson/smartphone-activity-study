# Smartphone Activity Study
This repository contains a single, tidy dataset stored as a .txt file, a codebook, and an R analysis file which deals with cleaning up a set of data from a study on human activity recognition by the UCI Centre for Machine Learning and Intelligent Systems. 

This repo has been created as a requirement for the final week of the course "Getting and Cleaning Data" offered via Coursera by the John Hopkins Bloomberg School of Public Health.

The link to the full study is [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Description
In brief, the researchers observed 30 participants (called subjects for the rest of this repo) while they performed 6 different activities. The subjects were wearing a smartphone to track their movements so that data could be retrieved from the phone's sensors to try and determine which of the six activities the subject had performed, just based on the sensor reading. The data from the sensors was then split into two groups: 70% of the subjects' data was placed in a training group for training the algorithms for detecting which activity was being performed, and the other 30% was placed in a test group to test the algortithms.

In this repo, the file `run_analysis.R` is a set of R commands that will manipulate the data from the study to perform a number of steps including:
* combine the test data with the training data
* sets the _variable names_ properly to also make the dataset easier to read
* combine the raw data from the sensors with data regarding the activity that was performed by each subject and a subject ID to identify each subject
* extract __mean__ and __standard deviation__ for the provided measurements from a large set of variables
* insert the descriptive _activity names_ into the dataset for readability
* produces output as a __.txt__ file which contains the average of each of the _mean_ and _standard deviation_ variables for each _activity_ for each _subject_ (participant in the study). 

The output produced by the analysis file is contained in the file __avg\_by\_actsub\_tidy.txt__.

In total, the resulting table will have 6 sets of mean and standard deviation measurements for each of the 30 subjects, as each subject performed all of the activities.

This file should be read into a data frame using `df <- read.table("avg_by_actsub_tidy.txt", header=TRUE)` or equivalent command as the file already contains column headings (names for the variables).

If you have any questions about this data set, please contact me at rick.henderson.blog@gmail.com with __"Smartphone Activity Study"__ in the subject line.

This repo was created as a requirement of the final week of the __Getting and Cleaning Data__ course on [Coursera](http://www.coursera.org).
