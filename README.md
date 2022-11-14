# Pewlett-Hackard-Analysis

## Overview of the analysis: Explain the purpose of this analysis.

With many employees reaching retirement age at Pewlett-Hackard, there is a growing concern of finding suitable replacements for their positions. In order to prepare for the upcoming surge of retiring employees, this analysis delves into which employees are retiring and which employees may reasonably replace them. Utilizing a database containing employees, their departments, and their positions, this analysis shows which areas need the most attention when it comes to replacement. All sql queries regarding this challenge are located in the Employee_Database_challenge.sql file


## Results: Provide a bulleted list with four major points from the two analysis deliverables. Use images as support where needed.

By first separating out the employees who are nearing retirement age and further separating out employees still working for Pewlett-Hackard, the dataset was complete for this analysis. From this dataset, the analysis was able to ascertain the number of employees who would reasonably retire within the coming years for each position. This count is demonstrated by the following table:

```
SELECT count(*), title INTO retiring_titles FROM unique_titles GROUP BY title ORDER BY count(*) DESC;
SELECT * FROM retiring_titles;
```

![Retiring Employees by Position](https://github.com/waciciarelli/Pewlett-Hackard-Analysis/blob/main/Retiring_Employees_by_Position.png?raw=true)

* This table shows that "Senior Engineers" and "Senior Staff" are two of the most worrisome positions. They each contain more than twice the amount of retiring-age employees than any of the remaining departments. 

* On the same note, the "Manager" position is of little concern with only 2 employees nearing retiring age.

* Although Senior positions are of the most pressing concerns, the mid-level positions also cannot be ignored as they total to around 20,000 employees approaching retiring age.

* In order to combat this concern, a mentorship eligibility table was created to isolate individuals born in 1965 who might reasonable be able to be mentored by and replace these positions:

## Summary: Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

### How many roles will need to be filled as the "silver tsunami" begins to make an impact?

In total, 72,458 rolls will need to be filled as the "silver tsunami" begins to make an impact.

### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

```
SELECT DISTINCT ON (employees.emp_no) employees.emp_no, first_name, last_name, birth_date, dept_emp.from_date, dept_emp.to_date, title 
INTO mentorship_eligibility
FROM Employees JOIN dept_emp ON employees.emp_no = dept_emp.emp_no 
JOIN Titles ON Employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY employees.emp_no;

SELECT * FROM mentorship_eligibility;
```

![Mentorable Employees by Position](https://github.com/waciciarelli/Pewlett-Hackard-Analysis/blob/main/Mentor_Employees_by_Position.png?raw=true)

Unfortunately there are not nearly enough employees to replace those retiring in the "silver tsunami." Pewlett Hackard only has around 1,549 employees of a suitable age for mentorship to fill these positions. This means that Pewlett-Hackard will need to hire outside of the company to replace positions at every level.
