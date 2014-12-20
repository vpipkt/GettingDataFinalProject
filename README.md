Getting and Cleaning Data Final Project
=======================

This is my final project submission for the Getting &amp; Cleaning Data class on Coursera.  This README explains how the various files are related.  The table summarizes each file. More detail is below.

## In Brief

| Folder\File | Summary |
| ----|----|
|`README.md`| Orientation to the repository.|
|`OriginalCodeBook\` |    The files comprising the raw data code book are contained here. The original data is omitted from this repo due to size|
|`OriginalCodeBook\README.txt` |  The general experimental design is discussed as well as the steps of pre-processing.|
|`OriginalCodeBook\features_info.txt` | Description of the columns, variables or features in each X.txt file|
|`OriginalCodeBook\features.txt` | Labels for every one of the 561 columns, variables, or features in X.txt file|
|`CodeBook.md` | The code book describing this analysis. It depends upon but does not repeat the original codebook.|
|`run_analysis.R` | If the UCI HAR dataset is in the working directory, this script produces the tidy data set for further analysis in the data frame `tidy.har`|
| `tidyHARsummary.txt` | The output of the run_analysis.R script |


Various other files such as .gitignore and .Rhistory are not substantial to the course project submission.

## Details

### tidyHARsummary.txt
This is the tidy data set summarizing, by subject and activity, the mean of each variable. The data here is in the "wide" format. Basically this takes the perspective that some unspecified further analysis would interpret each column presented here as separate variables.  For example, one can assert that, for example tBodyAccJerk-mean()-X and tBodyAccJerk-mean()-Y should not be reduced to two variables tBodyAccJerk and axis.  This submission recognizes, but does not pursue as variables, the inherent structure in the set of variables described. Observe for instance the variable naming grammer (step 4 of both the code book and script).  Further discussion of the "wide" versus "long" perspectives, see [this post](https://class.coursera.org/getdata-016/forum/thread?thread_id=100)

### CodeBook.md
This describes in a general fashion the steps taken to arrive at the tidy summary of the data. It makes reference to the original code book, but does not repeat it in detail.  If anything, this CodeBook should clarify and amplify the original code book.  The code book describes the role of the Inertial Signals subdirectories versus the X\_test and X\_train files.

### run\_analysis.R 

This R script contains all code to reproduce the analysis. It requires the reshape2 package to be installed. Given that the working directory contains the UCI HAR Dataset, it will run all analysis steps and write the tidy summary to the working directory as `tidyHARsummary.txt`.  The script will produce two data frames of interest.  `har.summary` is the tidy data frame summarizing the means of each variable by subject and activity.  `har.data` is the main dataset with each observation (time window) and additional identifying variables.
