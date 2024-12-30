# Load required packages
library(data.table)
library(reshape2)

# Define paths and download data
path <- getwd()
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_url, file.path(path, "dataFiles.zip"))
unzip("dataFiles.zip")

# Load activity labels and features
activity_labels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"), 
                         col.names = c("classLabel", "activityName"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt"), 
                  col.names = c("index", "featureName"))
selected_features <- grep("(mean|std)\\(\\)", features$featureName)
selected_feature_names <- gsub("[()]", "", features[selected_features, featureName])


