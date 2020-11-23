
####1. Loading packages and downloading the file from its source####
packages = c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)
path = getwd()
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

####2. Loading the activity labels from the unzipped dataset####
###Load the activities of the experiment.
activity_labels = fread(file.path(path, "UCI HAR Dataset/activity_labels.txt")
                        , col.names = c("classLabels", "activityName"))
###Load the features used during the experiment
features = fread(file.path(path, "UCI HAR Dataset/features.txt")
                  , col.names = c("index", "featureNames"))
###Filter only the mean and standard deviation related features.
features_need = grep("(mean|std)\\(\\)", features[, featureNames])
measurements = features[features_need, featureNames]
measurements = gsub('[()]', '', measurements)

####3. Loading the training dataset####
###Read the training dataset.
train = fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, features_need, with = FALSE]
###Setting the column names as the feature names
data.table::setnames(train, colnames(train), measurements)
###Read the activities and subject data from training dataset.
train_activities = fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt")
                       , col.names = c("Activity"))
train_subjects = fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt")
                       , col.names = c("SubjectNum"))
###Column binding the read data.
train = cbind(train_subjects, train_activities, train)

####3. Loading the testing dataset####
test = fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, features_need, with = FALSE]
###Setting the column names as the feature names
data.table::setnames(test, colnames(test), measurements)
###Read the activities and subject data from testing dataset.
test_activities = fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt")
                        , col.names = c("Activity"))
test_subjects = fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt")
                      , col.names = c("SubjectNum"))
###Column binding the read data.
test = cbind(test_subjects, test_activities, test)

####4. Merging the training and testing dataset####
###Row binding the training and testing dataset
combined = rbind(train, test)

####5. Explicitly converting the class labels to activities####
combined[["Activity"]] = factor(combined[, Activity]
                              , levels = activity_labels[["classLabels"]]
                              , labels = activity_labels[["activityName"]])

combined[["SubjectNum"]] = as.factor(combined[, SubjectNum])
combined = reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))
combined = reshape2::dcast(data = combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)

####6. Writing the final table to a text file ####
data.table::fwrite(x = combined, file = "tidyData.txt", quote = FALSE)