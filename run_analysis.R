# Project code for Coursera class "Getting and Cleaning Data"
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr) ; library(tidyr)
setwd("./CleaningData")
url1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dest1<-"samsung_galaxys.zip"
download.file(url1,dest1)
unzip(dest1)
setwd("./UCI HAR Dataset") # this is the destination of the unzipped files


#####Merges the training and the test sets to create one data set.
# Reading training dataset
Xtrain <- read.table("./train/X_train.txt", header=FALSE, sep="")
Ytrain <- read.table("./train/y_train.txt", header=FALSE, sep="")
Strain <- read.table("./train/subject_train.txt", header=FALSE, sep="")

# Reading test dataset
Xtest <- read.table("./test/X_test.txt", header=FALSE, sep="")
Ytest <- read.table("./test/y_test.txt", header=FALSE, sep="")
Stest <- read.table("./test/subject_test.txt", header=FALSE, sep="")

#combine columns to form one training table and test table.
train<-cbind(Xtrain,Ytrain,Strain)
test<-cbind(Xtest,Ytest,Stest)
testtrain<- rbind (train,test) # row combine to create one 

# remove variables no longer are needed
rm(train,Xtrain,Ytrain,Strain,test, Xtest,Ytest,Stest)

####Appropriately labels the data set with descriptive variable names. 
#Label data (remove special chars and apply to column names)

features <- read.table("./features.txt", sep="",col.names = c("id", "name"))
# delete odd characters
column_name<-gsub("-", ".", gsub("[\\(\\)]", "", as.character(features$name)))
column_name <- c(as.vector(column_name), "subject", "activity")
colnames(testtrain) <- column_name
#View(testtrain)

###Extracts only the measurements on the mean and standard deviation for each measurement. 

# feature names with std or mean, but not meanfreq
#grep("mean|std|subject|activity",column_name) 
#grep("meanFreq",column_name)
select_column_name<-grepl("mean|std|subject|activity",column_name) &!  grepl("meanFreq",column_name)
select_testtrain<-testtrain[,select_column_name]
#View(select_testtrain)
rm(testtrain)
###Uses descriptive activity names to name the activities in the data set
activity_label <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)
select_testtrain_tbl<-tbl_df(select_testtrain)
rm(select_testtrain)
# mutate "activity" column to name of activity
select_testtrain_tbl <- mutate(select_testtrain_tbl, activity = activity_label[activity, 2])
#View(select_testtrain_tbl)
#From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.
grp_act_sub<-group_by(select_testtrain_tbl,activity, subject)
rm(select_testtrain_tbl)
tidy_mean_act_subView<-summarise_each(grp_act_sub, funs(mean))
#View(tidy_mean_act_subView )
write.table(tidy_mean_act_subView, "./output.txt", row.name=FALSE)
