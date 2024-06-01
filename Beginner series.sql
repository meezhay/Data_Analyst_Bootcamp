SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > '1985-01-01' or not gender = 'male';


-- LIKE STATEMENT: looks for a specific sequence, doesn't have to be an exact match
-- % mean anything, _ underscore means a specific value
-- % and _ can be combined
SELECT *
FROM employee_demographics
WHERE first_name LIKE '%n_';

-- Group by rows that have the same value in a specified column
-- after grouping, you can perform aggregate functions
-- whatever you are grouping by has to match in the select statement unless you're performing an aggregate function

SELECT gender, AVG(age), MAX(age), MIN(age), count(age)
FROM employee_demographics
group by gender;



-- order by sorts by ascending ot desc order
SELECT *
FROM employee_demographics
order by gender, age desc;
-- the ordering also matters, the column you place first matters
-- ordering by age first then gender, doesn't make sense because there aren't any unique value that are on the same row
-- you can order by positions of the field, e.g age is the 4th column

-- HAVING Clause
SELECT gender, avg(age)
FROM employee_demographics
group by gender
having avg(age) > 40;

-- Having vs WHere
SELECT occupation, avg(salary)
FROM employee_salary
WHERE occupation like '%manager%'
group by occupation
having avg(salary) >= 75000;

-- Limits & alaising
SELECT *
FROM employee_demographics
LIMIT 3
-- LIMIT 3,1 means start at position 3 and then 1 row after it;


