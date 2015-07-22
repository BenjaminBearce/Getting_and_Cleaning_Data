#---------------------------------------------------------------------------#
# - Initialize Libraries - #
library(dplyr); library(tidyr);library(data.table);



# - Merge the trainging and the test sets to create one data set - # 

# Import\Load
setwd(paste(getwd(),"/UCI HAR Dataset/test/",sep=""));
sub_test <- data.table(read.table(file = "subject_test.txt")); 
X_test <- data.table(read.table(file = "X_test.txt"));
Y_test <- data.table(read.table(file = "y_test.txt"));
setwd("../../");

setwd(paste(getwd(),"/UCI HAR Dataset/train/",sep=""));
sub_train <- data.table(read.table(file = "subject_train.txt"));
X_train <- data.table(read.table(file = "X_train.txt"));
Y_train <- data.table(read.table(file = "y_train.txt"));
setwd("../");
# Merge

        # 1) To Merge we need to gather the test and train data into their respective groups
        # 2) Then we will stack them to get a complete view of the data

        # Structure should look like this:
        # Y_test|Sub_test|X_test(561 Cols) ... Y_train|Sub_train|X_train(561 Cols)
        # ------|--------|----------------     -------|---------|-----------------
        # 6 #'s |9 #'s   |feature vector       6 #'s  |9 #'s    |feature vector

        # "In Plain English"
        # Activities|Volunteer|A 561-feature vector ... Activities|Volunteer|A 561-feature vector
        # ------|--------|----------------     -------|---------|-----------------
        # 6 #'s |9 #'s   |feature vector       6 #'s  |9 #'s    |feature vector

Test <- cbind(Y_test,sub_test,X_test);
Train <- cbind(Y_train,sub_train,X_train);

Data <- rbind(Test,Train);
Data <- as.data.frame(Data); # For better column indexing 

# - Extracts only the measurements on the mean and standard deviation for each measurement. - #

# Import\Load
#setwd(paste(getwd(),"/UCI HAR Dataset/",sep=""));
features <- data.table(read.table(file = "features.txt", stringsAsFactors = F));

# Brief formatting
setnames(features, c("Measurement.Number", "Measurement.Name")); # Name feature data table's columns
names(Data)[1:2] <- c("Activity", "Subject")

# Mean and standarad deviation measurements
MSI <- grep("([mM][eE][aA][nN]|[sS][tT][dD])", features$Measurement.Name, perl = T, value = F);

Data <- Data[ , c(1,2,MSI+2)];

# - Uses descriptive activity names to name the activities in the data set - #

Activities <- read.table(file = "activity_labels.txt");
setnames(Activities, c("Activity","Activity.Name"))

Data <- Data %>%
        left_join(Activities, by = "Activity") %>%
        select(-Activity) %>%
        rename(Activity = Activity.Name) %>%
        select(c(88),c(1:87))

# - Appropriately labels the data set with descriptive variable names.  - #

Measurements <- grep("([mM][eE][aA][nN]|[sS][tT][dD])", features$Measurement.Name, perl = T, value = T);
setnames(Data, c("Activity", "Subject", Measurements)); # Name Data's columns

# - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. - #

Data <- aggregate(as.matrix(Data[,3:88]), as.list(Data[,1:2]), FUN = mean)
#---------------------------------------------------------------------------#

