# This code reads the training and test feature values from the UCI HAR dataset;
# combines training and test sets into one data.frame;
# extracts only the features (columns) with means or standard deviations of measurements;
# merges in subject identifiers (integers from 1 to 30) and activity labels for each activity performed while the measurements were recorded;
# and produces 2 smaller datasets:
# tidy1 :  all mean/standard deviation measurements for all subjects and activities 
#       (1 row per measurement time period for total of 10,299 observations of 79 features, plus              subject id and activity label)
# tidy2 : the same columns as tidy1, but instead of reporting each observation point of the measurements, they are aggregated into means for each column, by subject and activity. So, each person has one row for each activity they performed, with the values representing that person's average measurement values during that activity.

# note: this code assumes that the 'UCI HAR Dataset' directory is set as current directory.

# read and merge feature values
dt.x <- rbind(read.table('train/X_train.txt'),read.table('test/X_test.txt'))

# check dimensions
dim(dt.x)
# look at first couple rows, first 10 cols only
head(dt.x[1:10,1:10])

# read and subset feature names
features <- read.table('features.txt')
head(features)
features.ind <- grepl('mean|std',features$V2)
colNums <- features$V1[features.ind==TRUE]

# subset measurement values based on features vector & rename variables
dt.x <- dt.x[,colNums]
names(dt.x) <- features$V2[features.ind==TRUE]
names(dt.x) <- gsub('-|\\(|\\)','',names(dt.x))

# add in subject ids
subjects <- rbind(read.table('train/subject_train.txt'),read.table('test/subject_test.txt'))
dim(subjects)
# rename subject col before merging
names(subjects) <- 'subjectid'

# load activity labels and rename values with activities
dt.y <- rbind(read.table('train/y_train.txt'),read.table('test/y_test.txt'))
dim(dt.y)
head(dt.y)
names(dt.y) <- 'activity'

activity.id <- read.table('activity_labels.txt')
activity.id
str(dt.y)
str(activity.id)
activity.id$V2 <- gsub('_','',tolower(activity.id$V2))
activity.id
head(dt.y)
dt.y$activity <- activity.id[dt.y$activity,2]
head(dt.y)

# merge it all together
tidy1 <- cbind(subjects,dt.x,dt.y)
head(tidy1)

# create 2nd dataset with one row per subject per activity
dim(tidy1)
help(tapply)
dim(tidy1)
dim(tidy1[,2:80])

