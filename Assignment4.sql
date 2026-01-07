USE elmasri_company;

/*a. View with department name, manager name, and manager salary */
CREATE VIEW Manager AS 
SELECT d.Dname, e.Fname, e.Lname, e.Salary
FROM Department d, Employee e
WHERE d.Mgr_ssn = e.Ssn;

/* b. View with employee name, supervisor name, and employee salary for employees in 'Research' department */
CREATE VIEW ResearchEmployees AS 
SELECT e.Fname AS Employee_Fname, e.Lname AS Employee_Lname, 
       s.Fname AS Supervisor_Fname, s.Lname AS Supervisor_Lname, 
       e.Salary
FROM Employee e
JOIN Employee s ON e.Super_ssn = s.Ssn
JOIN Department d ON e.Dno = d.Dnumber
WHERE d.Dname = 'Research';

/* c. View with project name, controlling department name, number of employees, and total hours worked per week */
CREATE VIEW ProjectSummary AS 
SELECT p.Pname, d.Dname, COUNT(w.Essn) AS Num_Employees, SUM(w.Hours) AS Total_Hours
FROM Project p
JOIN Department d ON p.Dnum = d.Dnumber
JOIN Works_On w ON p.Pnumber = w.Pno
GROUP BY p.Pname, d.Dname;

/* d. View for projects with more than one employee working on it */
CREATE VIEW ProjectWithMultipleEmployees AS 
SELECT p.Pname, d.Dname, COUNT(w.Essn) AS Num_Employees, SUM(w.Hours) AS Total_Hours
FROM Project p
JOIN Department d ON p.Dnum = d.Dnumber
JOIN Works_On w ON p.Pnumber = w.Pno
GROUP BY p.Pname, d.Dname
HAVING COUNT(w.Essn) > 1;

/* Part - 2 
a. Grant Tom read, insert privileges on Department and allow him to grant these privileges */
GRANT SELECT, INSERT ON Department TO Tom WITH GRANT OPTION;

/* b. Revoke Tom’s insert privilege and also from anyone he granted it to */
REVOKE INSERT ON Department FROM Tom CASCADE;  /*Showing error in syantax  */
REVOKE INSERT ON Department FROM Tom;

/* c. Grant Jessica insert and update privileges on Works_On without granting pass-on privileges */
GRANT INSERT, UPDATE ON Works_On TO Jessica;

/* d. Grant Mark access to view names and addresses of employees in the Research department */
CREATE VIEW ResearchEmployeesNames AS 
SELECT Fname, Lname, Address 
FROM Employee 
WHERE Dno = (SELECT Dnumber FROM Department WHERE Dname = 'Research');
GRANT SELECT ON ResearchEmployeesNames TO Mark;

/* e. Grant Allison read access on Dependent and permission to use its primary key in foreign keys */
GRANT SELECT ON Dependent TO Allison;
GRANT REFERENCES ON Dependent TO Allison;

