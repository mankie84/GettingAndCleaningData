codebook for run_analysis.R
=========
created:08/02/2015
-----------------
based on:
subject, activity, measurement and value from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

result.txt:
1. The file contains 4 variables over 3440 rows
2. Each row represents one type of measurement per one type of subject and activity
3. activity is a factor variable with 6 levels, in accordance with source (see link above)
4. subject is an integer variable with 30 values, in accordance with source (see link above)
5. measurement is a factor variable with 86 levels, representing the names of all mean and standard-deviation variables from the source files (see link above)
6. mean(value) is a numeric variable representing the mean() of all measurements