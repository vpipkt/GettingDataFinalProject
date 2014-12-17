
# Human Activity Recognition Code Book

This code book describes the experiment, the variables, the data, and all transformations performed to prepare the data for further analysis.  The purpose of this or any code book is to increase reproducibility of research and analysis.

## The experiment
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.  More information about the original research is [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  

The data was retrieved from a coursera-hosted sample of the data.

## Raw data
The raw data is provided in a compressed archive of flat text files. This includes meta-data (README.txt, features.txt, features_info.txt) and experimental data. The raw data is separated by subjects into two groups: testing and training, to support machine learning analysis.  The original research team pre-processed the smartphone  sensor signals (accelerometer and gyroscope). They applied noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings per window). Each window is provided as a "sample" in the raw data.

The accelerometer readings are in units of standard gravity (g). The gyroscope readings are in units of radians per second.

The test and training data contain the same set of variables:
* x (time and frequency)
* y (activity coding achieved by researchers tagging video of subject activity)
* research subject identifier
* body\_acc_x - body accelerometer reading in X direction
* body\_acc_y - body accelerometer reading in Y direction
* body\_acc_z - body accelerometer reading in Z direction (removes gravity)
* body\_gyro_x - gyroscope reading in X direction
* body\_gyro_y - gyroscope reading in Y direction
* body\_gyro_z - gyroscope reading in Z direction
* total\_acc_x - total accelerometer reading in X direction
* total\_acc_y - total accelerometer reading in Y direction
* total\_acc_z - total accelerometer reading in Z direction (includes gravity)

Test data has 2947 observations (windows). Training data has 7352 observations.

## Data processing
