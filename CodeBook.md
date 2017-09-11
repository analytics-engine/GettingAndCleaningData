The only transformations required for this script was the cleaning up of the
features which would be used as column headers.  The feature text is unchanged
with the exception of the removal of parentheses and the replacement of hyphens
(-) with underscores.  This maintained the technical accuracy of the column
headers while enabling the headers to be used within R.

Examples:
	1.  tBodyAcc-mean()-X	became	tBodyAcc_mean_X
	2.  fBodyGyro-mean()-Y	became	fBodyGyro_mean_Y
