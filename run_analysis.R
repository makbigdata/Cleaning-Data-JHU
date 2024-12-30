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

# Load and prepare the training dataset
train_data <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, ..selected_features]
setnames(train_data, colnames(train_data), selected_feature_names)
train_activity <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt"), 
                        col.names = "Activity")
train_subject <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt"), 
                       col.names = "SubjectNum")
train <- cbind(train_subject, train_activity, train_data)

# Load and prepare the testing dataset
test_data <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, ..selected_features]
setnames(test_data, colnames(test_data), selected_feature_names)
test_activity <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt"), 
                       col.names = "Activity")
test_subject <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt"), 
                      col.names = "SubjectNum")
test <- cbind(test_subject, test_activity, test_data)

# Combine the training and testing datasets
combined_data <- rbind(train, test)

# Replace activity labels with descriptive activity names
combined_data$Activity <- factor(combined_data$Activity, 
                                 levels = activity_labels$classLabel, 
                                 labels = activity_labels$activityName)

# Convert SubjectNum to a factor
combined_data$SubjectNum <- as.factor(combined_data$SubjectNum)

# Reshape data to create a tidy dataset
tidy_data <- melt(combined_data, id.vars = c("SubjectNum", "Activity"))
tidy_data <- dcast(tidy_data, SubjectNum + Activity ~ variable, mean)

# Write the tidy dataset to a file
fwrite(tidy_data, file = "tidyData.txt", quote = FALSE)
