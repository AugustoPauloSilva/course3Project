# course3Project

This code works as described below.

First the code search for the complete files, that combines the test and train data from the original dataset.
The files are created if needed, that is the first portion of code.

After this step, the data is loaded into R, filtering only the needed data from the original vector.
It is also added the required labels and variables from other files, making sure to create a tidy dataset.
After the completion of the tidy dataset (step 4), another variable is used to create the final dataset (step 5).

This dataset is the result of grouping by activity and subject and calculating the average of all columns.
In the end, the resulting dataset is saved using the write.table function
