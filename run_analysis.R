#!/usr/bin/env Rscript
                                                                              
library(dplyr)

# Read and cleanup the features data 
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, sep="")
features2 <- gsub("-", "_", features[,2])
features2 <- gsub(",", "_", features2)
features2 <- gsub("\\(", "", features2)
features2 <- gsub(")", "", features2)

# Read the activity labels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE, sep="")

# Read the TEST and TRAINING subject sets
# rbind() them into a single data frame
# Add the "Subject" column heading
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="")
subject_all <- rbind(subject_test, subject_train)
colnames(subject_all) <- c("Subject")


# Read the TEST and TRAINING X data sets (Measurements)
# rbind() them into a single data frame
# Add the column headings from the cleaned up features data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="") 
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="") 
x_all <- rbind(x_test, x_train)
colnames(x_all) <- features2


# Read the TEST and TRAINING y data sets (Activities)
# rbind() them into a single data frame
# Replace the numeric values with readable labels from the activity labels
# Assign "Activity" as the column heading
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="") 
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="") 
y_all <- rbind(y_test, y_train)
y_all[y_all==1]<-"WALKING"
y_all[y_all==2]<-"WALKING_UPSTAIRS"
y_all[y_all==3]<-"WALKING_DOWNSTAIRS"
y_all[y_all==4]<-"SITTING"
y_all[y_all==5]<-"STANDING"
y_all[y_all==6]<-"LAYING"
colnames(y_all) <- "Activity"

# cbind() the subject, y, and x data sets into a single data set
all_data <- cbind(subject_all, y_all, x_all)

# Identify the required mean and standard deviation columns
reqCols <- grep("mean|std", colnames(all_data))

# Create a tidy data set containing the subject, activity, and required data
all_data_tidy <- all_data[,c(1,2,reqCols)]

# Turn the tidy data set into a data table for dplyr manipulation
allDataTidy.tbl <- tbl_df(all_data_tidy)

# Group data by subject and activity and summarize each measurement by
# subject and activity
summaryData <- allDataTidy.tbl %>% group_by(Subject, Activity) %>% summarize_all(funs(mean))
summaryData
