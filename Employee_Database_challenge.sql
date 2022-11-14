--Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT emp_no, first_name, last_name FROM employees;
--Retrieve the title, from_date, and to_date columns from the Titles table.
SELECT title, from_date, to_date FROM titles;
--Create a new table using the INTO clause.
SELECT emp_no, salary, from_date, to_date INTO salaries_2 FROM salaries;
--Join both tables on the primary key.
SELECT * FROM employees NATURAL JOIN titles;
--Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
SELECT * FROM employees NATURAL JOIN titles WHERE birth_date BETWEEN '1952/01/01' AND '1955/12/31' ORDER BY emp_no ASC;
--Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.
SELECT DISTINCT ON (emp_no) * INTO Retirement FROM employees NATURAL JOIN titles WHERE birth_date BETWEEN '1952/01/01' AND '1955/12/31' ORDER BY emp_no, to_date desc;
--Before you export your table, confirm that it looks like this image:
SELECT * FROM retirement;
--Copy the query from the Employee_Challenge_starter_code.sql and add it to your Employee_Database_challenge.sql file.
-- Use Dictinct with Orderby to remove duplicate rows
--SELECT DISTINCT ON (______) _____,
--______,
--______,
--______

--INTO nameyourtable
--FROM _______
--WHERE _______
--ORDER BY _____, _____ DESC;
--Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
--These columns will be in the new table that will hold the most recent title of each employee.
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
FROM retirement
ORDER BY emp_no, to_date DESC;
--Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
FROM retirement
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Create a Unique Titles table using the INTO clause.
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Before you export your table, confirm that it looks like this image:
SELECT * FROM unique_titles;

--Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
SELECT count(*), title FROM unique_titles GROUP BY title ORDER BY count(*) DESC;

--Then, create a Retiring Titles table to hold the required information.
SELECT count(*), title INTO retiring_titles FROM unique_titles GROUP BY title ORDER BY count(*) DESC;

--Before you export your table, confirm that it looks like this image:
SELECT * FROM retiring_titles;


--In the Employee_Database_challenge.sql file, write a query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program.
SELECT DISTINCT ON (employees.emp_no) employees.emp_no, first_name, last_name, birth_date, dept_emp.from_date, dept_emp.to_date, title 
INTO mentorship_eligibility
FROM Employees JOIN dept_emp ON employees.emp_no = dept_emp.emp_no 
JOIN Titles ON Employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY employees.emp_no;

SELECT * FROM mentorship_eligibility;

select count(*), title FROM mentorship_eligibility GROUP BY title ORDER BY count(*) desc;

