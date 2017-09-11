Getting and Cleaning Data Course Project
Michael Wood

run_analysis.R README.md

The script "run_analysis.R" is run within the same directory as the unzipped
data set supplied by the course.  The directory should contain a directory
called "UCI HAR Dataset".

The script reads the required text files into variables one at a time and
prepares them for binding into a monolithic data set.  Certain data sets
required manipulation to get them into usable formats.

	The "features" data set which contained characters poorly suited to 
	column headers.

	The y data set was transformed from numerical values into a human
	readable format

	Column headers were added each column of data

Once these tranformations were completed, the columns were bound into a single
data set.  From this data set, the required columns, Subject, Activity, and
columns containing means and standard deviations were pulled from the data set
and inserted into a new data table.

This table was grouped and summarized to provide the final tidy data set.
