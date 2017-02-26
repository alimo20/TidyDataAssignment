This is the codebook for run_analysis.r 

The purpose of the code is to clean up the data set provided by the Human Activity Recognition Using Smartphones Dataset.

The code is one script split in sections by comments.

The first section loads the data using standard read.table. Some of the data have column names assigned. 
Next the "X" data (main measurements) are combined

The column names are attached.

The remaining training and test data for the subjects and activities are separately made into individual datasets. 

The relavant features are extracted by a regex based search. 

Activity and Subject IDs are attached. 

Column names are updated to (slightly) more descriptive names

Finally the data is summarized by Subject and Activity and the average of the resulting interaction is taken.

The data is written out. 



