-- joins allows you to join two or more tables if they have a common column, the col names don't have to be the same
SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- inner join return rows that are the same in both tables
SELECT *
FROM employee_demographics dem
INNER JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id;
    
-- left join
SELECT *
FROM employee_demographics dem
left JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id;
    
-- RIGHT join
SELECT *
FROM employee_demographics dem
RIGHT JOIN employee_salary sal
	ON dem.employee_id=sal.employee_id;

-- SELF join
SELECT sal1.first_name as 'secret santa', sal2.first_name as employee
FROM employee_salary sal1
JOIN employee_salary sal2
	ON sal1.employee_id + 1=sal2.employee_id;
    
-- SELF join
SELECT sal1.first_name as 'secret santa', sal2.first_name as employee
FROM employee_salary sal1
JOIN employee_salary sal2
	ON sal1.employee_id <> sal2.employee_id;
    

SELECT *
from parks_departments;

-- joining multiple tables
select *
FROM employee_demographics dem
inner join employee_salary sal
	ON dem.employee_id=sal.employee_id
inner join parks_departments pd
on sal.dept_id=pd.department_id;


-- Unions allwos you to combine rows together
-- union returns distinct values
select first_name
FROM employee_demographics 
UNION 
select first_name
FROM employee_salary;

-- union all returns duplicates
select first_name, last_name
FROM employee_demographics
UNION all
select first_name, last_name
FROM employee_salary;

-- use case
select first_name, last_name, 'old man' as label
FROM employee_demographics 
where age > 40 and gender = 'Male'
union
select first_name, last_name, 'old lady' as label
FROM employee_demographics 
where age > 40 and gender = 'female'
UNION 
select first_name, last_name, 'Highly paid employee' as label
FROM employee_salary
where salary > 70000
order by first_name, last_name;



-- string functions -- 
select first_name, length(first_name)
from employee_demographics
order by 2
;

select first_name, Upper(first_name)
from employee_demographics;

-- trim, left trim, right trim; trim takes away space from the front or end
SELECT TRIM ('       up           ');
-- SELECT LTRIM OR RTRIM

select first_name, 
left(first_name,4),
-- basically saying how many characters from the left hand side do we want to select
right(first_name,4)
from employee_demographics;

-- substrings
select first_name, 
left(first_name,4),
-- basically saying how many characters from the left hand side do we want to select
right(first_name,4),
-- using substring instead of left or right
substring(first_name,3,2) 
-- this means we start at the 3rd position, and how many characters we want in this case 2 
from employee_demographics;

-- substring use case
select first_name, 
substring(first_name,3,2),
birth_date, substring(birth_date,6,2) as birth_month
-- this means we start at the 3rd position, and how many characters we want in this case 2 
from employee_demographics;

-- replace: will replace specific characters with a new one
select first_name, replace(first_name, 'a', 'z')
from employee_demographics;

-- Locate 
select locate('a', 'Kat');

select first_name, Locate('An', first_name)
from employee_demographics;

-- concate
select first_name, last_name, concat(first_name, ' ', last_name) as full_name
from employee_demographics;
