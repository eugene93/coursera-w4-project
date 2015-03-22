This project is for Coursera class "Getting and Cleaning Data"

This run_analysis.R downloads a dataset from Galaxy S smartphones described
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

This codes merges the training and the test sets to create one data set. 
- downloads the dataset
- Creates a directory "UCI HAR Dataset" where the raw data is stored.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in previous step, creates a second, independent tidy data set with the average of each variable for each activity and each subject and writes a file "output.txt" in "UCI HAR Dataset" directory.

 
