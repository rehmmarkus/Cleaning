

# Codebook

## Introduction

This project is part of the Getting and Cleaning Data Course Project.
The project that generated the data:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The explicit data set:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Variables

 $ participant  : int  1 1 1 1 1 1 2 2 2 2 ...
 the number of a participant in the study
 
 $ activity.name: chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
 an activity the participant was performing during the study
 
 $ variable     : Factor w/ 79 levels "timeBodyAccelerator-mean()-X",..: 1 1 1 1 1 1 1 1 1 1 ...
 the measured mean/std of a measured variable
 
 $ value        : num  0.222 0.261 0.279 0.277 0.289 ...
 the mean of all measurements during the study of a particular participant during a particular activity 
 

## The script run_analysis.R

Below, I describe how I clean the data

1. Read the files `X_test.txt`, `Y_test.txt` and `subject_test.txt` in the folder `test
2. Read the files `X_train.txt`, `Y_train.txt` and `subject_train.txt` in the folder `train`
3. Merge the columns of both test and training data using `cbind`
4. Read and assign column names from the file `features.txt`
5. Merge the two data sets to the new data set`full`
6. Extract all columns containing means, standard deviations, activity data and participant data
7. Add clean names to the columns
8. melt the data to the long format (preprocessing using `dplyr`, melt using `reshape2`)
9. export the tidy data to the text file `tidy.txt`


