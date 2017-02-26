=========
Coursera Data Spealization
Getting and Cleaning Data Assignment
==========

Ali Murat Okur

This project is craeted to make the data originally created by the Human Activity Recognition Using Smartphones Dataset into a tidy format.

The script tidyMe.R takes as input the 8 data files provided by the project at www.smartlab.ws

It re-organizes, attaches additional descriptors and eventually groups the data by Subject and Activity for each of the variables calculating a mean or standard deviation. All the data points were then averaged. The script additionaly renames the column names to a more human readable format. 

The column names in the final file follow the following format:

[Mean/STD][Body/Gravity][Accel/Gyro][/F]-[X/Y/Z]

Where:
 - Mean/STD refers to whether this a mean or a standard deviation measurement
 - Body/Gravity refers to whether this is measurement taken from the gravity or the body motion portion of the accelerometer
 - Accel/Gyro refers to whether the measurement is from the accelerometer or gyroscope
 - /F flag refers to whether the measurement was a run though a fourier transformation. If blank then it was a time series measurement
 - X/Y/Z refers to the axis on which the measurement originated, if applicable. 
 
 
Contents:
 - This readme file
 - run_analysis.r : the script that performs the manipulations
 - codebook.md : code book for the project
 
 
 
 
