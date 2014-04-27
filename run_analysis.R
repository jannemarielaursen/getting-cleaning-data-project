# Setting up R environment

setwd("/Users/jml/Documents/Dropbox/courseradatascience/getting-cleaning-data/getting-cleaning-data-project")
library(reshape2)


# Downloading the data if it does not already exist
if (!file.exists('UCI-HAR-Dataset.zip')) {
    file.url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    download.file(file.url, destfile='UCI-HAR-Dataset.zip', method="curl")
    date.downloaded <- date()
}

# Unzipping the file
unzip('UCI-HAR-Dataset.zip')

# Reading in the test and training datasets

subject.test <- read.table(file='./UCI HAR Dataset/test/subject_test.txt')
X.test <- read.table(file='./UCI HAR Dataset/test/X_test.txt')
y.test <- read.table(file='./UCI HAR Dataset/test/y_test.txt')

subject.train <- read.table(file='./UCI HAR Dataset/train/subject_train.txt')
X.train <- read.table(file='./UCI HAR Dataset/train/X_train.txt')
y.train <- read.table(file='./UCI HAR Dataset/train/y_train.txt')

# Reading in descriptive files for activities and features

activity.labels <- read.table(file='./UCI HAR Dataset/activity_labels.txt', 
                              as.is=TRUE)
feature.labels <- read.table(file='./UCI HAR Dataset/features.txt', as.is=TRUE)


# Substitute the activity coding with the activity name

activity <- as.factor(c(y.test[, 1], y.train[, 1]))
levels(activity) <- activity.labels[, 2]


# Finding indices of std and mean measurements in the feature list

mean.indeces <- grep('-mean()', feature.labels[, 2], fixed=TRUE)
std.indeces <- grep('-std()', feature.labels[, 2], fixed=TRUE)
mean.std.indices <- c(mean.indeces, std.indeces)


# Merging the test and training datasets extracting only mean/std measurements

subjects <- c(subject.test[, 1], subject.train[, 1])
features <- rbind(X.test[, mean.std.indices], X.train[, mean.std.indices])

merged <- cbind(subjects, activity, features)

# Setting the column names of the merged dataset
colnames(merged) <- c("Subject", "Activity", feature.labels[mean.std.indices, 2])


# Creating a dataframe with the average of each variable

melted.merged <- melt(merged, id.vars=c(1, 2))
avg.melted <- dcast(melted.merged, Subject + Activity ~ ..., mean)


# Writing out the tidy dataset (tab-separated)

write.table(avg.melted, file='./tidy_data.txt', sep="\t", row.names=FALSE, 
            col.names=TRUE)

