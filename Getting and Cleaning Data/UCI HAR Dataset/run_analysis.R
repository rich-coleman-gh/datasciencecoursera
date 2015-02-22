library(reshape2)
library(plyr)

setwd("C:/Users/rcoleman/Documents/GitHub/Coursera/Getting and Cleaning Data/New folder/")
#################################Import Training Datasets#########################################
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")

yTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

xLabels <- read.table("UCI HAR Dataset/features.txt")


#reshape column names for x,y set from long to wide
colnames(xTrain) <- xLabels$V2
colnames(yTrain) <- "activity_labels"
colnames(subjectTrain) <- "subject_id"

#combine training datasets
trainingDf <- cbind(subjectTrain,yTrain,xTrain)
################################Import Testing Datasets############################################
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")

yTest <- read.table("UCI HAR Dataset/test/Y_test.txt")

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")

#reshape column names for x,y set from long to wide
colnames(xTest) <- xLabels$V2
colnames(yTest) <- "activity_labels"
colnames(subjectTest) <- "subject_id"

#combine training datasets
testDf <- cbind(subjectTest,yTest,xTest)
##############################Merge Training and Testing datasets################################
df <- rbind(testDf,trainingDf)

#replace activity labels with descriptions
df$activity_labels[df$activity_labels==1] <- "WALKING"
df$activity_labels[df$activity_labels==2] <- "WALKING_UPSTAIRS"
df$activity_labels[df$activity_labels==3] <- "WALKING_DOWNSTAIRS"
df$activity_labels[df$activity_labels==4] <- "SITTING"
df$activity_labels[df$activity_labels==5] <- "STANDING"
df$activity_labels[df$activity_labels==6] <- "LAYING"

##########################################Tidy up the data######################################
#get columns that refrence mean and std dev
temp <- df[ , grepl("(mean|std)", colnames(df))] #note: currently we include meanfreq() columns
dfTrimmed <- cbind(df[,1:2],temp)

#average factors by subject_id,activities
dfTidy <- aggregate(x = dfTrimmed, by = list(dfTrimmed$subject_id,dfTrimmed$activity_labels), FUN = "mean")
#clean up column names
dfTidy$subject_id <- NULL
dfTidy$activity_labels <- NULL
colnames(dfTidy)[1] <- "subject_id"
colnames(dfTidy)[2] <- "activity"

#remove special characters that would be difficult to refrence
colnames(dfTidy)=gsub('-','_',colnames(dfTidy))          
colnames(dfTidy)=gsub('\\(','',colnames(dfTidy))
colnames(dfTidy)=gsub(')','',colnames(dfTidy))

write.table(dfTidy,"UCI HAR Dataset/tidyData.txt",row.names=FALSE)
