** UCI HAR Dataset **

* Read in features table and select only the names column
   ( need to change names to be read more clearly)
   Table 1 features.name

```{r}
library(dplyr)
features.name <- read.table("UCI HAR Dataset/features.txt",header=FALSE)
```
* Start changing features.name to create readable titles 
    ( substitute "()" to "."  )

```r

Output of features.name 

```r
V1	V2
1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y

```    
   Now for substitution of "()"
```{r}
# substitute "()" to "."
features.name$V3 <- gsub("\\(\\)",".",features.name$V2)  
```
Adding Columns until it is in readable format:
```r
  V1                V2               V3
1  1 tBodyAcc-mean()-X tBodyAcc-mean.-X
2  2 tBodyAcc-mean()-Y tBodyAcc-mean.-Y
3  3 tBodyAcc-mean()-Z tBodyAcc-mean.-Z
4  4  tBodyAcc-std()-X  tBodyAcc-std.-X
5  5  tBodyAcc-std()-Y  tBodyAcc-std.-Y
```

```r
# substitute ".-" and "-" to "."}
features.name$V4 <- gsub(".-",".",features.name$V3)       	# substitute ".-" and "-" to "."
```
Finally have V4 with readable names
```r
  V1                V2               V3             V4
1  1 tBodyAcc-mean()-X tBodyAcc-mean.-X tBodyAc.mean.X
2  2 tBodyAcc-mean()-Y tBodyAcc-mean.-Y tBodyAc.mean.Y
3  3 tBodyAcc-mean()-Z tBodyAcc-mean.-Z tBodyAc.mean.Z
4  4  tBodyAcc-std()-X  tBodyAcc-std.-X  tBodyAc.std.X
5  5  tBodyAcc-std()-Y  tBodyAcc-std.-Y  tBodyAc.std.Y
```
* bind X test and train   table 2
```r
x.test.table <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
x.train.table <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)

x_table_rbind <- rbind(x.test.table,x.train.table)
dim(x_table_rbind)
nrow(x_table_rbind)
 
x_table_named <- x_table_rbind                  # copy
names(x_table_named) <- features.name$V4        # give the X table names
```

* Now for reading y test and train tables or vectors Table 3

```r
#  READ in y TEST and TRAIN TABLES and bind
y.test.table <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)
y.train.table <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

y_table_rbind <- rbind( y.test.table,y.train.table)

y_table_named <- y_table_rbind
names(y_table_named) <-  c("y_test_train")
```

* Reading in Subject table 4
'''r
subject.test.table <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
'''r



** Next set of Tables are the Accelerometer / Angular readings **

After reading in test and train readings we bind for  total measurements.

```r
#--------------- accelerometer readings
# x
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

``` 

** The actual final tables are listed below **

* body_acc_x_test_train
* body_gyro_x_test_train
* total_acc_x_test_train
* body_acc_y_test_train
* body_gyro_y_test_train
* total_acc_y_test_train
* body_acc_z_test_train
* body_gyro_z_test_train 
* total_acc_z_test_train

** Now for the final output group summations **
using cbind

```r
t_data <- cbind(as.data.table(subject_test), y_test, X_test)

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(X_train) = features
```
```r
# now for only mean, std
X_train = X_train[,features.mean.std]
y_train[,2] = activity_labels[y_train[,1]]
```

names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

train_data <- cbind(as.data.table(subject_train), y_train, X_train)
```
```R

# rowbind test and train data
data = rbind(test_data, train_data)
id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
merged_data_final = melt(data, id = id_labels, measure.vars = data_labels)
```
** Final step **
```r
#    5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydataset = dcast(merged_data_final, subject + Activity_Label ~ variable, mean)
write.table(tidy_dataset, file = "tidydataset.txt")
```



















