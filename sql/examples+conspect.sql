    /* 
    The SELECT clause that begins each SELECT statement specifies the data items to be retrieved by the query. 
The items are usually specified by a select list, a list of select items separated by commas. 
Each select item in the list generates a single column of query results, in left-to-right order. 
A select item can be one of the following:
- A column name, identifying a column from the table(s) named in the FROM clause. 
When a column name appears as a select item, SQL simply takes the value of that column from 
each row of the database table and places it in the corresponding row of query results.
- A constant, specifying that the same constant value is to appear in every row of the query results.
- A SQL expression, indicating that SQL must calculate the value to be placed into the query results, 
as specified by the expression.
    */

-- List the sales offices with their targets and actual sales. --
SELECT city, target, sales
FROM offices;

-- List the Eastern region sales offices with their targets and sales. --
SELECT city, sales, target
FROM offices
WHERE region = 'Eastern';

-- List Eastern region sales offices whose sales exceed their targets, sorted in alphabetical order by city. --
SELECT city
FROM offices
WHERE sales > target
ORDER BY city;

/* List the names, offices, and hire dates of all salespeople. */
SELECT name, rep_office, hire_date
FROM selesreps;

-- What are the name, quota, and sales of employee number 107? --
SELECT name, quota, sales
FROM selesreps
WHERE empl_num = 107;

-- What are the average sales of our salespeople? --
SELECT AVG(sales)
FROM selesreps;

-- List the name and hire date of anyone with sales over $500,000. --
SELECT name, hire_date
FROM selesreps
WHERE sales > 500000;

-- List the salespeople, their quotas, and their managers. --
SELECT name, quota, manager
FROM selesreps;

-- List the location, region, and sales of each sales office. --
SELECT city, region, sales
FROM offices;

-- List the city, region, and amount over/under target for each office. --
SELECT city, region, (sales-target)
FROM offices;

/* Show the value of the inventory for each product. */
SELECT mfr_id, prod_id, description, (price * products.qty_on_hand) AS 'total cost'
FROM products;

-- Show me the result if I raised each salesperson’s quota by 3 percent of their year-to-date sales. --
SELECT name, quota, (quota + sales * .03) AS 'raised quota'
FROM selesreps;

-- List the name, month, and year of hire for each salesperson. --
SELECT name, MONTHNAME(hire_date), YEAR(hire_date)
FROM selesreps;

-- List the sales for each city. --
SELECT city, sales
FROM offices;

-- Show me all the data in the OFFICES table. --
SELECT * FROM offices;

-- List the employee numbers of all sales office managers. --
SELECT DISTINCT mgr
FROM offices;

-- Show me the offices where sales exceed target. --
SELECT office
FROM offices
WHERE sales > target;

-- Show me the name, sales, and quota of employee number 105. --
SELECT name, sales, quota
FROM selesreps
WHERE empl_num = 105;

-- Show me the employees managed by Bob Smith (employee 104). --
SELECT empl_num, name
FROM selesreps
WHERE manager = 104;

    /*
Five basic search conditions (called predicates in the ANSI/ISO standard):
- Comparison test.
- Range test.
- Set membership test.
- Pattern matching test.
- Null value test.
    */
    
-- The Comparison Test (=, <>, <, <=, >, >=) --
-- Find salespeople hired before 2006. --
SELECT empl_num, name
FROM selesreps
WHERE YEAR(hire_date) < 2006;

-- List the offices whose sales fall below 80 percent of target. --
SELECT office, city
FROM offices
WHERE sales < (.8 * offices.target);

-- List the offices not managed by employee number 108. --
SELECT office, city
FROM offices
WHERE mgr <> 108;

-- Retrieve the name and credit limit of customer number 2107. --
SELECT company, credit_limit
FROM customers
WHERE cust_num = 2107;

-- List salespeople who are over quota. --
SELECT name
FROM selesreps
WHERE sales > quota;

-- List salespeople who are under or at quota. --
SELECT name
FROM selesreps
WHERE sales <= quota;

-- The Range Test (BETWEEN) --
-- Find orders placed in the last quarter of 2007. --
SELECT order_num, order_date
FROM orders
WHERE order_date BETWEEN '2007-10-01' AND '2007-12-31';

-- Find the orders that fall into various amount ranges. --
SELECT order_date, amount
FROM orders
WHERE amount BETWEEN 20000 AND 29999;

SELECT order_date, amount
FROM orders
WHERE amount BETWEEN 30000 AND 39999;

SELECT order_date, amount
FROM orders
WHERE amount BETWEEN 40000 AND 49999;

