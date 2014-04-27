Code book for the project in Getting and Cleaning Data
------------------------------------

### Data source and raw data format

The dataset contain measurements from a motion sensor in a smartphone on 20 different subjects performing 6 different activities. 
The exact details of the measurement process and the pre-processing steps are described in "README.txt" and "features_info.txt" in the directory "UCI HAR Dataset".


The provided data were split up into a test dataset and a training dataset, and within these two datasets, the variables were split into 3 files which contains the following variables:

* The subject ID : integer (values are 1-20)
* The activity of the subject : coded as an integer, where the codes are seen in the file "activity_labels.txt"
* The feature matrix with all the measured parameters. See "UCI HAR Dataset/README.txt" and "features_info.txt" for further detail.


### Data processing

Each of the raw datasets were read into R, and the dataset was transformed as follows:

* The activity coding was changed from integer to the name of the activity. E.g., "1" was changed to "WALKING".

* Only the features containing mean and standard deviation measurement should be extracted, so the indeces of these variables in the feature matrix were found.

* The datasets were then joined to form a 10299 x 68 dataframe. There were multiple measurements for the same subject/activity combination.

* Using `melt()` and `dcast()` the mean value of each feature for each subject/activity combination was calculated, and the resultant dataframe was written as a tab-separated file "tidy_data.txt" to the working directory.


