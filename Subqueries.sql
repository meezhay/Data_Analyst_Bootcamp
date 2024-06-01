-- subqueries: a query within another query
-- subqueries in the where, select and from clause

select *
from employee_demographics;

select *
from employee_demographics
where employee_id in 
				(select employee_id
                from employee_salary
                where dept_id= 1);
		
-- Subquery in a select statement
select first_name, salary,
(select avg(salary)
from employee_salary) as 'average salary'
from employee_salary;

select gender, AVG(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

select gender, avg(`max(age)`)
-- performing aggregated function on a named column, remeber to use a backtick ``
from (select gender, AVG(age), max(age), min(age), count(age)
from employee_demographics
group by gender) as agg_table
group by gender;


select avg(max_age), avg(min_age)
-- performing aggregated function on a named column, remeber to use a backtick ``
-- however with aliasing, you don't need the backticks
from (select gender, AVG(age) as avg_age, max(age) as max_age, min(age) as min_age, count(age)
		from employee_demographics
		group by gender) as agg_table;
        
-- CTEs or temp tables are better ways to write the above