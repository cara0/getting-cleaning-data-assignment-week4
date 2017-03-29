
## Programming assignment for Week 4: Tidying UCI HAR Data

This assignment uses the UCI HAR dataset to prepare datasets of people's movements (as measured by their Samsung phones) during different activities (such as standing or sitting).

# Background and information from authors of dataset
Information about data collection, experiment, and results found here:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

As quoted from the README file distributed by the authors of the dataset:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment."

# The run_analysis.R code:
* reads the training and test feature values from the UCI HAR dataset;
* combines training and test sets into one data.frame;
* extracts only the features (columns) with means or standard deviations of measurements;
* merges in subject identifiers (integers from 1 to 30) and activity labels for each activity performed while the measurements were recorded;
* and produces 2 tidy datasets: tidy1 and tidy2.

# tidy1
This tidy dataset includes all mean/standard deviation measurements for all subjects and activities.

* 1 row per measurement time period 
* total of 10,299 observations (rows) and
* 81 variables - 79 features, plus subject id and activity label

# tidy2
This tidy dataset has the same columns as tidy1, but instead of reporting each observation point of the measurements, they are aggregated into means for each column, by subject and activity. 

* Each person has one row for each activity they performed
* Values represent that person's average measurement values during that activity.
* As there are 30 subjects and 6 activities, the dataset has a total of 6 x 30 = 180 rows 
* because each feature is included from tidy1 (just aggregated by person and activity), there are still 81 columns, including the 79 features and the subject and activity identifier variables.

