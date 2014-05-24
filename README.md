# Getting and Cleaning Data Course Project

Note: The output from this script are *.txt files even though they are in CSV format. This is to allow them to be uploaded to the Coursera assignment page.

The script run_analysis.R *must* be run in a directory with the UCI Human Activity Recognition dataset in the directory "UCI HAR Dataset". It will merge the training and test data, and then extract the mean and standard deviation fields (interpreted to be those with mean() and std() in the name). Approrpriate subject numbers and activity names will be appended to each row. This full dataset will be sorted by subject, then activity, and saved to full.txt. Finally, all measures will me averaged (grouped by activity and subject), and this final dataset will be output into tidy.txt

The codebook for understanding these files can be found in CodeBook.md