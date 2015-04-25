#Takes data from UCI fitness info and returns a formated graph with mean/stddev

run_analysis = function(){    
    library(reshape2)
    #Builds the table for the test side
    teDir = "UCI HAR Dataset\\test\\"
    teSubject= read.table(paste0(teDir,"subject_test.txt"),col.names = "id")
    teY_test = read.table(paste0(teDir,"y_test.txt"),col.names = "test.activity")
    teX_test = read.table(paste0(teDir,"x_test.txt"),col.names = paste0("test.set", 1:561))
    teSubY = melt(data.frame(teSubject,teY_test),id=c("id","test.activity"))
    teTable = melt(data.frame(teSubY,teX_test),id=c("id","test.activity",paste0("test.set",1:561)))
    
    #builds a table to find std/mean for each measurement from test side
    table1p1 = teTable[1:nrow(teTable), 1:2]
    teMean = rowMeans((teTable[1:nrow(teTable),3:ncol(teTable)]))
    teSD = apply((teTable[1:nrow(teTable),3:ncol(teTable)]), 1,sd)  
    temp = matrix(teMean,nrow = nrow(teTable))
    table1p1$test.Mean = temp
    temp = matrix(teSD,nrow = nrow(teTable))
    table1p1$test.SD = temp
    
    #Builds the table for the Train side
    trDir = "UCI HAR Dataset\\train\\"
    trSubject= read.table(paste0(trDir,"subject_train.txt"),col.names = "id")
    trY_train = read.table(paste0(trDir,"y_train.txt"),col.names = "train.activity")
    trX_train = read.table(paste0(trDir,"x_train.txt"),col.names = paste0("train.set", 1:561))
    trSubY = melt(data.frame(trSubject,trY_train),id=c("id","train.activity"))
    trTable = melt(data.frame(trSubY,trX_train),id=c("id","train.activity",paste0("train.set",1:561)))
    
    #builds the table for mean/sd of each measurement in the train side
    table1p2 = trTable[1:nrow(trTable), 1:2]
    trMean = rowMeans((trTable[1:nrow(trTable),3:ncol(trTable)]))
    trSD = apply((trTable[1:nrow(trTable),3:ncol(trTable)]), 1,sd)  
    temp = matrix(trMean,nrow = nrow(trTable))
    table1p2$train.Mean = temp
    temp = matrix(trSD,nrow = nrow(trTable))
    table1p2$train.SD = temp
    
    table1 <<- merge(table1p1,table1p2,by='id',all = TRUE)
    
    #build tables to group by test/id for test data
    test1 = melt(teTable, id.vars = c("id", "test.activity"))
    test2 = dcast(id + test.activity ~ c(id), data= test1,fun = mean, na.rm = TRUE)
    test3 = dcast(id  + test.activity~ c(id), data= test1,fun = sd, na.rm = TRUE)
    for(i in 4:ncol(test3)){
        test2[which(!is.na(test2[,i])),3] =test2[which(!is.na(test2[,i])),i]
        test3[which(!is.na(test3[,i])),3] =test3[which(!is.na(test3[,i])),i]
    }
    names(test2) = c("id", "activity", "test.mean")
    test2 = test2[,1:3]
    names(test3) = c("id", "activity",  "test.sd")
    test3 = test3[,1:3]
    testTable = merge(test2,test3, all = TRUE, sort = TRUE)
    #testTable = testTable[order(testTable$id,testTable$test.activity),]
    
    #build tables to group by test/id for training data
    train1 = melt(trTable, id.vars = c("id", "train.activity"))
    train2 = dcast(id + train.activity ~ c(id), data= train1,fun = mean, na.rm = TRUE)
    train3 = dcast(id  + train.activity~ c(id), data= train1,fun = sd, na.rm = TRUE)
    for(i in 4:ncol(train3)){
        train2[which(!is.na(train2[,i])),3] =train2[which(!is.na(train2[,i])),i]
        train3[which(!is.na(train3[,i])),3] =train3[which(!is.na(train3[,i])),i]
    }
    names(train2) = c("id", "activity", "train.mean")
    train2 = train2[,1:3]
    names(train3) = c("id", "activity",  "train.sd")
    train3 = train3[,1:3]
    trainTable = merge(train2,train3, all = TRUE, sort = TRUE)
    
    table2 <<- merge(testTable,trainTable, all = TRUE, sort = TRUE)
}