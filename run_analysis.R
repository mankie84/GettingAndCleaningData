###this R script takes requires the full UCI HAR Dataset folder in your work directory.
###this R script cleans the data, providing attributes by observations
###this R script analyzes the data and returns measurement averages for each variable, once per activity and subject and once grouped by both; activity and subject
###the analysis result is stored in mean_act (means per measurement and activity), mean_sub (mean per measurement and subject) and mean_all (mean per measurement over subject and activity) 

###call all required packages###
require(tidyr)
require(dplyr)

###setup of workspace###
rm(list = ls())	## workspace
old_wd <- getwd()	## save old wd

###checking for dataset and preparing desciptive variables###
if (file.exists("UCI HAR Dataset")){	## check if UCI HAR Dataset is there
	setwd(".\\UCI HAR Dataset")	## set new wd
} else {
	writeLines("Please move the 'UCI HAR Dataset' folder to your current working directory! \nThen run again. Thx")
	stop()
}
features <- read.table("features.txt")
features <- mutate(features,V2=paste(features$V2)) ## read test data and create character vector from factors
mean <- features[grepl(".*[Mm]ean*.",features$V2),]
mean <- mutate(mean,V1=paste0("V",mean$V1)) ## get list of all measurements for mean and mutate V1 to match variable names of dataset
std <- features[grepl(".*[Ss]td*.",features$V2),]
std <- mutate(std, V1=paste0("V",std$V1))	## get list of all measurements and std and mutate V1 to match variable names of dataset
act <- read.table("activity_labels.txt") ## get list of activity names

###checking for test dataset and cleaning test part of data###
setwd(old_wd)	## reassign ol work directory
if (file.exists("UCI HAR Dataset\\test")){		## check if UCI HAR Dataset is there
	setwd(".\\UCI HAR Dataset\\test")	## set new wd
} else {
	writeLines("Please make sure that the 'test' folder is in the 'UCI HAR Dataset' in your current working directory! \nThen run again. Thx")
	stop()
}
testx <- read.table("X_test.txt") ## read Xtest data
subject_test <- read.table("subject_test.txt")
testxmean <- testx[,names(testx) %in% mean$V1] ## extract all observations with the mean
testxstd <- testx[,names(testx) %in% std$V1] ## extract all observations with the std
test <- cbind(testxmean,testxstd) ## combine all observations on mean and std
colnames(test) <- c(mean$V2,std$V2) ## assign descriptive column headers
testy <- read.table("Y_test.txt") ## read Ytest data with activity connectors
actlabs <- merge(act,testy,by.x="V1",by.y="V1") ## getting the labels per observation in testdata
test <- mutate(test, activity = actlabs$V2, subject = subject_test$V1) ## create activity description per observation

###checking for train dataset and cleaning train part of data###
setwd(old_wd)	## reassign ol work directory
if (file.exists("UCI HAR Dataset\\train")){		## check if UCI HAR Dataset is there
	setwd(".\\UCI HAR Dataset\\train")	## set new wd
} else {
	writeLines("Please make sure that the 'train' folder is in the 'UCI HAR Dataset' in your current working directory! \nThen run again. Thx")
	stop()
}
trainx <- read.table("X_train.txt") ## read Xtrain data
subject_train <- read.table("subject_train.txt")
trainxmean <- trainx[,names(trainx) %in% mean$V1] ## extract all observations with the mean
trainxstd <- trainx[,names(trainx) %in% std$V1] ## extract all observations with the std
train <- cbind(trainxmean,trainxstd) ## combine all observations on mean and std
colnames(train) <- c(mean$V2,std$V2) ## assign descriptive column headers
trainy <- read.table("Y_train.txt") ## read Ytrain data with activity connectors
actlabs <- merge(act,trainy,by.x="V1",by.y="V1") ## getting the labels per observation in testdata
train <- mutate(train, activity = actlabs$V2, subject = subject_train$V1) ## create activity description per obser

###merging data sets and gathering all measurements###
all_data <- rbind(train,test) ## combine train and test cleaned sets into one
gath <- gather(all_data,measurement,value,-subject,-activity)	## gathered all measurements into one column
group <- group_by(gath,activity,subject,measurement)	# grouped measurement values per activity and subject

###analysis###
mean_act <- by(all_data[,1:86],all_data$activity,colMeans) ## all measurement means grouped per activity
mean_sub <- by(all_data[,1:86],all_data$subject,colMeans) ## all measurement means grouped per subject
mean_all <- summarise(group,mean(value)) ## all measurement means grouped per subject and activity together

###write result to file "result.txt"###
write.table(mean_all,"result.txt",row.name=FALSE)

###re-setting old work directory###
setwd(old_wd)

