# Smartphone Activity Study
A repository containing a single, tidy dataset stored as a csv file, a codebook, and an R analysis file which deal with cleaning up a set of data from a study on human activity recognition by the UCI Centre for Machine Learning and Intelligent Systems. 

This repo has been created as a requirement for the final week of the course "Getting and Cleaning Data" offered via Coursera by the John Hopkins Bloomberg School of Public Health.

The link to the full study is [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Description
The file `smartphone_analysis.R` is a set of R commands that will manipulate the data from the study to perform a number of steps including:
* combine the test data with the training data
* extract __mean__ and __standard deviation__ for the provided measurements from a large set of variables
* inserts the descriptive _activity names_ into the dataset for readability
* sets the _variable names_ properly to also make the dataset easier to read
* produces output as __.txt__ which contains the average of each of the _mean_ and _standard deviation_ variables for each _activity_ for each _subject_ (participant in the study). 

The output produced by the analysis file is contained in the file __avg\_by\_actsub\_tidy.txt__.

This file should be read into a data frame using `df <- read.table("avg_by_actsub_tidy.txt", header=TRUE)` or equivalent command as the file already contains column headings (names for the variables).

If you have any questions about this data set, please contact me at rick.henderson.blog@gmail.com with __"Smartphone Activity Study"__ in the subject line.

This repo was created as a requirement of the final week of the __Getting and Cleaning Data__ course on [Coursera](http://www.coursera.org).
