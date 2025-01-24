# Data Cleaning and Transformation in SQL
This repository demonstrates a complete workflow for cleaning and transforming data in SQL.
It includes a step-by-step SQL script designed to handle common data cleaning tasks such as
removing duplicates, handling missing values, formatting columns, and creating new datasets.

## Repository Contents
- script.sql: The main SQL script that performs cleaning and transformation tasks.
- sample_data.csv: A sample dataset (dummy data) used to replicate the SQL cleaning process.
- README.md: Documentation of the SQL script with detailed explanations for each step.

## Key Features
1. Duplicate Removal
    - Uses a Common Table Expression (CTE) to identify and keep only unique rows based on specific columns.
 
2. Handling Missing Values
    - Replaces empty or null values in numeric columns with `0`.
 
3. Data Normalization
    - Formats numeric columns by removing unwanted characters.
    - Converts date columns to the correct `DATE` format.
 
4. Derived Calculations
    - Calculates new values such as `Value to IDR` (conversion to local currency) and `Gross Profit`.
 
5. Data Segmentation
    - Extracts and moves canceled transactions to a separate table named `Canceled`.

## Tools Used
- SQL

This repository demonstrates a complete workflow for cleaning and transforming data in SQL.
It includes a step-by-step SQL script designed to handle common data cleaning tasks such as
removing duplicates, handling missing values, formatting columns, and creating new datasets.

## Repository Contents
- script.sql: The main SQL script that performs cleaning and transformation tasks.
- sample_data.csv: A sample dataset used to replicate the SQL cleaning process.
- README.md: Documentation of the SQL script with detailed explanations for each step.

## Key Features
1. Duplicate Removal
    - Uses a Common Table Expression (CTE) to identify and keep only unique rows based on specific columns.
 
2. Handling Missing Values
    - Replaces empty or null values in numeric columns with `0`.
 
3. Data Normalization
    - Formats numeric columns by removing unwanted characters.
    - Converts date columns to the correct `DATE` format.
 
4. Derived Calculations
    - Calculates new values such as `Value to IDR` (conversion to local currency) and `Gross Profit`.
 
5. Data Segmentation
    - Extracts and moves canceled transactions to a separate table named `Canceled`.

## Sample Data Structure
# Here's a preview of the dataset structure used in the script:

| Date Adjust | Source  | Category | SKU       | Location   | Value | Value to IDR | Gross Profit |
|-------------|---------|----------|-----------|------------|-------|--------------|--------------|
| 2023-01-01  | Source 1| Food     | SKU123456 | Indonesia  | 320000| 320000       | 80000        |
| 2023-01-02  | Source 2| Beverage | SKU234567 | Singapore  | 100   | 110000       | 27500        |
