-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
SELECT gender , Count(*)
From hr 
Where age > 18 AND termdate IS NOT NULL
GROUP BY gender;


-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race, COUNT(*) AS Count 
FROM hr 
WHERE age >= 18 AND termdate IS NOT NULL
GROUP BY race;
-- 3. What is the age distribution of employees in the company?
SELECT 
	CASE 
		WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
		WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
	END AS AGE_GROUP,gender,
    COUNT(*) AS COUNT 
FROM HR
WHERE age >= 18 AND termdate IS NOT NULL
GROUP BY AGE_GROUP,gender
ORDER BY AGE_GROUP;
    
-- 4. How many employees work at headquarters versus remote locations?
SELECT LOCATION , 
COUNT(*)
FROM hr 
WHERE age >= 18 AND termdate IS NOT NULL
GROUP BY LOCATION  ;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT 
    AVG(DATEDIFF(termdate, hire_date)) / 365 AS avg_years
FROM hr 
WHERE termdate <= CURDATE() AND termdate IS NOT NULL AND age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?
SELECT Gender , department ,
Count(*)
From Hr 
WHERE age >= 18 AND termdate IS NOT NULL
GROUP BY Gender , department  
Order by Gender , Department ;

-- 7. What is the distribution of job titles across the company?
SELECT Jobtitle ,
Count(*) AS COUNT 
From Hr 
WHERE age >= 18 AND termdate IS NOT NULL
GROUP BY Jobtitle ;

-- 8. Which department has the highest turnover rate?
SELECT 
    department,
    total_count,
    termination_count,
    termination_count / total_count AS termination_rate 
FROM (
    SELECT   
        department,
        COUNT(*) AS total_count,
        SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS termination_count
    FROM Hr 
    WHERE age >= 18 
    GROUP BY department
) AS subquery 
ORDER BY termination_rate DESC;
-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state , count(*) As count
FROM hr 
WHERE age >= 18 AND termdate IS NOT NULL
GROUP BY location_state
ORDER By location_state desc ;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT 
    YEAR,
    HIRES,
    TERMINATION,
    HIRES - TERMINATION AS NET_CHANGE,
    ROUND((HIRES - TERMINATION) / HIRES * 100, 2) AS NET_CHANGE_PERCENT
FROM (
    SELECT 
        YEAR(HIRE_DATE) AS YEAR,
        COUNT(*) AS HIRES,
        SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS TERMINATION
    FROM HR
    WHERE AGE > 18 
    GROUP BY YEAR(HIRE_DATE)
) AS SUBQUERY 
ORDER BY YEAR ASC;

-- 11. What is the tenure distribution for each department?
SELECT DEPARTMENT ,round(avg(datediff(TERMDATE , HIRE_DATE )/365),0) AS AVG_TENURE 
FROM HR 
WHERE  termdate IS NOT NULL and termdate <> curdate() AND age>=18 
group by DEPARTMENT ;

rollback;