-- List salespeople whose sales are not between 80 percent and 120 percent of quota. --
SELECT name, sales
FROM selesreps
WHERE sales NOT BETWEEN (.8 * quota) AND (1.2 * quota);

  /*
      The ANSI/ISO standard defines relatively complex rules for the handling of NULL values in the BETWEEN test:
      - If the test expression produces a NULL value, or if both expressions defining the range produce NULL values,
      then the BETWEEN test returns a NULL result.
      - If the expression defining the lower end of the range produces a NULL value,
      then the BETWEEN test returns FALSE if the test value is greater than the upper bound, and NULL otherwise.
      - If the expression defining the upper end of the range produces a NULL value,
      then the BETWEEN test returns FALSE if the test value is less than the lower bound, and NULL otherwise.
  */

-- The Set Membership Test (IN) --
-- List the salespeople who work in New York, Atlanta, or Denver. --
SELECT name
FROM selesreps
WHERE rep_office IN (11, 13, 22);

-- Find all orders placed on a Friday in January 2008. --
SELECT order_num
FROM orders
WHERE ORDER_DATE IN ('2008-01-04', '2008-01-11', '2008-01-18', '2008-01-25');

SELECT order_num
FROM orders
WHERE DAYNAME(order_date) = 'Friday'
AND order_date BETWEEN '2008-01-01' AND '2008-01-31';

-- Find all orders placed with four specific salespeople. --
SELECT order_num, amount
FROM orders
WHERE rep IN (107, 109, 101, 103);

-- The Pattern Matching Test (LIKE) --
-- Show the credit limit for Smithson Corp. --
SELECT company, credit_limit
FROM customers
WHERE company = 'Smithson Corp.';

  /*
      Wildcard Characters.
      - The percent sign (%) wildcard character matches any sequence of zero or more characters.
      - The underscore (_) wildcard character matches any single character.
      - The ANSI/ISO SQL standard does specify a way to literally match wildcard characters,
      using a special escape character. When the escape character appears in the pattern, the
      character immediately following it is treated as a literal character rather than as a wildcard character.
  */
SELECT company, credit_limit
FROM customers
WHERE company LIKE 'Smith% Corp.';

-- Find products whose product IDs start with the four letters “A%BC”. --
SELECT order_num, product
FROM orders
WHERE product LIKE 'A$%BC%' ESCAPE '$';

-- The Null Value Test (IS NULL) --
-- Find the salesperson not yet assigned to an office. --
SELECT name
FROM selesreps
WHERE rep_office IS NULL;

-- List the salespeople who have been assigned to an office. --
SELECT name
FROM selesreps
WHERE rep_office IS NOT NULL;

-- Find salespeople who are under quota or with sales under $300,000. --
SELECT name, quota, sales
FROM selesreps
WHERE sales < quota OR sales < 300000.00;

-- Find salespeople who are under quota and with sales under $300,000. --
SELECT name, quota, sales
FROM selesreps
WHERE sales < quota AND sales < 300000.00;

-- Find all salespeople who are under quota, but whose sales are not under $150,000. --
SELECT name, quota, sales
FROM selesreps
WHERE sales < quota AND NOT sales < 150000.00;

-- Show the sales for each office, sorted in alphabetical order by region, and within each region by city. --
SELECT region, city, sales
FROM offices
ORDER BY region, city;

-- List the offices, sorted in descending order by sales, so that the offices with the largest sales appear first. --
SELECT region, city, sales
FROM offices
ORDER BY sales DESC;

-- List the offices, sorted in descending order by sales performance, so that the offices with the best performance appear first. --
SELECT region, city, (sales - target)
FROM offices
ORDER BY 3 DESC;

  /*
      To generate the query results for a single-table SELECT statement, follow these steps:
      1. Start with the table named in the FROM clause.
      2. If there is a WHERE clause, apply its search condition to each row of the table,
      retaining those rows for which the search condition is TRUE, and discarding those
      rows for which it is FALSE or NULL.
      3. For each remaining row, calculate the value of each item in the select list to produce
      a single row of query results. For each column reference, use the value of the
      column in the current row.
      4. If SELECT DISTINCT is specified, eliminate any duplicate rows of query results that
      were produced.
      5. If there is an ORDER BY clause, sort the query results as specified.
   */

/* List all the products where the price of the product exceeds $2,000 or where more than $30,000 of the
product has been ordered in a single order. */
SELECT mfr_id, prod_id
FROM products
WHERE price > 2000.00
UNION
SELECT DISTINCT mfr, product
FROM orders
WHERE amount > 30000.00;

  /*
      There are severe restrictions on the tables that can be combined by a UNION operation:
      - The two SELECT clauses must contain the same number of columns.
      - The data type of each column selected from the first table must be the same as the 
      data type of the corresponding column selected from the second table.
      - Neither of the two tables can be sorted with the ORDER BY clause. However, the 
      combined query results can be sorted, as described in the following section.
   */
