# getting-and-cleaning-data

The script gets data from analysis of fitness band the steps used for analysis are below
Step 1: load labels and feature which are used for labelling the activity and columns for the x_* files

Step 2: Loading Train Data
  Step 2a: Using the data in feature.txt rename the column names for x_train
  Step 2b: Extract only measures with Mean and STD for train data.
  Step 2c: combine subject_train, y_train, x_train, and then labels. to combine Subject ID, the Activity and the data.

Step 3: Loading Test Data
  Step 3a: Using the data in feature.txt rename the column names for x_test
  Step 3b: Extract only measures with Mean and STD for train data.
  Step 3c: combine subject_test, y_test, x_test, and then labels. to combine Subject ID, the Activity and the data.

Step 4: Create the tidy data set

Step 5: Write the tidy data set to a file

