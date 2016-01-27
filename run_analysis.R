#Step 1
#Get variable names of features
features <- read.table("UCI HAR Dataset/features.txt", sep = "", header = FALSE)

#Get train subject list
subject <-  read.table("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE, col.names = "subject")

#Step 4
#Get train data 
x <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE, col.names = features$V2)
#Get train activity data
activity <-  read.table("UCI HAR Dataset/train/Y_train.txt", sep = "", header = FALSE, col.names = "activity")
#Build train data set
train <- cbind(subject, x,activity, category = "train")

#Get test subject list
subject <-  read.table("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE, col.names = "subject")
#Step 4
#Get test data
x <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE, col.names = features$V2)
#Get test activity list
activity <-  read.table("UCI HAR Dataset/test/Y_test.txt", sep = "", header = FALSE, col.names = "activity")
#Build test data set
test <- cbind(subject, x,activity, category = "test")
#Merge 2 dataset to one
dat <- rbind(train,test)

#Step 2
#Get names of columns we need 
names <- grep("\\.mean\\.|\\.std\\.", names(dat),value = TRUE)

#Get collumns we need
part <- dat[,c("subject","activity","category", names)]

#Step 3
#Get activity index/label collection
activities <- read.table("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE, col.names = c("activity","activityLabel"))

#Add activity label to dataset
labeled <- merge(part,activities, by.x = "activity", by.y = "activity")[,-1]

#Step 5
library(dplyr)
grouped <- group_by(labeled, activityLabel,subject) 
result <- summarize_each(grouped,funs(mean),3:68)
result
#write.table(result, file = "ProjectResult.txt",row.name = FALSE)