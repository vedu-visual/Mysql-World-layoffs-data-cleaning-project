-- Data Cleaning, EDA Project For World_layoffs Data

SELECT * 
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the data
-- 3. Null Values or blank values
-- 4. Remove Any columns 

-- 1. Remove Duplicates 
-- As we don't have primary key hence we will create similar value to it

SELECT * 
FROM layoffs; 

-- created Backup table 

CREATE TABLE world_layoffs.layoffs_staging 
LIKE world_layoffs.layoffs;

INSERT layoffs_staging 
SELECT * FROM world_layoffs.layoffs;

SELECT *
FROM layoffs_staging;

SELECT * , 
ROW_Number() OVER(
					Partition BY Company,location,industry, total_laid_off, 
                    percentage_laid_off , date
)  AS row_num
FROM layoffs_staging;	

WITH DUPLICATE_CTE AS
(
SELECT * , 
ROW_Number() OVER(
					Partition BY Company,location,industry, total_laid_off, 
                    percentage_laid_off , date, stage, country, funds_raised_millions
                    )AS row_num
FROM layoffs_staging	
)
SELECT * FROM DUPLICATE_CTE
WHERE row_num > 1;		
-- Created Backup ,operational table
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT * , 
ROW_Number() OVER(
					Partition BY Company,location,industry, total_laid_off, 
           percentage_laid_off , date, stage, country, funds_raised_millions
)  AS row_num
FROM layoffs_staging;	

DELETE  
FROM layoffs_staging2
WHERE row_num >1;

-- AS All 5 Duplicates are deleted SO, Now lets Standardize the data

SELECT DISTINCT Company 
 FROM layoffs_staging2 
 Order By 1;
 
 Update layoffs_staging2
 SET Company = TRIM(Company)
 Order By company;
 
 -- Trimming Done for company now shift to field 'Industry'
 
 SELECT DISTINCT industry
 FROM layoffs_staging2 
 Order By 1;
 
SELECT  industry
 FROM layoffs_staging2 
 WHERE industry LIKE 'Crypto%'
 Order By 1; 
 
 UPDATE layoffs_staging2 
 SET industry = 'Crypto'
 WHERE industry LIKE 'Crypto%'
 Order By industry;

SELECT DISTINCT industry
 FROM layoffs_staging2 ;
 
 -- Combined 3 into 1 'Crypto' GROUP of industries
 
 SELECT * 
 FROM  layoffs_staging2 ;
 
 -- Done with Comapnies, industries  Now move on to the locations field
 
 SELECT DISTINCT location
 FROM layoffs_staging2
 Order By 1 ;
 
 -- Looks good now country field
 
 SELECT DISTINCT Country
 FROM layoffs_staging2
 Order By 1 ;
 
-- Yes , We Found 2 United states but 1 with '.'
-- Let's clear the issue

SELECT DISTINCT Country ,TRIM(Trailing '.' FROM COUNTRY) 
 FROM layoffs_staging2
 Order By 1 ;
 
 -- Cleared , Now let's Update the field
 
 Update layoffs_staging2
 SET country  = TRIM(Trailing '.' FROM COUNTRY)
 WHERE country like 'United States%';
 
 SELECT * 
 FROM layoffs_staging2
 Order By Country;
 
 -- Let's Go to Dates and convert them to standard date format so that inaccuracies are tackled
 
 SELECT `date`
 FROM layoffs_staging2
 Order By 1 ;
 
 UPDATE layoffs_staging2
 SET `date` = str_to_date(`date` , '%m/%d/%Y');
 
 -- As date field data type is text ; let's change it to date
 
 ALTER TABLE layoffs_staging2
 MODIFY COLUMN `date` DATE ;
 
 SELECT * 
 FROM layoffs_staging2;
 
 -- Now Nulls are remaining let's deal with them
 
 SELECT * 
FROM world_layoffs.layoffs_staging2;

-- if we look at industry it looks like we have some null and empty rows, let's take a look at these
SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY industry;

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- let's take a look at these
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company LIKE 'Bally%';
-- nothing can be done as only one record available
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company LIKE 'airbnb%';

-- it looks like airbnb is a travel, but this one just isn't populated.
-- I'm sure it's the same for the others. What we can do is
-- write a query that if there is another row with the same company name, it will update it to the non-null industry values
-- makes it easy so if there were thousands we wouldn't have to manually check them all

-- we should set the blanks to nulls since those are typically easier to work with
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- now if we check those are all null

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- now we need to populate those nulls if possible

SELECT t1.industry,t2.industry
FROM  layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
AND t1.location  = t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Now let's update the NULLS in industry

UPDATE  layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET  t1.industry  = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- and if we check it looks like Bally's was the only one without a populated row to populate this null values
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

SELECT * 
FROM layoffs_staging2;


-- Good so far Now drop the columns and rows which are not good fit for our data anlaysis 

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL;


SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Delete Useless data we can't really use
DELETE 
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * 
FROM world_layoffs.layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


SELECT * 
FROM world_layoffs.layoffs_staging2;

-- This is the final data for our EDA processing 
