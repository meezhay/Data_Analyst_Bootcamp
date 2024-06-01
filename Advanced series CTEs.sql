-- CTEs: common table expressions. alter
-- they allow you to define a subquery block that cna be referenced in the main query
-- with is the keybword to define a CTE
-- CTEs are unique because you can only use a CTE immediately after you create it
-- Subqueries can be used in a WHERE clause in conjunction with the keywords IN or EXISTS, but you can't do this with CTEs.

WITH CTE_Example AS
(
SELECT gender, AVG(salary) as avg_sal, MAX(salary) as max_sal, min(salary) min_sal, count(salary) count
from employee_demographics dem
join employee_salary sal
	on dem. employee_id =  sal.employee_id
Group by gender
)

SELECT AVG(avg_sal)
FROM CTE_Example
;

WITH CTE_Example (Gender, Avg_sal, Max_sal, Min_sal, Count_sal) AS
-- overriding the alias
(
SELECT gender, AVG(salary) as avg_sal, MAX(salary) as max_sal, min(salary) min_sal, count(salary) count
from employee_demographics dem
join employee_salary sal
	on dem. employee_id =  sal.employee_id
Group by gender
)

SELECT *
FROM CTE_Example
;

-- Difference between a subquery and a CTE
-- a bank holds details of all the transactions for the day in a table called daily_trans. The data in this table includes an account number, a transaction code, and an amount.
-- The database also has a table called transaction_types, and its columns include the transaction code and an indicator called debit_credit, which is set to 1 for transaction types that credit the customer's account, and 2 for those that debit the account.
-- If the bank wants a list of all credit transactions for the day, the query could look like this:
SELECT
  account_no,
  tran_code,
  amount
FROM daily_trans
WHERE tran_code IN
  (SELECT tran_code
   FROM transaction_types
   WHERE debit_credit = 1);
-- This type of query can only be written using a subquery. You couldn’t replace the subquery with a CTE here.

-- Choose a subquery when:

-- You're using the WHERE clause keywords IN or EXISTS to pick up the selection criteria from another table.
-- You want to select a single piece of data from another table as the new value for a field in an UPDATE statement.

-- random example
SELECT 
    employee_id, first_name, last_name,
    salary,
    SUM(salary)  OVER (PARTITION BY 
        CASE 
            WHEN salary BETWEEN 20000 AND 50000 THEN 'Low'
            WHEN salary BETWEEN 55000 AND 70000 THEN 'Medium'
            ELSE 'High' 
        END
    ORDER BY salary desc) AS RunningTotal
FROM 
    employee_salary;