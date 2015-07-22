# Getting_and_Cleaning_Data
Data Science Specialization  
  
I'm going to keep this as simple as possible. Below are the course instructions. I will tell you what row numbers in my code go with which question or task. In addition a brief description of what is going on will be provided.

1) Merges the training and the test sets to create one data set.  
rows: 21-40  
-After importing the 6 files I need I arrange them as shown in the comment block I put in my code 

2) Extracts only the measurements on the mean and standard deviation for each measurement.  
rows: 42-54  
-I import features which will become the measurement columns names or descriptions.  
-Next I Name the columns of features and the first two columns of Data.  
-Then I use regular expressions to extract all "columns"" from features that have mean or std in their name.  
-I next select from Data only the first 2 and then all columns that have mean or std in their name.  
-Now I have "Activity"|"Subject"|"Mean and STD Cols" all in a variable called Data.  

3) Uses descriptive activity names to name the activities in the data set.  
rows: 57-67  
-Now I read in Activities.  
-I can use DPLYR to join the Activities and Data data.frames on the numerical key for Activities.  
-Then I shift columns around a bit and remove the numeric column for Activities and keep only the one with character descriptions.  

4) Appropriately labels the data set with descriptive variable names.  
rows: 68-72  
-Now we have only the Mean and STD column, but they are not labeled.  
-Using grep() again, only this time setting value = TRUE we get the column names from features instead of the index.  
-Next I just set the names of Data to these values in addition to renaming Activity and Subject just to make sure they are set.  

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
rows: 73-75  
-Using aggregate(), I was able to take the mean of the columns I wanted instead of all of them.  
-I gouped by the first two columns and low and behold I had means of all columns grouped by activity and subject.  
