# You should create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second,
#   independent tidy data set with the average of each variable for each activity and each subject.


getwd()
setwd("/Users/markushome/Desktop/UCI_HAR_Dataset")


# read test set
X_test <- read.table(file = "test/X_test.txt", sep ="", header = FALSE, na.strings ="", stringsAsFactors= F)
y_test <- read.table(file = "test/y_test.txt", sep ="", header = FALSE, na.strings ="", stringsAsFactors= F)
subject_test <- read.table(file = "test/subject_test.txt", sep ="", header = FALSE, na.strings ="", stringsAsFactors= F)


# read colnames
features <- read.table(file = "features.txt", sep ="", header = FALSE, na.strings ="", stringsAsFactors= F)

# assign colnames to test data
colnames(X_test) <- features$V2

# cbind in order to have the activity number for each row
test_temp <- cbind(X_test, y_test, subject_test)

# rename column of y_test from V1 to label in order to have unique column names
colnames(test_temp)[562] <- "activity.number"


# read training set
X_train <- read.table(file = "train/X_train.txt", sep ="", header = FALSE, na.strings ="", stringsAsFactors= F)
y_train <- read.table(file = "train/y_train.txt", sep ="", header = FALSE, na.strings ="", stringsAsFactors= F)
subject_train <- read.table(file = "train/subject_train.txt", sep ="", header = FALSE, na.strings ="", stringsAsFactors= F)


# assign colnames to training data
colnames(X_train) <- features$V2

# cbind in order to have the activity number for each row
train_temp <- cbind(X_train, y_train, subject_train)

# rename column of y_train from V1 to label in order to have unique column names
colnames(train_temp)[562] <- "activity.number"

# 1) Merges the training and the test sets to create one data set.
full <- rbind(test_temp,train_temp)

# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
mean <- full[ , grepl( "mean"  , names( full ) ) ]
std <- full[ , grepl( "std"  , names( full ) ) ]
activity <- full[ , grepl( "activity"  , names( full ) ) ]
participant <- full[ , grepl( "V1"  , names( full ) ) ]

# combine the extracted columns in one data set
data <- cbind(mean,std, activity, participant)

# read the activity labels for 3)
activity_labels <- read.table(file = "activity_labels.txt", sep ="", header = FALSE, na.strings ="", stringsAsFactors= F)
colnames(activity_labels)[1] <- "activity"
colnames(activity_labels)[2] <- "activity.name"

# 3) Uses descriptive activity names to name the activities in the data set
# left join full data on activity levels
data <- merge(x = data, y=activity_labels, by="activity", all.x = TRUE)

# 4) Appropriately labels the data set with descriptive variable names. 
colnames(data)
names(data) <- gsub("Acc", "Accelerator", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Jerk", "JerkSignal", names(data))
names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))

# From the data set in step 4, creates a second, independent tidy data set
#       with the average of each variable for each activity and each subject.
library(dplyr)

# remove the activity number
data <- data[ ,2:82]

# create tidy data set- group by participant (former "subject") and activity
tidy_temp <- data %>% group_by(participant, activity.name) %>% summarise_each(funs(mean))

# melt data to long format
library(reshape2)
tidy <- melt(tidy_temp, id = c("participant","activity.name"))

# export to txt file
write.table(tidy, file="tidy.txt", row.name=FALSE) 


