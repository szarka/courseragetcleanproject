This course project works with public data from the Human activity Recognition Using Smartphones Data Set <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. Further information on the variables of interest is available in the zip file in features_info.txt.

For this project I used R version 3.1.0 (2014-04-10) running under Win64.

The zipped file obtained from the URL above was downloaded and extracted using the commented-out code at the top of run_analysis.R. This created a projectdata subdirectory and then the files were extracted using the hierarchy in the zip file.

The original dataset was split into subsets for training and testing, in the subdirectories UCI HAR Dataset/train and UCI HAR Dataset/test, respectively. I created a new data frame containing all the data, where each row was a single observation for a particular subject performing a particular activity. The first two columns were the IDs, labeled Subject and Activity. The remaining columns were the sensor readings provided in X_train.txt and X_test.txt.

Next I labeled the variables of interest using the names in features.txt, but removing "()" and substituting "_" for "-" to make it easier to use. I also changed the Activity ID to a factor using descriptive labels that are shorter versions of those found in activity_labels.txt.

Next I extracted only the variables that appeared to be measures of mean (with "mean" in their name) or standard deviation (with "std" in their name).

Finally, I melted and reshaped the data frame to summarize the observations with the average of each variable of interest for combinations of Subject and Activity. The result was written to the file reshaped.txt.

An R script that will reproduce my work is included in run_analysis.R.
