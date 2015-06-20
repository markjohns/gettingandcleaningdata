
##run_analysis for the Getting and Cleaning Data Project

library(plyr)
library(reshape2)
library(tidyr)
library(dplyr)
## Step 1 Merges the training and the test sets to create one data set 
##Step 1 read data in working directory
## read features.txt
features_mat <- read.table("./features.txt", sep ='')
features_mat
print("features.txt dimentions")
dim(features_mat)
class(features_mat)
typeof(features_mat)
names(features_mat)

## read activity labels.txt
activity_labels_mat <- read.table("./activity_labels.txt", sep ='')
activity_labels_mat
print("activity_labels.txt dimentions")
dim(activity_labels_mat)
class(activity_labels_mat)
typeof(activity_labels_mat)
names(activity_labels_mat)

## read train/X_train.txt
X_train_mat <- read.table("./train/X_train.txt", sep ='')
head(X_train_mat)
print("train/X_train.txt dimentions")
dim(X_train_mat)
class(X_train_mat)
typeof(X_train_mat)
names(X_train_mat)

## read train/y_train.txt
y_train_mat <- read.table("./train/y_train.txt", sep ='')
head(y_train_mat)
print("train/y_train.txt dimentions")
dim(y_train_mat)
class(y_train_mat)
typeof(y_train_mat)
names(y_train_mat)

## read train subject_train.txt
subject_train_vec <- read.table("./train/subject_train.txt", sep ='')
head(subject_train_vec)
print("train/subject_train.txt dimentions")
dim(subject_train_vec)
class(subject_train_vec)
typeof(subject_train_vec)
names(subject_train_vec)

## read test/X_test.txt
X_test_mat <- read.table("./test/X_test.txt", sep ='')
head(X_test_mat)
print("train/X_train.txt dimentions")
dim(X_test_mat)
class(X_test_mat)
typeof(X_test_mat)
names(X_test_mat)

## read train/y_train.txt
y_test_mat <- read.table("./test/y_test.txt", sep ='')
head(y_test_mat)
print("test/y_test.txt dimentions")
dim(y_test_mat)
class(y_test_mat)
typeof(y_test_mat)
names(y_test_mat)

## read test subject_test.txt
subject_test_vec <- read.table("./test/subject_test.txt", sep ='')
head(subject_test_vec)
print("test/subject_test.txt dimentions")
dim(subject_test_vec)
class(subject_test_vec)
typeof(subject_test_vec)
names(subject_test_vec)

##Add the activity and subject numbers for train
X_train_with_subject_and_activity_mat <- cbind(X_train_mat, subject_train_vec, y_train_mat)
head(X_train_with_subject_and_activity_mat)
dim(X_train_with_subject_and_activity_mat)
##last line of file
X_train_with_subject_and_activity_mat[7352,]

##Add  the activity and subject numbers for test
X_test_with_subject_and_activity_mat <- cbind(X_test_mat, subject_test_vec, y_test_mat)
head(X_test_with_subject_and_activity_mat)
dim(X_test_with_subject_and_activity_mat)
##first line of file
X_test_with_subject_and_activity_mat[1,]

##Put the measurements, the activity and subject numbers for train and underneath it the 
##the measurements, the activity and subject numbers for test
##Matrix with all features, subjects and activities for both test ans train
X_test_and_train_with_subject_and_activity_mat <- rbind(X_train_with_subject_and_activity_mat, X_test_with_subject_and_activity_mat)
head(X_test_and_train_with_subject_and_activity_mat)
dim(X_test_and_train_with_subject_and_activity_mat)
##compare with last and first line of combined files
X_test_and_train_with_subject_and_activity_mat[7352:7355,]
class(X_test_and_train_with_subject_and_activity_mat)


##Step2	Extracts only the measurements on the mean and standard deviation for each measurement.
##The information is in features.info, the items with mean() and std() indicate the mean or std
## check match with mean()
## here -1 indicates no match
mean_feature_measurements_index <- regexpr(".*-mean\\(.*", features_mat[,2])
mean_feature_measurements_index
## check match with sd()
## here -1 indicates no match
std_feature_measurements_index <- regexpr(".*-std\\(.*", features_mat[,2])
std_feature_measurements_index

## create an index that includes the match with mean and std
mean_condition <- mean_feature_measurements_index > -1
mean_condition
std_condition <- std_feature_measurements_index > -1
std_condition
mean_and_std_condition <- (mean_condition) | (std_condition)
mean_and_std_condition

##select column number in features_mat first column
mean_and_std_column_select_in_features_mat_index <- features_mat[mean_and_std_condition,1]
mean_and_std_column_select_in_features_mat_index

##subset the X_test_and_train_with_subject_and_activity_mat with mean_and_std_column_select_in_features_mat_index 
## and leave the sbject and activity columns at the end 562 and 563
## add 562 and 563 to mean_and_std_column_select_in_features_mat_index
##Index to select the mean and std of features and subjects and activities column
subject_and_activities_column_select_index <- c(562,563)
subject_and_activities_column_select_index
mean_and_std_subjects_and_activities_column_select_in_features_mat_index <- c(mean_and_std_column_select_in_features_mat_index,subject_and_activities_column_select_index)
mean_and_std_subjects_and_activities_column_select_in_features_mat_index

