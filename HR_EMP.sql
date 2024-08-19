CREATE DATABASE HumanResource;

USE HumanResource;

SELECT * FROM HR;

ALTER TABLE HR
CHANGE COLUMN ï»¿id emp_id varchar(20) null;

DESCRIBE HR;

SELECT 	birthdate FROM HR;

SET sql_safe_updates = 0;

UPDATE HR
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%d-%m-%Y')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%d-%m-%Y')
    ELSE null
END;

UPDATE HR
SET birthdate = CASE
	WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%d-%m-%Y'), '%Y-%m-%d')
    ELSE null
END;

ALTER TABLE HR
MODIFY COLUMN birthdate DATE;

SELECT 	birthdate FROM HR;

UPDATE HR
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%d-%m-%Y')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%d-%m-%Y')
    ELSE null
END;
UPDATE HR
SET hire_date = CASE
	WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%d-%m-%Y'), '%Y-%m-%d')
    ELSE null
END;
ALTER TABLE HR
MODIFY COLUMN hire_date DATE;

ALTER TABLE HR
DROP COLUMN  termdate;

ALTER TABLE HR 
ADD COLUMN age int;

update HR
set age = timestampdiff(year, birthdate, curdate());

select birthdate, age from HR;

select 
	min(age) as youngest,
	max(age) as oldest
from HR;

select count(*) from HR
where age < 18;

select * from HR;

-- Problems

-- 1. What is the gender breakdown of employees in the company?
select gender, count(emp_id) as count
from HR
where age >= 18 
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race, count(emp_id) as count
from HR
where age >= 18
group by race
order by count desc;

-- 3. What is the age distribution of employees in the company?
select 
	min(age) as youngest,
    max(age) as oldest
from HR
where age >= 18;

select 
	case
		when age >=18 and age < 24 then '18-24'
        when age >=25 and age < 34 then '25-34'
        when age >=35 and age < 44 then '35-44'
        when age >=45 and age < 54 then '45-54'
        when age >=55 and age < 64 then '55-64'
        else '65+'
	end as age_group,
    count(emp_id) as count
from HR
where age >= 18
group by age_group
order by age_group;

-- 4. How many employees work at headquarters versus remote locations?
select location, count(emp_id) as count
from HR
where age >=18
group by location
order by count desc;

-- 5. How does the gender distribution vary across departments and job titles?
select department, jobtitle, gender, count(emp_id) as count
from HR
where age >=18
group by department, jobtitle, gender
order by department;


-- 6. What is the distribution of job titles across the company?
select jobtitle, count(emp_id) as count
from HR
where age>=18
group by jobtitle
order by count desc;


-- 7. What is the distribution of employees across locations by city and state?
select location_state, location_city, count(emp_id) as count
from HR
where age >= 18
group by location_state, location_city
order by location_state;















