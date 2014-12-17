#This script gathers and cleans the Samsung [blah] data if it is in the working directory), producing a tidy data set in `objectname`.
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



#X_train is time stamps?
#Y_train maps to the activity states.


activity.labels<- read.table("activity_labels.txt")
names(activity.labels) <- c("activity.code","activity")

features <- read.table("features.txt",col.names=c("col.number","variable"))

tt <- "test"

getHARdata <- function(testOrTraining="test"){
    
    #read x, y, and subject ID
    path<- paste(testOrTraining,"/subject_",testOrTraining,".txt",sep="")
    print(path)
    subj <- read.table(path,col.names= "subject.id")
    subj$part <- testOrTraining
    
    path <-paste(testOrTraining,"/y_",testOrTraining,".txt",sep="")
    print(path)
    y <- read.table(path,col.names="activity.code") 
        
    path <- paste(testOrTraining,"/X_",testOrTraining,".txt",sep="")
    print(path)
    x <- read.table(path, col.names=features$variable)
    
    
    return(cbind(subj,y,x))
}

har.data <- rbind(getHARdata("test"),getHARdata("train"))

nrow(har.data) #expecting 10299
ncol(har.data) #expecting 564
names(har.data)[grep("mean",names(har.data))]


##Step 2
#  review this against features_info.txt
names(har.data)[grep("mean.",names(har.data),fixed=T)]
names(har.data)[grep("std",names(har.data))]



#step 3
y$activity <- cut(y$activity.code,breaks=0.5+c(0:6),
                  labels=activity.labels$activity)
# table(y)