##Subset the Matrix with all features, subjects and activities for both test and train
##(X_test_and_train_with_subject_and_activity_mat) with the Index to select the mean and std 
##of features and subjects and activities column
##(mean_and_std_subjects_and_activities_column_select_in_features_mat_index)
##Matrix with means and std of features, subjects and activities for both test and train
X_means_and_std_test_and_train_with_subject_and_activity_mat <- X_test_and_train_with_subject_and_activity_mat[,mean_and_std_subjects_and_activities_column_select_in_features_mat_index]
X_means_and_std_test_and_train_with_subject_and_activity_mat
dim(X_means_and_std_test_and_train_with_subject_and_activity_mat)
##the activity column is now the last column, 68
ncol(X_means_and_std_test_and_train_with_subject_and_activity_mat)
names(X_means_and_std_test_and_train_with_subject_and_activity_mat)

##3	Uses descriptive activity names to name the activities in the data set

library(dplyr)
## add column with activity names
X_means_and_std_test_and_train_with_subject_and_activity_names_mat <- mutate(X_means_and_std_test_and_train_with_subject_and_activity_mat, V1.2_1 = activity_labels_mat[V1.2,2])
head(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)
tail(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)
dim(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)
## remove column with activity number
X_means_and_std_test_and_train_with_subject_and_activity_names_mat <- X_means_and_std_test_and_train_with_subject_and_activity_names_mat[, c(1:67,69)]
head(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)
tail(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)
dim(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)

##4	Appropriately labels the data set with descriptive variable names.
## print feature_mat
features_mat
dim(features_mat)
class(features_mat)
typeof(features_mat)
features_mat
##get the names of the selected features similarly to what was done to select the columns of the data frame

mean_and_std_column_select_in_features_mat <- features_mat[mean_and_std_condition,2]
mean_and_std_column_select_in_features_mat

##prepare the names to be used as the comumn names
descriptive_mean_and_std_column_select_in_features_mat <- make.names(mean_and_std_column_select_in_features_mat, unique=TRUE)
descriptive_mean_and_std_column_select_in_features_mat
class(descriptive_mean_and_std_column_select_in_features_mat)
typeof(descriptive_mean_and_std_column_select_in_features_mat)

length(descriptive_mean_and_std_column_select_in_features_mat)

##get the column names for the features and add those for Subject and Activity
subject_column_name <- "Subject"


activity_column_name <- "Activity"

##fix names that include BodyBody
descriptive_mean_and_std_column_select_in_features_mat[61]
descriptive_mean_and_std_column_select_in_features_mat[61] <- "fBodyAccJerkMag.mean.."
descriptive_mean_and_std_column_select_in_features_mat[62]
descriptive_mean_and_std_column_select_in_features_mat[62] <- "fBodyAccJerkMag.std.."
descriptive_mean_and_std_column_select_in_features_mat[63]
descriptive_mean_and_std_column_select_in_features_mat[63] <- "fBodyGyroMag.mean.."
descriptive_mean_and_std_column_select_in_features_mat[64]
descriptive_mean_and_std_column_select_in_features_mat[64] <- "fBodyGyroMag.std.."
descriptive_mean_and_std_column_select_in_features_mat[65]
descriptive_mean_and_std_column_select_in_features_mat[65] <- "fBodyGyroJerkMag.mean.."
descriptive_mean_and_std_column_select_in_features_mat[66]
descriptive_mean_and_std_column_select_in_features_mat[66] <- "fBodyGyroJerkMag.std.."
descriptive_mean_and_std_column_select_in_features_mat[61:66]




descriptive_mean_and_std_column_select_in_features_subject_and_activity_mat <- c(descriptive_mean_and_std_column_select_in_features_mat, subject_column_name, activity_column_name)
descriptive_mean_and_std_column_select_in_features_subject_and_activity_mat
length(descriptive_mean_and_std_column_select_in_features_subject_and_activity_mat)
write.table(descriptive_mean_and_std_column_select_in_features_subject_and_activity_mat,file ="featurenamesforcodebook")


##Add the names to the data frame X_means_and_std_test_and_train_with_subject_and_activity_names_mat
names(X_means_and_std_test_and_train_with_subject_and_activity_names_mat) <- descriptive_mean_and_std_column_select_in_features_subject_and_activity_mat
X_means_and_std_test_and_train_with_subject_and_activity_names_mat
head(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)
dim(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)
class(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)
typeof(X_means_and_std_test_and_train_with_subject_and_activity_names_mat)


##5	From the data set in step 4, creates a second, independent tidy data set with 
##the average of each variable for each activity and each subject


X_means_and_std_test_and_train_average_by_subject_and_activity_mat <- X_means_and_std_test_and_train_with_subject_and_activity_names_mat %>%
  group_by(Subject, Activity) %>%
  summarise_each(funs(mean)) %>%
  print
X_means_and_std_test_and_train_average_by_subject_and_activity_mat

head(X_means_and_std_test_and_train_average_by_subject_and_activity_mat,12)
tail(X_means_and_std_test_and_train_average_by_subject_and_activity_mat,12)

## write tidy data into file
write.table(X_means_and_std_test_and_train_average_by_subject_and_activity_mat, file = "tidy_data_means_and_std_average.txt")

