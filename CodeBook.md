---
title: "Smartphone Study Codebook"
author: "Rick Henderson"
date: "2016/03/27"
output:
  html_document:
    keep_md: yes
---

## Project Description
This project deals with tidying up a dataset and simplifying some tables to produce a set of data useful for analysis. It also entails creating a __tidy__ dataset containing average values calculated by __subject__ and __activity__. The data comes from a study of human movement recorded by sensors from a smartphone.

In this document, __subject__ means a subject that took part in the original study, or the identifying number used to identify a participant, and __activity__ refers to an activity performed by the subject during the study, or a descriptive word or value used in the dataset to represent the activity.

##Study Design and Data Processing

###Collection of the raw data
The raw data for this project was collected by researchers at University of California Irving (UCI) Center for Machine Learning and Intelligent Systems.

A full description is available at the site where the data was obtained can be found here:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The raw data can be downloaded as a zip file from here:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

This file should be unzipped into a subfolder called _ucidata_ inside the folder where the analysis will take place (the folder where the analysis file gets downloaded to and where it will be executed from).

###Notes on the original (raw) data 
The site listed above explains the study in detail and the README file provided in the data set explains how the original, raw data was collected as well as how other variables not used in this project were calculated.

##Creating the Tidy Datafile

###Guide to create the tidy data file
Follow these steps to create the tidy data file:

1. Download the [run_analysis.R](run_analysis.R) file from this repository.
2. Download the raw data.
3. Unzip the raw data into a folder called `ucidata`.
4. Make sure you install the `dplyr` package by using the `install.packages("dplyr")` command.
5. Run all the commands inside the analysis file.

This should generate the required tidy data set as a .txt file inside the same folder where you ran the analysis commands from.

This data is the long form as mentioned in the rubric as either long or wide form is acceptable.

###Cleaning of the data
Here is a list of each of the steps performed by the analysis file.

* Load the `dplyr` library to make working with tables easier.
* Read in the features file and store them in a data frame.
* Set the variables names for the features file properly.
* Read in the training data.
* Rename the variable for the activity ID in the y\_train file since it contains the data for which activity was performed for each row of the X\_train data set.
* Read in the subject\_train file to store in a data frame as it contains the list of subject IDs to match the X\_train data set.
* Rename the variable in the subject\_train table as __subjectID__.
* Set all the variable names in the X\_train data frame using the variables listed in the features data frame.
* Combine the Y\_train with X\_train as an extra column to add __subjectID__ as first column using `cbind`.
* Combine the training data with the subject data using `cbind`.
* Read all the testing data into a data frame and clean it up similar to the training data.
* Rename the variable for the activity ID as __activityID__ although later it will be readable labels, not ID numbers.
* Read the __subject\_test.txt__ file into a dataframe to get subject IDs.
* Rename the variable for the subject ID as __subjectID__.
* Set the variable names for the test data from the feature list.
* Combine the y\_test with X\_test as an extra column to add __subjectID__ as first column using `cbind`.
* Combine the training data with the subject data using `cbind`.
* Extract just the values that are measurements of mean and standard deviation.
  * This completes step 2 of the project and was done by using the `grep` command to isolate variables that contained 'mean()' as well as 'std()' as specified in the instructions. The code used was:

  ```R
  testdataset <- testdataset[, grep("mean()|std()", names(testdataset) )]
  traindataset <- traindataset[, grep("mean()|std()", names(traindataset) )]
   ```

* Combine the y\_test with X\_test as an extra column to add __subjectID__ as first column.
* Combine the testing data with the subject data.
* Combine both datasets using `rbind` as it is really just a matter of appending the rows of both tables together. 
* Read in the activities list which contains readable labels for each activity ID.
* Set the column names for the activities data frame.
* Merge the Activity Labels into the full dataset to replace the __activityID__ codes.
* Group the data by __subjectID__ and __activityID__.
* Calculate the mean for *all* variables for each group using `summarise_each`.

```R
avg_by_actsub <- summarise_each(by_actsub, funs(mean))
```

* Write out the data as a table using `write.table`.

```R
write.table(avg_by_actsub, "avg_by_actsub_tidy.txt", row.name=FALSE, sep=" ")
```

* Remove un-needed data frames to make things cleaner.

##Description of the variables in the _avg\_by\_actsub\_tidy.txt_ file
* Dimensions: 180 rows x 81 columns

```R
dim(avg_by_actsub_tidy)
[1] 180  81

> head(avg_by_actsub_tidy)[,1:7]
  subjectID         activityID tBodyAcc.mean...X tBodyAcc.mean...Y tBodyAcc.mean...Z tBodyAcc.std...X tBodyAcc.std...Y
1         1             LAYING         0.2215982      -0.040513953        -0.1132036      -0.92805647     -0.836827406
2         1            SITTING         0.2612376      -0.001308288        -0.1045442      -0.97722901     -0.922618642
3         1           STANDING         0.2789176      -0.016137590        -0.1106018      -0.99575990     -0.973190056
4         1            WALKING         0.2773308      -0.017383819        -0.1111481      -0.28374026      0.114461337
5         1 WALKING_DOWNSTAIRS         0.2891883      -0.009918505        -0.1075662       0.03003534     -0.031935943
6         1   WALKING_UPSTAIRS         0.2554617      -0.023953149        -0.0973020      -0.35470803     -0.002320265
```
* Variables in the data set:
  * __subjectID__: A value between 1 and 30 indicating the subject who performed the activity in the original study. Units: none.
  * __activityID__: A descriptive word describing the activity that the subject peformed. Units: none. Possible values were: 
    * WALKING\_UPSTAIRS
    * WALKING\_DOWNSTAIRS
    * WALKING
    * STANDING
    * SITTING
    * LAYING

The remaining __79__ variables were extracted from the original list of _561_ variables by using the `grep` command to find only those variables that contained the strings 'mean()' and 'std()'. This provided only the variables that calculated a _mean_ and _standard deviation_ for the data collected during the study. This __purposefully excluded__ variables such as _fBodyAccJerk-meanFreq()-Y_ and _angle(X,gravityMean)_ which were included in the original data set, but were not of interest for this project.

The values in the original dataset had been normalized by the researchers.

The other variables and their descriptions can be found in the README for the original data set by following the link provided to the UCI study.

##Sources
* [Human Activity Recognition Using Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) - The original study at the UCI Center for Machine Learning and Intelligent Systems.
* [Getting and Cleaning The Assignment](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/) - A blog post by ThoughtfulBloke.
* [Using Apply, Sapply, and Lapply](http://www.r-bloggers.com/using-apply-sapply-lapply-in-r/) - An article on [R-Bloggers.com](http://www.r-bloggers.com).

