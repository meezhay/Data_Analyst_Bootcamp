-- case statements allows you to add logic in your select statement
-- kind of like an if else statement

select first_name, 
last_name, age,
CASE
	WHEN age <= 30 then 'Young'
    WHEN age between 31 and 50 then 'old'
    when age >= 50 then "on death's door"
END as age_bracket
from employee_demographics;


-- Pay increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% Bonus

Select employee_id, first_name, last_name, salary,
CASE 
	WHEN salary < 50000 then salary * 1.05
    when salary > 50000 then salary * 1.07
END as new_salary,
CASE
	WHEN dept_id = 6 then salary * .10
END as bonus
from employee_salary;