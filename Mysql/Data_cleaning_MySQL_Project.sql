-- Data Cleaning-- 

SHOW DATABASES;
USE Worlds_layoffs;
SHOW tables;

SELECT * 
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT * 
FROM layoffs;

-- Finding Duplicates--

SELECT *,
ROW_NUMBER()OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,
							country,funds_raised_millions ORDER BY company) AS RN
FROM layoffs_staging;
				
WITH FD AS 
(
SELECT *,
ROW_NUMBER()OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,
							country,funds_raised_millions ORDER BY company) AS RN
FROM layoffs_staging
)
SELECT * 
FROM FD
WHERE RN >1;

CREATE TABLE `layoffs_staging1` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `Row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT layoffs_staging1
SELECT *,
ROW_NUMBER()OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,
							country,funds_raised_millions ORDER BY company) AS RN
FROM layoffs_staging;

-- Deleting Duplicates--
SELECT * FROM layoffs_staging1;
DELETE FROM layoffs_staging1
WHERE  Row_num>1;

-- Standardizing the Data--
 SELECT * FROM layoffs_staging1;
 
SELECT company,TRIM(company)
 FROM layoffs_staging1;
UPDATE layoffs_staging1
SET company = TRIM(company);

SELECT DISTINCT industry
 FROM layoffs_staging1;
 UPDATE layoffs_staging1
 SET industry = 'crypto'
 WHERE industry LIKE 'cryp%';
 
SELECT DISTINCT country
 FROM layoffs_staging1;
 UPDATE layoffs_staging1
 SET country = TRIM(TRAILING '.' FROM country) 
 WHERE country LIKE 'UNIT%';
 
 ALTER TABLE layoffs_staging1
 DROP COLUMN Row_num;
 
 SELECT `DATE`,str_to_date(`date`, '%m/%d/%Y')
 FROM layoffs_staging1;
UPDATE layoffs_staging1
SET `DATE` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging1
MODIFY COLUMN `Date` date;

 -- Null values and Blank Values-- 
  SELECT * FROM layoffs_staging1;
  
UPDATE layoffs_staging1
SET industry = NULL 
WHERE industry = '';

 SELECT t1.industry,t2.industry FROM layoffs_staging1 t1 
 JOIN layoffs_staging1 t2
 ON t1.company = t2.company 
 WHERE t1.industry is null 
 AND t2.industry is not null;
 
SELECT *
FROM layoffs_staging1 t1 
JOIN layoffs_staging1 t2 
    ON t1.company = t2.company 
 WHERE t1.industry is null 
 AND t2.industry is not null;
 
 -- Removing Columns--
SELECT * FROM layoffs_staging1;

 DELETE FROM layoffs_staging1
 WHERE total_laid_off IS NULL 
 AND percentage_laid_off IS NULL;
 
 -- FINALL OURPUT--
 SELECT * 
 FROM layoffs_staging1;






