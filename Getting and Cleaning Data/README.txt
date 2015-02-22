The data set contains observations for 30 participants tht have been merged from the training and test sets. For each participant there is an activity (such as standing,walking ect) as well as the mean and standard deviations of metrics relating to the Samsung Galaxy s2 accelerometer. 

======================Each row represents=============================
- a unique subject_id,activity combination
- the mean and standard deviation for accelerometer metrics by activity, participant
=========================Justifications of data==========================
The concept of tidy data can be defined as:
1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

The current tiny dataset provided has 81 columns (each column being a variable). A good way of viewing whether or not the data meets our "Tidy Data" standard is to remember that we want the data to be accessible and made easy for analysis.

To satisfy these conditions I have modified the column names to exclude special characters that would make it difficult to reference said columns.

You will notice that the data satisfies all of the tidy data requirements and no data can have duplicate records beyond the unique identifier keys.
================================Script Work flow====================================
1. Read in X,Y,subject training data
	a. cbind data to merge into one data frame
	b. replace column names with column names from features.txt
2. Read in X,Y,subject test data
	a. cbind data to merge into one data frame
	b. replace column names with column names from features.txt
3. Merge two datasets into one data frame that includes training and test data
4. Replace activity labels with descriptions from activity_labels.txt
5. Group data by subject_id and activity_label to get the mean of each column
6. Remove special characters from tidy data frame to make referencing easier
7. Export tidy data frame to working directory
