# ECBS-6233
This is the final project output for ECBS-6233: Empirical Research Methods.

**Setup:**

This is the improved replication package for David Deming's 2017 paper about the importance of social skills on the labour market:

Deming, David (2017) “The Growing Importance of Social Skills in the Labor Market”, _The Quarterly Journal of Economics_, 132:4, 1593-1640.

The replication package is available at:
Deming, David (2017) "Replication Data for: "The Growing Importance of Social Skills in the Labor Market", _Harvard Dataverse, V1._ [Online] Available at: https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/CYPKZH, last accessed: 5 January 2022.

The following changes were made to improve reproducibility:
- changing absolute paths to relative paths in .do files
- reworking the .do files so that cleaning and analysis are clearly separated
- renaming the abbreviations in .do files
- creating a new .do file which executes the new routine
- creating a Makefile alternative to the new master .do file

**Running the replication:**

First, you need to copy the "Data" folder from the replication package (accessible on the link above) into the main folder. Then, you can do one of the following things:

1. Run new_master.do directly in Stata.
2. Run the Makefile.
