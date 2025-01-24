USE bussiness_analyst;
ALTER TABLE `study case` ADD COLUMN `id` INT AUTO_INCREMENT PRIMARY KEY;

WITH CTE AS (
    SELECT MIN(`id`) AS keep_id
    FROM `study case`
    GROUP BY `Date Adjust`, `Source`, `Category`, `SKU`, `Location`, `Value`, `Value to IDR`
)
DELETE FROM `study case`
WHERE `id` NOT IN (SELECT keep_id FROM CTE);

UPDATE `study case`
SET `Value` = 0
WHERE `Value` = '';	
UPDATE `study case`
SET `Value to IDR` = 0
WHERE `Value to IDR` = '';	

UPDATE `study case`
SET Value = REPLACE(Value, ',', '');
UPDATE `study case`
SET `Value to IDR` = REPLACE(`Value to IDR`, ',', '');
UPDATE `study case`
SET `Gross Profit` = REPLACE(`Gross Profit`, ',', '');

ALTER TABLE `study case` 
MODIFY COLUMN `Value` DECIMAL(15,3),
MODIFY COLUMN `Value to IDR` DECIMAL(15,3),
MODIFY COLUMN `Gross Profit` DECIMAL(15,3);

UPDATE `study case`
SET Category = REPLACE(Category, '-', ' ');
UPDATE `study case`
SET `SKU` = REPLACE(`SKU`, '-', '');

UPDATE `study case`
SET `Location` = CASE
    WHEN `Location` = 'Indonesia' THEN 'ID'
    WHEN `Location` IN ('Singapore', 'Overseas') THEN 'SG'
    ELSE `Location`
END;

DELETE FROM `study case`
WHERE `Value` = 0;

UPDATE `study case`
SET `Value to IDR` = ROUND(`Value` * 1100, 3)
WHERE `Location` = 'SG' 
  AND `Value to IDR` = '0';

UPDATE `study case`
SET `Gross Profit` = ROUND(`Value to IDR` * 0.25, 3)
WHERE `Gross Profit` = '0';

DELETE FROM `study case`
WHERE `Date Adjust` = '' OR `Date Adjust` = '44714';

ALTER TABLE `study case`
MODIFY COLUMN `Date Adjust` DATE;

CREATE TABLE `Canceled` AS
SELECT *
FROM `study case`
WHERE `Source` = 'Cancel' OR `Category` = 'canceled';
DELETE FROM `study case`
WHERE `Source` = 'Cancel'OR `Category` = 'canceled';