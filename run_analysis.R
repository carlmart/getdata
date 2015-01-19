
## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
## The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of 
## yes/no questions related to the project. You will be required to submit: 
#  1) a tidy data set as described below, 
## 2) a link to a Github repository with your script for performing the analysis, and 
## 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called 
## 4) CodeBook.md. You should also include a 
## 5) README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected. 

# Download and unzip dataset
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dlfile <- "dataset01.zip"
download.file(fileurl,destfile=dlfile,mode = "wb" , method = "curl")
unzip(dlfile,exdir=".")

# required libraries
library(dplyr)
library(data.table)
library(reshape2)       # dcast , melt_data

# create features table
features.name <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
features.name$V3 <- gsub("\\(\\)",".",features.name$V2)
features.name$V4 <- gsub(".-",".",features.name$V3)`
features.mean.std <- grepl("mean|std", features.name)
features.all <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Part 1 READ IN X TEST and TRAIN TABLE ...................................................
x.test.table <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
x.train.table <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)

x_table_rbind <- rbind(x.test.table,x.train.table)
# dim(x_table_rbind)
# nrow(x_table_rbind)

x_table_named <- x_table_rbind                  # copy
names(x_table_named) <- features.name$V4        # give the X table names


# Part 2 READ in y TEST and TRAIN TABLES
y.test.table <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
y.train.table <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

y_table_rbind <- rbind( y.test.table,y.train.table)


y_table_named <- y_table_rbind
names(y_table_named) <-  c("y_test_train")
# merged accelerometer readings
body_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt",header=FALSE)
body_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt",header=FALSE)
body_acc_x_test_train <- rbind(body_acc_x_test,body_acc_x_train)


body_gyro_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt",header=FALSE)
body_gyro_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt",header=FALSE)
body_gyro_x_test_train <- rbind(body_gyro_x_test,body_gyro_x_train)


total_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt",header=FALSE)
total_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt",header=FALSE)
total_acc_x_test_train <- rbind(total_acc_x_test, total_acc_x_train)

# Y
body_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt",header=FALSE)
body_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt",header=FALSE)
body_acc_y_test_train <- rbind(body_acc_y_test, body_acc_y_train )

body_gyro_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt",header=FALSE)
body_gyro_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt",header=FALSE)
body_gyro_y_test_train <- rbind(body_gyro_y_test, body_gyro_y_train)

total_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt",header=FALSE)
total_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt",header=FALSE)
total_acc_y_test_train <- rbind(total_acc_y_test,total_acc_y_train )

# Z
body_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt",header=FALSE)
body_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt",header=FALSE)
body_acc_z_test_train <- rbind(body_acc_z_test,body_acc_z_train)

body_gyro_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt",header=FALSE)
body_gyro_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt",header=FALSE)
body_gyro_z_test_train <- rbind(body_gyro_z_test,body_gyro_z_train)

total_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt",header=FALSE)
total_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt",header=FALSE)
total_acc_z_test_train <- rbind(total_acc_z_test ,total_acc_z_train)


# create activity label  table
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# load datasets X,y
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(X_test) = features

X_test = X_test[,features.main.std]
y_test[,2] = activity_labels[y_test[,1]]

names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

test_data <- cbind(as.data.table(subject_test), y_test, X_test)


X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(X_train) = features

X_train = X_train[,features.mean.std]
y_train[,2] = activity_labels[y_train[,1]]


names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

train_data <- cbind(as.data.table(subject_train), y_train, X_train)



# rowbind 
data = rbind(test_data, train_data)
id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)



#    5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_dat = dcast(melt_data, subject Activity_Label ~ variable, mean)
write.table(tidy_dat, file = "./tidy_data.txt",row.name=FALSE)
