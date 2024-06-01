-- Window functions

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;
    
SELECT dem.first_name, dem.last_name, gender, SUM(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;

-- rolling total: starts at a specific value and add on values from subsequent rows based off the partition
-- do a rolling total by adding an order by 
SELECT dem.first_name, dem.last_name, gender, salary,
	SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) as rolling_total
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;
    
SELECT dem.first_name, dem.last_name, gender, salary,
	AVG(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) as rolling_average
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;
    

-- specific things you can only do with window functions
-- row number, rank, dense rank
-- row number gives a row number based off whatever you are partitioning by or ordering by in the window function
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over()
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;


SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender)
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;
    
-- say you want to rank from highest salary to lowest salary, you include a order by
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) 
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;
    

-- rank gives the row number more of an official rnak
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;
-- when using row_nmber, whatever you partition by will not have duplicate rows wihthin the partiton
--  rank is different from row_number in that whenever it encounter a duplicate based off of the order by,
-- it will assign it the same number


-- dense_rank
-- dense rank is different from rank in that when it ges down to duplicates, it's still going to duplicate but it will
-- give the next number a numerical value. 

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
FROM employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id;

-- rank: 1,2,3,3,5,6,6,8...
-- dense rank: 1,2,3,3,4,5,6,6,7...
-- row number: 1,2,3,4,5,6... no duplicates
