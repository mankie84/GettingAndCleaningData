run_analysis.R
========
created:08/02/2015
--------
The R script takes requires the full <UCI HAR Dataset> folder in your work directory.
At first, it checks whether the folder is present.
It then prepares all descriptive variables, containing the future column names for the tidy data set.
The script works in three steps to produce the tidy data set: at first all cleaning operations for the <test> dataset and then all cleaning operations on the <train> set. Finally, it merges both sets.
The R script analyzes the merged data and returns measurement averages for each variable, once per activity and subject and once grouped by both; activity and subject.
The analysis result is stored in mean_act (means per measurement and activity), mean_sub (mean per measurement and subject) and mean_all (mean per measurement over subject and activity).
In the end, the output from <mean_all> is written to the "result.txt" into the work directory.
