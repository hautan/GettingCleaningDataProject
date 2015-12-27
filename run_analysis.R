# Clean up workspace
rm(list=ls())

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("reshape2")


# Read in the data from files
features     <-  read.table('./UCI HAR Dataset/features.txt',header=FALSE)[,2]; 
activityType <-  read.table('./UCI HAR Dataset/activity_labels.txt',header=FALSE)[,2]; 

# Read train data from files
subjectTrain <-  read.table('./UCI HAR Dataset/train/subject_train.txt',header=FALSE); 
XTrain       <-  read.table('./UCI HAR Dataset/train/X_train.txt',header=FALSE); 
yTrain       <-  read.table('./UCI HAR Dataset/train/y_train.txt',header=FALSE); 

# Read test data from files
subjectTest <-  read.table('./UCI HAR Dataset/test/subject_test.txt',header=FALSE); 
XTest       <-  read.table('./UCI HAR Dataset/test/X_test.txt',header=FALSE); 
yTest       <-  read.table('./UCI HAR Dataset/test/y_test.txt',header=FALSE); 

# Data column names
names(subjectTrain)  <-  "subjectId";
names(XTrain) <-  features
yTrain[,2] <-  activityType[yTrain[,1]]
names(yTrain)        <-  c('activityId','activityType');

names(subjectTest) <-  "subjectId";
names(XTest) <-  features
yTest[,2] <-  activityType[yTest[,1]]
names(yTest)       <-  c('activityId','activityType');

# Extract only the measurements on the mean and standard deviation for each measurement
extract_features <- grepl("mean|std", features)
XTest <-  XTest[,extract_features]
XTrain <-  XTrain[,extract_features]

# Training data set
trainingData <-  cbind(yTrain,subjectTrain,XTrain);

# Test data set
testData <-  cbind(yTest,subjectTest,XTest);

# Final data set
finalData <-  rbind(trainingData,testData);

# Updating the colNames vector to include the new column names after merge
columnNames  = colnames(finalData); 


# Cleaning up the variable names
for (i in 1:length(columnNames)) 
{
  columnNames[i] = gsub("\\()","",columnNames[i])
  columnNames[i] = gsub("-std$","Std",columnNames[i])
  columnNames[i] = gsub("-mean","Mean",columnNames[i])
  columnNames[i] = gsub("^(f)","freq",columnNames[i])
  columnNames[i] = gsub("^(t)","time",columnNames[i])
  columnNames[i] = gsub("([Gg]ravity)","Gravity",columnNames[i])
  columnNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",columnNames[i])
  columnNames[i] = gsub("[Gg]yro","Gyro",columnNames[i])
  columnNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",columnNames[i])
};

# Reassigning the new descriptive column names to the finalData set
colnames(finalData) = columnNames;

idLabels   = c("subjectId", "activityId", "activityType")
dataLabels = setdiff(colnames(finalData), idLabels)
meltData      = melt(finalData, id = idLabels, measure.vars = dataLabels)

# Apply mean function to dataset using dcast function
tidyData   = dcast(meltData, subjectId + activityType ~ variable, mean)
