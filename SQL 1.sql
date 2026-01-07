USE classicmodels;

SELECT * FROM employees;
SELECT lastName, firstName, jobTitle FROM employees;

SELECT * FROM customers;

SELECT contactLastName, contactFirstName FROM customers ORDER BY contactLastName;

SELECT contactLastName, contactFirstName FROM customers ORDER BY contactLastName, contactFirstName ASC;

SELECT contactLastName, contactFirstName FROM customers ORDER BY contactLastName DESC, contactFirstName ASC;

SELECT * FROM orderdetails;

SELECT orderNumber, orderLineNumber, quantityOrdered&priceEach AS Total FROM orderdetails;
SELECT orderNumber, orderLineNumber, quantityOrdered&priceEach AS Total FROM orderdetails ORDER BY quantityOrdered&priceEach;   /*** we can use total alias in place of this calculation also. ***/

SELECT distinct lastname from employees order by lastname;

SELECT * FROM customers;

/*** Question -1 ***/
SELECT customerName, country, state, creditlimit FROM customers WHERE country = "USA" and  creditLimit > 100000;

/*** Question - 2 ***/

SELECT customerName, country FROM customers WHERE country = "USA" OR  country = "France";

SELECT * FROM products;
SELECT productName, productCode, buyprice FROM products WHERE buyPrice BETWEEN 90 AND 100;

/*  Regular Expression*/

SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE 'a%';

SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE 'T_m';
SELECT employeeNumber, lastName, firstName FROM employees WHERE firstName LIKE 'P%a';

/* NULL*/

SELECT customername, country, salesRepEmployeeNumber from customers WHERE salesrepemployeenumber is NULL ORDER BY customername;

/* CONCAT */
SELECT * FROM orderdetails;

SELECT concat_ws(',', lastName, firstName) As Fullname from employees;

select ordernumber from orderdetails group by ordernumber having sum(quantityordered*priceeach)>60000;

SELECT ordernumber, customernumber, status, shippedDate from orders WHERE ordernumber IN(SELECT ordernumber from orderdetails group by ordernumber HAVING sum(quantityOrdered* priceEach)>60000);




