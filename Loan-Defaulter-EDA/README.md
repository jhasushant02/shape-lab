# Bank Loan Defaulter Analysis

## Introduction
This project was created to learn the fundamentals of data analytics. 
The following YouTube channels were used to learn the necessary concepts:

* Code Basics: https://www.youtube.com/@codebasics
* Tech Classes: https://www.youtube.com/@techclasses0810

Apart from them, I have used the following resources too
* https://github.com/yashpaneliya/Bank-Loan-Default-Analysis.git
* ChatGPT & Denigma Code Explainer (https://denigma.app/) to know about code properly


This is totally a beginner project, so some of the codes have been explained in detail in the Jupyter Notebook. 

Please feel free to check it out!



## Problem Statement

Conduct a thorough study of data relevant to bank loan defaulters and extract key insights in order to aid the financial institution in improving its loan default prediction skills.

## Data

The data is taken from [Kaggle](https://www.kaggle.com/datasets/gauravduttakiit/loan-defaulter) which is a dataset of bank loan defaulters. 

*Data dimensions: 3,07,511 records and 122 features*

## Analysis

- Checked null value percentage in each column
- Checked the distribution of each column
- Checked the correlation between columns and target variable
- Removed unneccessary columns that do not contribute to predict target
- Visualized the count of defaulters and non-defaulters in the dataset for several categorical columns
- Standardized the data
- Binning the numerical columns to view the distribution of defaulters and non-defaulters according to ranges
- Replaced the null values with the measures of central tendency according to the type of column from NOIR classification
- Outlier detection using boxplots
- Drew insights by plotting the final features with target prepared after all the above steps

