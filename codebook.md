## Code book

This file identifies the variables and units for all variables in the tidy1 and tidy2 datasets. The datasets are modified from the UCI HAR data as found and described here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The variables below include slight modifications to the original variable names (to make for easier data manipulation), but are otherwise the same. Feature descriptions are found below, in a modified version of the original 'features_info.txt' file found at the above website.

Variable names in tidy1 and tidy2 datasets:

* subjectid integer from 1 to 30 identifying the individual being measured.
* activity = the activity performed while measurements were taken.

Character var, one of:

* standing - person is standing but not moving
* sitting - person is sitting down
* walking - person is walking, presumably on flat surface
* walkingupstairs - person is walking up some stairs
* walkingdownstairs - person is walking down some stairs
* laying - person is laying down

And the following numeric variables found in the original data (text modified from feature description found at above website).

# Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

# Features

* tBodyAccXYZ
* tGravityAccXYZ
* tBodyAccJerkXYZ
* tBodyGyroXYZ
* tBodyGyroJerkXYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAccXYZ
* fBodyAccJerkXYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean: Mean value
* std: Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

In the tidy1 dataset the actual values for these features are provided; in the tidy2 dataset these same variable names are used to denote the mean of each variable for the specified individual (subjected) and activity.