-- Exploratory Data Analysis-- 

SHOW DATABASES;
USE worlds_layoffs;

SHOW TABLES;

SELECT * FROM layoffs_staging1;
 
 SELECT MAX(total_laid_off),MAX(percentage_laid_off)
 FROM layoffs_staging1;
 
-- Finding all the Aggegrate Terms like SUM,MIN,MAX...---
SELECT * 
 FROM  layoffs_staging1
 WHERE percentage_laid_off =1
 ORDER BY funds_raised_millions DESC;
 
 SELECT company,SUM(total_laid_off)
 FROM layoffs_staging1
 GROUP BY 1
 ORDER BY 2 desc;
 
 SELECT MIN(`date`),MAX(`date`) 
 FROM layoffs_staging1;
 
  SELECT industry,SUM(total_laid_off)
 FROM layoffs_staging1
 GROUP BY industry
 ORDER BY 2 desc;
 
 SELECT * 
 FROM layoffs_staging1;

SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging1
GROUP BY YEAR(`date`)
ORDER BY 1 desc;

SELECT stage,SUM(total_laid_off)
FROM layoffs_staging1
GROUP BY stage 
ORDER BY 2 desc;

SELECT company,AVG(percentage_laid_off)
FROM layoffs_staging1
GROUP BY company
ORDER BY 2 desc;

-- Using Window Functions and finding Outputs--

SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off)
FROM layoffs_staging1
WHERE SUBSTRING(`date`,1,7) IS NOT NULL 
GROUP BY `MONTH`
ORDER BY 1 ASC;


WITH Rolling_Total AS 
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off) AS total_off
FROM layoffs_staging1
WHERE SUBSTRING(`date`,1,7) IS NOT NULL 
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`,total_off,
SUM(total_off)OVER(ORDER BY `MONTH`) AS rolling_total 
FROM Rolling_Total ;


SELECT company,SUM(total_laid_off)
FROM layoffs_staging1
GROUP BY company
ORDER BY 2 desc;


SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging1
GROUP BY company,YEAR(`date`)
ORDER BY 3 desc;

WITH Company_YEAR(company,years,total_laid_off)AS
(
SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging1
GROUP BY company,YEAR(`date`)
),Company_year_Rank AS 
(SELECT *,
DENSE_RANK()OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE Years IS NOT NULL 
) 
SELECT * 
FROM Company_year_Rank
WHERE Ranking <=5;



 