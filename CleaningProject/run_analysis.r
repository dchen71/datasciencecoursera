#Takes data from UCI fitness info and returns a formated graph with mean/stddev

run_analysis = function(){    
    library(data.table)
    
    #Read and merge data from UCI HAR Dataset and variablenames
    DT = data.table( rbind( read.table('UCI HAR Dataset/train/X_train.txt'),read.table('UCI HAR Dataset/test/X_test.txt') ) )
    
    #Collects the variable names
    DT.names = read.table('UCI HAR Dataset//features.txt', colClasses = "character")[,2]
    setnames(DT,names(DT),DT.names)
    
    #Gets the subject ids and names them
    subject = data.table( subject=rbind( read.table('UCI HAR Dataset/train/subject_train.txt'),read.table('UCI HAR Dataset/test/subject_test.txt') ) )
    setnames(subject,names(subject),"subject")
    
    #Gets activity data
    activity = data.table( activity=rbind( read.table('UCI HAR Dataset/train/y_train.txt'),read.table('UCI HAR Dataset/test/y_test.txt') ) )
    
    #Sets activity names
    setnames(activity,names(activity),"activity")
    activity$activity = as.factor(activity$activity)
    activity_labels = read.table('UCI HAR Dataset/activity_labels.txt')
    levels(activity$activity) = activity_labels[[2]]
    
    #Gets the mean and standard deviation variables
    msv = grep("mean()|std()",DT.names) 
    DT2 = cbind(subject,activity,DT[,msv,with=FALSE])

    #Creates tidynames and sets them
    tidynames = gsub("\\(\\)|\\-","",tolower(names(DT2)))
    setnames(DT2,names(DT2),tidynames)

    # Aggregate
    agg = aggregate(DT2[,3:81,with=FALSE],by=list(activity=DT2$activity,subject=DT2$subject),FUN=mean,na.rm=TRUE)

    # Create tidy dataset to file
    write.table(agg,file="tidyucihar.txt",row.name=FALSE)
}