# gettingandcleaningdata
Getting and Cleaning Data Coursera
title: readme for the Coursera Getting and Cleaning Data Project
author: "Mark Johns"
date: "June 19 2015"


##Purpose of the Project
	

Create a tidy data set from the files provided. The tidy data must contain the average
of each mean and standard deviation measurement variable for each activity and each subject.

##Steps of the Project
		


You should create one R script called run_analysis.R that does the following. 
			*	Merges the training and the test sets to create one data set.
			*	Extracts only the measurements on the mean and standard deviation for each measurement. 
			*	Uses descriptive activity names to name the activities in the data set.
			*	Appropriately labels the data set with descriptive variable names.
			*	From the data set in step 4, creates a second, independent tidy data set with the average
			    of each variable for each activity and each subject.
	    
	    
##Reading the file with tidy data
	    _______________________________
	    
Dataset name:
	    
	    tidy_data_means_and_std_average.txt
	    
	    You can use read.table to read this file. with sep=""
	    
	   	tidy_data_means_and_std_average <- read.table("./tidy_data_means_and_std_average.txt", sep ='', header=TRUE)
	   	
	   	
##Running the run_analysis.R script
	   
	   	
	    
	    All the original project files must be in the same directory as the run_analysis.R file
	    
	    
	    
##What the script does
	    
	    
*	Prepares the training set including the activities ans the subjects.
	Prepares the test set including the activities ans the subjects.
	Merges the training and the test sets to create one data set.
*	Extracts only the measurements on the mean and standard deviation for each measurement.
	Only the variables that include mean() and std() are selected. 
*	Uses descriptive activity names to name the activities in the data set.
*	Appropriately labels the data set with descriptive variable names. Please see details in the Code book
*	From the data set in step 4, creates a second, independent tidy data set with the average
	of each variable for each activity and each subject. This tidy data text file that meets the principles 
			    explained in the Hadley Wickham article about Tidy data available at this link 
			    http://vita.had.co.nz/papers/tidy-data.pdf
	    
	     
	    
##Necessary packages
	    
	   
	    
These packages should be installed. These statements are in te run_analysis.R file.
*library(plyr)
*library(reshape2)
*library(tidyr)
*library(dplyr)
*library(curl)
*Curl is for the Macintosh
        
        
##The Tidy dataset
        
        
        The tidy_data_means_and_std_average.txt file includes a tidy dataset with column names that identify the features
        
The feature names added to the columns are descriptive, because they define these
characteristics:
          
*mean or standard deviation
*wether it is a magnitude 
*wether it is a jerk
*body acceleration or body angular velocity
*wether 3-axial signal
   if 3-axial signal then the direction X Y or Z
*time domain of frequency domain
        
The tidy dataset has the following features
        
It has headings so it is clear which columns are which.
The variables are in different columns
There no duplicate columns
	    
		