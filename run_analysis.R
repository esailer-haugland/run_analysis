library(dplyr)
# Download and unzip the file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              "Data_assignment_3", method="curl")
if (!file.exists("UCI HAR Dataset")) {
  unzip("Data_assignment_3")
}

# Assign Data to DF

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Merge training and test datasets

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject<- rbind(subject_train, subject_test)
Merged <- cbind(Subject, Y, X)

# Extract mean and sd 

Tidy_data <- select(Merged, subject, code, contains("mean"), contains("std"))

# Name activities

Tidy_data$code <- activities[Tidy_data$code, 2]

# Name the variables in the data

names(Tidy_data)[2] = "activity"
names(Tidy_data)<-gsub("Acc", "Accelerometer", names(Tidy_data))
names(Tidy_data)<-gsub("Gyro", "Gyroscope", names(Tidy_data))
names(Tidy_data)<-gsub("BodyBody", "Body", names(Tidy_data))
names(Tidy_data)<-gsub("Mag", "Magnitude", names(Tidy_data))
names(Tidy_data)<-gsub("^t", "Time", names(Tidy_data))
names(Tidy_data)<-gsub("^f", "Frequency", names(Tidy_data))
names(Tidy_data)<-gsub("tBody", "Time_Body", names(Tidy_data))
names(Tidy_data)<-gsub("-mean()", "Mean", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("-std()", "STD", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("-freq()", "Frequency", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data)<-gsub("angle", "Angle", names(Tidy_data))
names(Tidy_data)<-gsub("gravity", "Gravity", names(Tidy_data))

# Aggregate avg value for each vairable per subject into a data set

data_aggr <- group_by(Tidy_data, subject, activity) %>%
  summarise_all(list(mean))

write.table(data_aggr, "data_aggr.txt", row.names = FALSE)
