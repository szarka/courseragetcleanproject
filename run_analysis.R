#
# Coursera Getting and Cleaning Data Project
# Rob Szarka 2014-08-24
#
# code to download and extract the data into an empty directory
# not needed, but included for reference
#
#if(!file.exists("./projectdata")) {dir.create("./projectdata")}
#setwd("projectdata")
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","projectdata.zip")
#unzip("projectdata.zip",overwrite=FALSE)

# ITEM 1: Merges the training and the test sets to create one data set.

#
# read the training data, including subject and action information
#
traindata <- read.table("UCI HAR Dataset/train/X_train.txt")
trainacts <- read.table("UCI HAR Dataset/train/y_train.txt")
trainsubs <- read.table("UCI HAR Dataset/train/subject_train.txt")
#
# combine into one data frame, with id vars on the left
#
traindf <- cbind(trainsubs, trainacts, traindata)
#
# read the test data, including subject and action information
#
testdata <- read.table("UCI HAR Dataset/test/X_test.txt")
testacts <- read.table("UCI HAR Dataset/test/y_test.txt")
testsubs <- read.table("UCI HAR Dataset/test/subject_test.txt")
#
# combine into one data frame, with id vars on the left
#
testdf <- cbind(testsubs, testacts, testdata)
#
# now combine training and test observations into one data frame
#
df <- rbind(traindf,testdf)

# ITEM 4: Appropriately labels the data set with descriptive variable names.

#
# read the observation variable names
#
features <- read.table("UCI HAR Dataset/features.txt")
#
# rename columns in the data frame
# cleaning up () and - to make variable names easier to work with
#
colnames <- c("Subject","Activity")
colnames <- append(colnames,as.character(features$V2))
colnames(df) <- gsub("-","_", sub("\\(\\)","",colnames) )

# ITEM 3: Uses descriptive activity names to name the activities in the data set

#
# create a factor from Activity with human-readable level names
#
df$Activity <- factor(df$Activity,labels=c("Walk","WalkUp","WalkDown","Sit","Stand","Lay"))

# ITEM 2: Extracts only the measurements on the mean and standard deviation for each measurement.

#
# now that everything is pretty, select out the variables of interest
# anything with "mean" or "std" in the variable name appears to be an average or standard deviation
#
selectdf <- subset(df, select = grep("Subject|Activity|mean|std",colnames) )

# ITEM 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#
# melt the data frame to make tall df with one variable per line
# shape new data frame with mean of each variable for each Subject+Activity combination
#
library(reshape2)
melted <- melt(selectdf,id=c("Subject","Activity"))
reshaped <- dcast(melted, Subject+Activity ~ variable, mean)
# write to disk
write.table(reshaped, file="reshaped.txt", row.name=FALSE)
