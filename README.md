GettingDataFinalProject
=======================

This is my final project submission for the Getting &amp; Cleaning Data class on Coursera.  This file explains how the various files are related.

OriginalCodeBook |    The files comprising the raw data code book are contained here. The original data is omitted from this repo due to size.
OriginalCodeBook\README.txt |  The general experimental design is discussed as well as the steps of pre-processing.
OriginalCodeBook\features_info.txt | Description of the columns, variables or features in each X_{test|train}.txt file
OriginalCodeBook\features.txt | Labels for every one of the 561 columns, variables, or features in X_{test|train}.txt file
CodeBook.md | The code book describing this analysis. It depends upon but does not repeat the original codebook.
run_analysis.R | If the UCI HAR dataset is in the working directory, this script produces the tidy data set for further analysis in the data frame `tidy.har`
other scripts.R | There could be other scripts. THese also must be in the working directory.



Various other files such as .gitignore and .Rhistory are not substantial to the course project submission.