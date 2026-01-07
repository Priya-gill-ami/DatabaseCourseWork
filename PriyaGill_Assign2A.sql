USE elmasri_company;

SELECT fname, Minit,Lname FROM employee where salary > 27000;

SELECT e.Fname, e.Lname, e.Address 
FROM employee e
WHERE e.Ssn IN (SELECT Essn FROM dependent WHERE Relationship = 'Son')
AND e.Ssn NOT IN (SELECT Essn FROM dependent WHERE Relationship = 'Daughter');

SELECT 
    CONCAT(e.Fname, ' ', e.Minit, '. ', e.Lname) AS Employee, 
    IFNULL(CONCAT(s.Fname, ' ', s.Minit, '. ', s.Lname), 'No Supervisor') AS Supervisor
FROM employee e
LEFT JOIN employee s ON e.Super_ssn = s.Ssn
ORDER BY e.Lname;

SELECT p.Pname, SUM(w.Hours) AS Total_Hours
FROM project p
JOIN works_on w ON p.Pnumber = w.Pno
WHERE p.Plocation = 'Houston'
GROUP BY p.Pname
HAVING COUNT(w.Essn) > 2;

SELECT e.Ssn, e.Fname, e.Minit, e.Lname
FROM employee e
WHERE e.Dno = (SELECT Dno FROM employee ORDER BY Salary DESC LIMIT 1);

SELECT p.Pname, d.Dname
FROM project p
JOIN department d ON p.Dnum = d.Dnumber
WHERE p.Pnumber IN (
    SELECT w.Pno 
    FROM works_on w
    JOIN employee e ON w.Essn = e.Ssn
    WHERE w.Hours >= 20 AND e.Super_ssn IS NOT NULL
);

SELECT d.Dname
FROM department d
JOIN employee e ON d.Dnumber = e.Dno
JOIN dependent dep ON e.Ssn = dep.Essn
GROUP BY d.Dname
ORDER BY COUNT(dep.Dependent_name) DESC
LIMIT 1;

SELECT dl.Dlocation
FROM dept_locations dl
JOIN department d ON dl.Dnumber = d.Dnumber
JOIN project p ON d.Dnumber = p.Dnum
JOIN works_on w ON p.Pnumber = w.Pno
GROUP BY dl.Dlocation
ORDER BY SUM(w.Hours) ASC
LIMIT 1;
