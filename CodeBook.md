# Description
Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

# Source of Data
The metadata and their descriptions can be found in UCI Machine Learning Repository.

# Information of the Experiment
The experiment was done on 30 volunteers aged 19-48. While wearing the Samsung Galaxy S II, The 3-axial linear accelerations and 3-axial angular velocities at a constant rate of 50Hz for six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) were recorded with the help of embedded accelerometer and gyroscope.
Afterwards, the records were randomly partitioned in 70-30 training-testing dataset. By applying noise filters such as cut-off (0.3 Hz), the sensor signals (accelerometer and gyroscope) were pre-processed. 

# Information of the Features.
There are five main groups of the features with the following description:

1. Identifier of the subject.
2. Name of the activity.
3. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
4. Triaxial Angular velocity from the gyroscope.

# Steps for cleaning the data
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Instructions
1. Run the script in run_analysis.R
2. Validate if the tidyData.txt is the same as the resulting file.
