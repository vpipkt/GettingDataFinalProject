
# Human Activity Recognition Code Book

This code book describes the experiment, the variables, the data, and all transformations performed to prepare the human activity recognition data for further analysis.  The purpose of this or any code book is to increase reproducibility of research and analysis.

## The experiment
The data are records of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.  More information about the original research is [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and in the associated readme within the Original Codebook.  

## Raw data
The data was retrieved from a [coursera-hosted compressed archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) on December 13, 2014.

The raw data archive includes meta-data (`README.txt`, `features.txt`, `features_info.txt`) and experimental data. The reader of this codebook is must carefully review the original codebook, also contained in this repo. The raw data is separated by subjects into two groups: testing and training, to support machine learning analysis.  The structure of all data is the same between training and test.

To quote the UCI HAR readme: "The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window)."  The Inertial Signals folder contains these data in six files whose names start with `total_acc` or `body_gyro` and end in either x, y, or z indicating the axis.  The `body_acc` files remove the gravitational component. Each row is a time window, and each column a reading. The rows correspond to the same observations in the subject text file and y text file.  This is

The `X_test` or `X_train` files aggregate the inertial signals. Within the X file, each row describes a single 2.56 second window.  Each X row is therefore also associated to the corresponding row in the subject text file and y text file.  Test data has 2947 observations (windows). Training data has 7352 observations.

Each column of an X file corresponds to the features listed in `features.txt` of the original code book.  A feature was defined by applying some statistical function to all the readings of one sensor for the window.  The analysis here does not attempt to process the Inertial Signal reading data to reproduce the content of any feature in the X file. Instead the analysis relies on the UCI HAR provided feature data.

## Data processing
As a preliminary activity, the script reads in the provided activity code and label data. This will be applied to coded activity numbers later. The vector of feature names are read from `feature.txt`.

### Step 1: A single dataset
The test and training data are read and stacked into a single dataset, noting both which subset each record came from and its original row number in the source file. First the y file (the activity number), the subject identifier, and the feature (X) file are joined column wise.  The columns from the features file are named according to the feature vector.  A function was defined to handle the data ingest task for either training or test in the same fashion.  The two resulting intermediate data frames are stacked to form the initial `har.data` data.frame.

### Step 2: Extract mean and standard deviation
The feature data file includes a wide variety of statistical summaries of each window. Only the mean and standard deviation are necessary for the further analysis. The `grep` fucntion is used to extract columns labeled with mean and std. This excludes purposefully features such as the meanFreq(), and the angular means such as gravityMean.

### Step 3: Activity labels
The activity code is converted using the `cut` function and the label names read in at the start.  The activity code is retained.

### Step 4: Variable names
The existing feature names are compact but not particularly R-friendly or easy to interpret. Slightly more verbose names with no excess punctionation are created and applied to the feature columns of `har.data`.  The new names use the following grammar.

**Domain.Stat.Body.Measure.Vector**

The components are as follows, along with how the original feature names handle each aspect.

1) Domain: either Time or Frequency. Original features prepend `t` or `f` resepecively
2) Stat: either Mean or Standard.deviation. Original features contained `-mean()` and `-std()` which resulted in series of periods.
2) Body: either Body or Gravity. This is the same as the original
2) Measure: this is a combination of the instrument used and the Jerk flag. If the instrument was the accelerometer, `accel` in feature.txt with no `jerk`, then the measure is Linear.velocity. If `accel` and `jerk` then Linear.jerk. If the instrument was the gyroscope (`gyro`), then the measure is Angular.velocity. With `gyro` and `jerk`, it is Angular.jerk.
2) Vector: This indicates the axis X, Y, or Z for triaxial measurements, or Magnitude if it is the magnitude scalar, indicated by `Mag` in the feature.

It is noted that some possible combinations of features were not provided in the original dataset, such as the triaxial components of fBodyGyroJerk.  No attempt is made to construct these from the Inertial Signals.  It is also noted that some features are named with BodyBody in the name. This is interpreted the same as a single instance of body.

This step in the process also represents the decision point for wide or long tidy data, as discussed further in README.md.  Although, for instance, Domain is descriptive to define in this grammar, it does not seem to rise to a categorical variable.  Domain as a variable would imply some meaningful calculation could be done across time and frequency domains for example tBodyAccX + fBodyAccX. The "wide" tidy data proposition extends this argument to the other categories as well, in what is ultimately a judgment call about what is most appropriate for the further analysis.

The other identifying variables in the data frame are:

 - subject.id: The numeric identifier of the research subject
 
 - activity: The descriptive name of the activity
 
 - part: Indicator of whether the data came from the test or training subset
 
 - obs: The observation number within the original test or training data
 
 - activity.code: The original activity code number

### Step 5: Variable averages

Having defined the variables and arrived at clear names for them, the final step is to summarize the data. The mean for each subject and activity is computed, for each variable. The summary is stored in the data frame `har.summary`.

The script writes this data frame to the working directory as `tidyHARsummary.txt`, overwriting any existing file with that name.




