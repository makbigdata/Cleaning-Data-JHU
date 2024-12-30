Setup:

Downloads and extracts the dataset if it’s not already present in the working directory. Loads necessary libraries (data.table and reshape2) for efficient data manipulation.

Data Loading and Selection:

Reads activity labels and feature information. Identifies features related to mean and standard deviation measurements. Cleans up feature names for better readability.

Data Preparation:

Processes training and testing datasets by extracting relevant features, adding descriptive activity labels, and merging with subject information. Combines the training and testing datasets into a single dataset.

Transformation to Tidy Format:

Converts activity and subject identifiers into factors. Reshapes the data to a tidy format, where each row represents a unique combination of subject and activity with the average of each variable.
