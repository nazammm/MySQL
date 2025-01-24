# Data Cleaning and Transformation in SQL

This SQL script demonstrates a complete workflow for cleaning and transforming data in the `study case` table. The steps involve several data cleaning tasks such as removing duplicates, handling missing values, formatting columns, and creating new datasets. Below is the explanation of each step along with the SQL code to implement it.

## 1. Add `id` Column with Auto Increment Primary Key

This step adds an `id` column to the `study case` table with auto-increment enabled to uniquely identify each row.

```sql
ALTER TABLE `study case` ADD COLUMN `id` INT AUTO_INCREMENT PRIMARY KEY;
```
## 2. Remove Duplicates
Here, we identify and keep the first entry for each group of duplicates based on the following columns: Date Adjust, Source, Category, SKU, Location, Value, and Value to IDR.

```sql
WITH CTE AS (
    SELECT MIN(`id`) AS keep_id
    FROM `study case`
    GROUP BY `Date Adjust`, `Source`, `Category`, `SKU`, `Location`, `Value`, `Value to IDR`
)
DELETE FROM `study case`
WHERE `id` NOT IN (SELECT keep_id FROM CTE);
```
## 3. Replace Empty Values with 0
This part ensures that any empty string values in the Value and Value to IDR columns are replaced with 0.

```sql
UPDATE `study case`
SET `Value` = 0
WHERE `Value` = '';	

UPDATE `study case`
SET `Value to IDR` = 0
WHERE `Value to IDR` = '';
```
## 4. Remove Commas in Numeric Columns
Commas in numeric fields can interfere with calculations, so we replace them with nothing to clean the data.

```sql
UPDATE `study case`
SET `Value` = REPLACE(`Value`, ',', '');

UPDATE `study case`
SET `Value to IDR` = REPLACE(`Value to IDR`, ',', '');

UPDATE `study case`
SET `Gross Profit` = REPLACE(`Gross Profit`, ',', '');
```
## 5. Modify Columns to DECIMAL Format
Here, we modify the columns Value, Value to IDR, and Gross Profit to have a decimal format with three places after the decimal.

```sql
ALTER TABLE `study case`
MODIFY COLUMN `Value` DECIMAL(15,3),
MODIFY COLUMN `Value to IDR` DECIMAL(15,3),
MODIFY COLUMN `Gross Profit` DECIMAL(15,3);
```
## 6. Replace Hyphens with Spaces in Text Columns
In the Category and SKU columns, we replace any hyphens (-) with spaces.

```sql
UPDATE `study case`
SET Category = REPLACE(Category, '-', ' ');

UPDATE `study case`
SET `SKU` = REPLACE(`SKU`, '-', '');
```
## 7. Update Location Values
In the Location column, we map specific location names to their abbreviations. For instance, 'Indonesia' is changed to 'ID', and 'Singapore' and 'Overseas' are changed to 'SG'.

```sql
UPDATE `study case`
SET `Location` = CASE
    WHEN `Location` = 'Indonesia' THEN 'ID'
    WHEN `Location` IN ('Singapore', 'Overseas') THEN 'SG'
    ELSE `Location`
END;
```
## 8. Remove Rows with Zero Values
We delete any rows where the Value column is 0 because these rows are considered invalid for analysis.

```sql
DELETE FROM `study case`
WHERE `Value` = 0;
```
## 9. Calculate Value to IDR for Singapore Location
If the Value to IDR column is 0 for entries from Singapore, we multiply the Value by 1100 to convert it into IDR.

```sql
UPDATE `study case`
SET `Value to IDR` = ROUND(`Value` * 1100, 3)
WHERE `Location` = 'SG'
  AND `Value to IDR` = '0';
```
## 10. Calculate Gross Profit Based on Value to IDR
We calculate the Gross Profit as 25% of the Value to IDR for any rows where Gross Profit is still 0.

```sql
UPDATE `study case`
SET `Gross Profit` = ROUND(`Value to IDR` * 0.25, 3)
WHERE `Gross Profit` = '0';
```
## 11. Remove Invalid Date Adjust Values
We delete rows where the Date Adjust is empty or contains invalid data.

```sql
DELETE FROM `study case`
WHERE `Date Adjust` = '' OR `Date Adjust` = '44714';
```
## 12. Change Date Adjust to Date Format
Finally, we modify the Date Adjust column to the proper DATE format for consistency.

```sql
ALTER TABLE `study case`
MODIFY COLUMN `Date Adjust` DATE;
```
## 13. Create Table for Canceled Cases
We create a separate table for rows where the Source is 'Cancel' or the Category is 'canceled'.

```sql
CREATE TABLE `Canceled` AS
SELECT *
FROM `study case`
WHERE `Source` = 'Cancel' OR `Category` = 'canceled';
```
## 14. Remove Canceled Cases from the Main Table
We remove the rows that were marked as canceled from the main study case table.

```sql
DELETE FROM `study case`
WHERE `Source` = 'Cancel' OR `Category` = 'canceled';
```
