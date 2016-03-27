# Smartphone Activity Study
A repository containing a single, tidy dataset stored as a csv file, a codebook, and an R analysis file which deal with cleaning up a set of data from a study on human activity recognition by the UCI Centre for Machine Learning and Intelligent Systems. 

This repo has been created as a requirement for the final week of the course "Getting and Cleaning Data" offered via Coursera by the John Hopkins Bloomberg School of Public Health.

The link to the full study is [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Description
The file `smartphone_analysis.R` is a set of R commands that will manipulate the data from the study to perform a number of steps including:
* combine the test data with the training data
* calculate __mean__ and __standard deviation__ for the provided measurements
* inserts the descriptive _activity names_ into the dataset for readability
* sets the _variable names_ properly to also make the dataset easier to read

A second data set is also provided which contains the average of each _variable_ for each _activity_ for each _participant_.
The file `participant_averages.R` performs that analysis.

If you have any questions about this data set, please contact me at rick.henderson.blog@gmail.com with __"Smartphone Activity Study"__ in the subject line.

