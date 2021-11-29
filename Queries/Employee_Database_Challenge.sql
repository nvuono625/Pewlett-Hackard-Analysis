-- DELIVERABLE 1: The number of retiring employees by title

-- Join employee and title tables 
-- Create "retirement_title" table
SELECT e.emp_no, 
	e.first_name, 
	e.last_name,
    t.title, 
	t.from_date, 
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t 
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- View retirement_title table
SELECT * FROM retirement_titles;

-- Remove duplicates and keep only the most recent title for each employee
-- Create "unique_titles" table
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
		rt.emp_no,
		rt.first_name,
		rt.last_name,
		rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no, to_date DESC;

-- View unique_titles table
SELECT * FROM unique_titles;

-- Retrieve the number of employees by their most recent job title who are about to retire
-- Create "retiring_titles" table
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT DESC; 

-- View retiring_titles table
SELECT * FROM retiring_titles;


-- DELIVERABLE 2: The employees eligible for the mentorship program
-- Employees who were born between January 1, 1965 and December 31, 1965
-- Join the Employees and the Titles tables on the primary key
-- Create "mentorship_eligibility" table
SELECT DISTINCT ON (e.emp_no) 
	e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
ON (e.emp_no = de.emp_no)    
LEFT JOIN titles as t
ON (e.emp_no = t.emp_no)  
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no

-- View mentorship_eligibility table
SELECT * FROM mentorship_eligibility;