tidy2 <- aggregate(tidy1[,2:80],by = list(subjectid = tidy1$subjectid,activity = tidy1$activity), mean)
head(tidy2) 
str(tidy2)
# looks like what we want - one row per person per activity, mean vals by group - see below:
# > str(tidy2)
# 'data.frame':	180 obs. of  81 variables:
#         $ subjectid                   : int  1 2 3 4 5 6 7 8 9 10 ...
# $ activity                    : chr  "laying" "laying" "laying" "laying" ...
# $ tBodyAccmeanX               : num  0.222 0.281 0.276 0.264 0.278 ...
# $ tBodyAccmeanY               : num  -0.0405 -0.0182 -0.019 -0.015 -0.0183 ...
# $ tBodyAccmeanZ               : num  -0.113 -0.107 -0.101 -0.111 -0.108 ...
# $ tBodyAccstdX                : num  -0.928 -0.974 -0.983 -0.954 -0.966 ...
# $ tBodyAccstdY                : num  -0.837 -0.98 -0.962 -0.942 -0.969 ...
# $ tBodyAccstdZ                : num  -0.826 -0.984 -0.964 -0.963 -0.969 ...
# $ tGravityAccmeanX            : num  -0.249 -0.51 -0.242 -0.421 -0.483 ...
# $ tGravityAccmeanY            : num  0.706 0.753 0.837 0.915 0.955 ...
# $ tGravityAccmeanZ            : num  0.446 0.647 0.489 0.342 0.264 ...
# $ tGravityAccstdX             : num  -0.897 -0.959 -0.983 -0.921 -0.946 ...
# $ tGravityAccstdY             : num  -0.908 -0.988 -0.981 -0.97 -0.986 ...
# $ tGravityAccstdZ             : num  -0.852 -0.984 -0.965 -0.976 -0.977 ...
# $ tBodyAccJerkmeanX           : num  0.0811 0.0826 0.077 0.0934 0.0848 ...
# $ tBodyAccJerkmeanY           : num  0.00384 0.01225 0.0138 0.00693 0.00747 ...
# $ tBodyAccJerkmeanZ           : num  0.01083 -0.0018 -0.00436 -0.00641 -0.00304 ...
# $ tBodyAccJerkstdX            : num  -0.958 -0.986 -0.981 -0.978 -0.983 ...
# $ tBodyAccJerkstdY            : num  -0.924 -0.983 -0.969 -0.942 -0.965 ...
# $ tBodyAccJerkstdZ            : num  -0.955 -0.988 -0.982 -0.979 -0.985 ...
# $ tBodyGyromeanX              : num  -0.01655 -0.01848 -0.02082 -0.00923 -0.02189 ...
# $ tBodyGyromeanY              : num  -0.0645 -0.1118 -0.0719 -0.093 -0.0799 ...
# $ tBodyGyromeanZ              : num  0.149 0.145 0.138 0.17 0.16 ...
# $ tBodyGyrostdX               : num  -0.874 -0.988 -0.975 -0.973 -0.979 ...
# $ tBodyGyrostdY               : num  -0.951 -0.982 -0.977 -0.961 -0.977 ...
# $ tBodyGyrostdZ               : num  -0.908 -0.96 -0.964 -0.962 -0.961 ...
# $ tBodyGyroJerkmeanX          : num  -0.107 -0.102 -0.1 -0.105 -0.102 ...
# $ tBodyGyroJerkmeanY          : num  -0.0415 -0.0359 -0.039 -0.0381 -0.0404 ...
# $ tBodyGyroJerkmeanZ          : num  -0.0741 -0.0702 -0.0687 -0.0712 -0.0708 ...
# $ tBodyGyroJerkstdX           : num  -0.919 -0.993 -0.98 -0.975 -0.983 ...
# $ tBodyGyroJerkstdY           : num  -0.968 -0.99 -0.987 -0.987 -0.984 ...
# $ tBodyGyroJerkstdZ           : num  -0.958 -0.988 -0.983 -0.984 -0.99 ...
# $ tBodyAccMagmean             : num  -0.842 -0.977 -0.973 -0.955 -0.967 ...
# $ tBodyAccMagstd              : num  -0.795 -0.973 -0.964 -0.931 -0.959 ...
# $ tGravityAccMagmean          : num  -0.842 -0.977 -0.973 -0.955 -0.967 ...
# $ tGravityAccMagstd           : num  -0.795 -0.973 -0.964 -0.931 -0.959 ...
# $ tBodyAccJerkMagmean         : num  -0.954 -0.988 -0.979 -0.97 -0.98 ...
# $ tBodyAccJerkMagstd          : num  -0.928 -0.986 -0.976 -0.961 -0.977 ...
# $ tBodyGyroMagmean            : num  -0.875 -0.95 -0.952 -0.93 -0.947 ...
# $ tBodyGyroMagstd             : num  -0.819 -0.961 -0.954 -0.947 -0.958 ...
# $ tBodyGyroJerkMagmean        : num  -0.963 -0.992 -0.987 -0.985 -0.986 ...
# $ tBodyGyroJerkMagstd         : num  -0.936 -0.99 -0.983 -0.983 -0.984 ...
# $ fBodyAccmeanX               : num  -0.939 -0.977 -0.981 -0.959 -0.969 ...
# $ fBodyAccmeanY               : num  -0.867 -0.98 -0.961 -0.939 -0.965 ...
# $ fBodyAccmeanZ               : num  -0.883 -0.984 -0.968 -0.968 -0.977 ...
# $ fBodyAccstdX                : num  -0.924 -0.973 -0.984 -0.952 -0.965 ...
# $ fBodyAccstdY                : num  -0.834 -0.981 -0.964 -0.946 -0.973 ...
# $ fBodyAccstdZ                : num  -0.813 -0.985 -0.963 -0.962 -0.966 ...
# $ fBodyAccmeanFreqX           : num  -0.159 -0.146 -0.074 -0.274 -0.136 ...
# $ fBodyAccmeanFreqY           : num  0.0975 0.2573 0.2385 0.3662 0.4665 ...
# $ fBodyAccmeanFreqZ           : num  0.0894 0.4025 0.217 0.2013 0.1323 ...
# $ fBodyAccJerkmeanX           : num  -0.957 -0.986 -0.981 -0.979 -0.983 ...
# $ fBodyAccJerkmeanY           : num  -0.922 -0.983 -0.969 -0.944 -0.965 ...
# $ fBodyAccJerkmeanZ           : num  -0.948 -0.986 -0.979 -0.975 -0.983 ...
# $ fBodyAccJerkstdX            : num  -0.964 -0.987 -0.983 -0.98 -0.986 ...
# $ fBodyAccJerkstdY            : num  -0.932 -0.985 -0.971 -0.944 -0.966 ...
# $ fBodyAccJerkstdZ            : num  -0.961 -0.989 -0.984 -0.98 -0.986 ...
# $ fBodyAccJerkmeanFreqX       : num  0.132 0.16 0.176 0.182 0.24 ...
# $ fBodyAccJerkmeanFreqY       : num  0.0245 0.1212 -0.0132 0.0987 0.1957 ...
# $ fBodyAccJerkmeanFreqZ       : num  0.0244 0.1906 0.0448 0.077 0.0917 ...
# $ fBodyGyromeanX              : num  -0.85 -0.986 -0.97 -0.967 -0.976 ...
# $ fBodyGyromeanY              : num  -0.952 -0.983 -0.978 -0.972 -0.978 ...
# $ fBodyGyromeanZ              : num  -0.909 -0.963 -0.962 -0.961 -0.963 ...
# $ fBodyGyrostdX               : num  -0.882 -0.989 -0.976 -0.975 -0.981 ...
# $ fBodyGyrostdY               : num  -0.951 -0.982 -0.977 -0.956 -0.977 ...
# $ fBodyGyrostdZ               : num  -0.917 -0.963 -0.967 -0.966 -0.963 ...
# $ fBodyGyromeanFreqX          : num  -0.00355 0.10261 -0.08222 -0.06609 -0.02272 ...
# $ fBodyGyromeanFreqY          : num  -0.0915 0.0423 -0.0267 -0.5269 0.0681 ...
# $ fBodyGyromeanFreqZ          : num  0.0105 0.0553 0.1477 0.1529 0.0414 ...
# $ fBodyAccMagmean             : num  -0.862 -0.975 -0.966 -0.939 -0.962 ...
# $ fBodyAccMagstd              : num  -0.798 -0.975 -0.968 -0.937 -0.963 ...
# $ fBodyAccMagmeanFreq         : num  0.0864 0.2663 0.237 0.2417 0.292 ...
# $ fBodyBodyAccJerkMagmean     : num  -0.933 -0.985 -0.976 -0.962 -0.977 ...
# $ fBodyBodyAccJerkMagstd      : num  -0.922 -0.985 -0.975 -0.958 -0.976 ...
# $ fBodyBodyAccJerkMagmeanFreq : num  0.266 0.342 0.239 0.274 0.197 ...
# $ fBodyBodyGyroMagmean        : num  -0.862 -0.972 -0.965 -0.962 -0.968 ...
# $ fBodyBodyGyroMagstd         : num  -0.824 -0.961 -0.955 -0.947 -0.959 ...
# $ fBodyBodyGyroMagmeanFreq    : num  -0.1398 0.0186 -0.0229 -0.2599 0.1024 ...
# $ fBodyBodyGyroJerkMagmean    : num  -0.942 -0.99 -0.984 -0.984 -0.985 ...
# $ fBodyBodyGyroJerkMagstd     : num  -0.933 -0.989 -0.983 -0.983 -0.983 ...
# $ fBodyBodyGyroJerkMagmeanFreq: num  0.1765 0.2648 0.1107 0.2029 0.0247 ...
