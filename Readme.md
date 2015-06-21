# Getting and Cleaning Data Course Project


## Description

This is my course project for the Getting and Cleaning Data Coursera class taught by Jeff Leek.

1. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract it
2. Download the file `run_analysis.R`
3. Set the correct working directory using `setwd()` to the main folder of the extracted data
4. The final data will be written to the file `tidy.txt` in the working directory


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