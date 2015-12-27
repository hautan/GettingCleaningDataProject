Codebook

# Code Book

The generated output saved in tidydata.txt fields are summarized bellow:

## Identifiers

* subjectId - The ID of the test subject
* activityType - The type of activity performed when the corresponding measurements were taken

## Activity Labels

* WALKING (value 1): subject was walking during the test
* WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
* WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
* SITTING (value 4): subject was sitting during the test
* STANDING (value 5): subject was standing during the test
* LAYING (value 6): subject was laying down during the test

## Measurement Means

All variables are the mean of a measurement for each subject and activity. 
This is indicated by the initial Mean in the variable name. 
All values are floating point numbers.
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions

#Time domain body acceleration mean:
* timeBodyAccMean-X
* timeBodyAccMean-Y
* timeBodyAccMean-Z


#Time domain body acceleration standard deviation:
* timeBodyAcc-std-X
* timeBodyAcc-std-Y
* timeBodyAcc-std-Z

#Time domain gravity acceleration mean:
* timeGravityAccMean-X
* timeGravityAccMean-Y
* timeGravityAccMean-Z

#Time domain gravity acceleration standard deviation:
* timeGravityAcc-std-X
* timeGravityAcc-std-Y
* timeGravityAcc-std-Z
