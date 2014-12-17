#get inertial readings
inertial.tags<- c("body_acc_","body_gyro_","total_acc_")

for(i in 1:3){
    files<- paste("Inertial Signals/", inertial.tags[i],
                  c("x","y","z"),"_",".txt",sep="")
    intertial<- data.frame()
    for(filename in files){
        # write some function to read in the file and do whatever
        # how to have it output??
    }    
}

body_acc_x <- read.table(paste("Inertial Signals/","body_acc_x_",tt,".txt",sep=""))

body_gyro_y <-read.table(paste("Inertial Signals/","body_gyro_y_",tt,".txt",sep="")) 
