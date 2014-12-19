#This script gathers and cleans the Samsung [blah] data if it is in the working directory), producing a tidy data set in `objectname`.
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



# ==========================  Pre steps ==========================

activity.labels<- read.table("activity_labels.txt")
names(activity.labels) <- c("activity.code","activity")

features <- read.table("features.txt",col.names=c("col.number","variable"))

#define function to combine x, y, and subject ID for a given subset
getHARdata <- function(testOrTraining="test"){
    
    dir<-testOrTraining
    
    #check we are in the HAR dataset folder
    if(!file_test("-d",dir))
    {
        #try going up a directory
        if(file_test("-d",file.path("..",dir)))
        {
           dir<- file.path("..",dir)               
        }else if(file_test("-d",file.path("UCI HAR Dataset",dir)))
        {
            #down a directory from the top of the zip archive
            dir<-file.path("UCI HAR Dataset",dir)
        }
    }
    #read x, y, and subject ID
    path<- paste(dir,"/subject_",testOrTraining,".txt",sep="")
    print(paste("Reading file:", path))
    subj <- read.table(path,col.names= "subject.id")
    subj$part <- testOrTraining
    subj$obs <- seq_len(nrow(subj))
    
    path <-paste(dir,"/y_",testOrTraining,".txt",sep="")
    print(paste("Reading file:", path))
    y <- read.table(path,col.names="activity.code") 
        
    path <- paste(dir,"/X_",testOrTraining,".txt",sep="")
    print(paste("Reading file:", path))
    x <- read.table(path, col.names=features$variable)
    
    
    return(cbind(subj,y,x))
}

# ==========================  Step 1 ==========================
#stack the two datasets using rbind

har.data <- rbind(getHARdata("test"), getHARdata("train"))

nrow(har.data) #expecting 10299
ncol(har.data) #expecting 565


# ==========================  Step 2 ==========================
#extract columns based on names; 
#intentionally excluding signal window averages e.g. angle(tBodyAccJerkMean),gravityMean)
#intentionally excluding frequency means 
mean.cols<- grep("mean.",names(har.data),fixed=T)
std.cols<- grep("std",names(har.data))

#  review selections against features_info.txt
names(har.data)[mean.cols]
names(har.data)[std.cols]

#combine these with the identifying variables
cols<- c(1:4, mean.cols,std.cols)
cols <- cols[order(cols)]

#final check; expecting 4 ID vars and  66 measure vars
names(har.data)[cols]

#subset only desired columns
har.data <- har.data[,cols]

# ==========================  Step 3 ==========================
har.data$activity <- cut(har.data$activity.code,breaks=0.5+c(0:6),
                  labels=activity.labels$activity)
table(har.data[,c("activity","activity.code")]) #check

#as a sanity check, does each participant do each activity?
table(har.data[,c("activity","subject.id")])


# ==========================  Step 4 ==========================
