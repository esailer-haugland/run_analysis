# run_analysis
**Peer-graded Assignment: Getting and Cleaning Data**

This repository is Ethan Sailer-Haugland's submission for the Getting and Cleaning Data course project for coursera. The following script has instructions on performing the 
analysis on the Human Activity recognition dataset.

**Dataset**

[Human Activity Recognition dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

**Files**

  +```Code_book.md```: a code book desribing the variables, data and transformations made on the dataset
  
  +```run_analysis.r```: performs the data preparation, then runs the 5 steps described in the course project 
    
    +Merges the training and the test sets to create one data set
    
    +Extracts only the measurements ont he mean and sd for each measurement
    
    +Uses descriptive activity names to name the activities in the data set

    +Appropriately labels the data set with descriptve variable names
    
    + From the data in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

  +```data_aggr.txt```: the exported final data 
