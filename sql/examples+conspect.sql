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

/* List all orders showing order number, amount, customer name (“company”), and the customer’s
credit limit. */
SELECT order_num, amount, company, credit_limit
FROM orders JOIN customers ON (orders.cust = customers.cust_num);

-- List each salesperson and the city and region where they work. --
SELECT name, city, region
FROM selesreps JOIN offices ON (selesreps.rep_office = offices.office);

-- List the offices and the names and titles of their managers. --
SELECT city, name, title
FROM offices JOIN selesreps ON (offices.mgr = selesreps.empl_num);

-- List the offices with a target over $600,000 and their manager information. --
SELECT office, name, title
FROM offices JOIN selesreps ON (offices.mgr = selesreps.empl_num)
WHERE target > 600000;

-- List all the orders, showing amounts and product descriptions. --
SELECT order_date, amount, description
FROM orders JOIN products ON (orders.mfr = products.mfr_id AND orders.product = products.prod_id);

-- List orders over $25,000, including the name of the salesperson who took the order and the name of the customer. --
SELECT order_date, amount, company AS 'who placed', name AS 'who took'
FROM orders
  JOIN customers ON (orders.cust = customers.cust_num)
  JOIN selesreps ON (customers.cust_rep = selesreps.empl_num)
WHERE amount > 25000;

/* List the orders over $25,000, showing the name of the customer who placed the order, the customer’s
salesperson, and the office where the salesperson works. */
SELECT order_date, company AS customer, name AS 'customer’s salesperson', city AS 'salesperson lives in'
FROM orders
  JOIN customers ON (orders.cust = customers.cust_num)
  JOIN selesreps ON (customers.cust_rep = selesreps.empl_num)
  JOIN offices ON (selesreps.rep_office = offices.office)
WHERE amount > 25000;

  /*
      - Qualified column names are sometimes needed in multitable queries to eliminate
      ambiguous column references.
      - All-column selections (SELECT *) have a special meaning for multitable queries.
      - Self-joins can be used to create a multitable query that relates a table to itself.
      - Table aliases can be used in the FROM clause to simplify qualified column names and
      to allow unambiguous column references in self-joins.
   */

-- Show the name, sales, and office for each salesperson. --
SELECT name, selesreps.sales AS 'empl. sales', city, offices.sales AS 'office sales'
FROM selesreps JOIN offices ON (selesreps.rep_office = offices.office);

-- List the names of salespeople and their managers. --
SELECT selesreps.name AS 'empl. name', boss.name AS 'boss name'
FROM selesreps JOIN selesreps AS boss
    ON (selesreps.manager = boss.empl_num);

-- List salespeople with a higher quota than their manager. --
SELECT selesreps.name AS employee, selesreps.quota 'empl. quota', boss.name AS 'boss', boss.quota AS 'boss quota'
FROM selesreps JOIN selesreps AS boss
  ON (selesreps.manager = boss.empl_num)
WHERE selesreps.quota > boss.quota;

/* List salespeople who work in different offices than their manager, showing the name and office where
each works. */
SELECT
  selesreps.name AS 'empl name',
  offices.city AS 'empl city',
  bname.name AS 'boss name',
  bcity.city AS 'boss city'
FROM selesreps
  JOIN offices ON (selesreps.rep_office = offices.office)
  JOIN selesreps AS bname ON (selesreps.manager = bname.empl_num)
  JOIN offices AS bcity ON (bname.rep_office = bcity.office)
WHERE offices.city <> bcity.city;

-- Show all possible combinations of salespeople and cities. --
SELECT name, city
FROM selesreps JOIN offices;

-- List the company name and all orders for customer number 2103. --
SELECT company, order_date, amount
FROM customers JOIN orders ON (customers.cust_num = orders.cust)
WHERE cust_num = 2103;

  /*
  To generate the query results for a SELECT statement:
      1. If the statement is a UNION of SELECT statements, apply Steps 2 through 5 to each
      of the statements to generate their individual query results.
      2. Form the product of the tables named in the FROM clause. If the FROM clause names
      a single table, the product is that table.
      3. If there is an ON clause, apply its matching-column condition to each row of the
      product table, retaining those rows for which the condition is TRUE (and discarding
      those for which it is FALSE or NULL).
      4. If there is a WHERE clause, apply its search condition to each row of the resulting
      table, retaining those rows for which the search condition is TRUE (and discarding
      those for which it is FALSE or NULL).
      5. For each remaining row, calculate the value of each item in the select list to produce
      a single row of query results. For each column reference, use the value of the
      column in the current row.
      6. If SELECT DISTINCT is specified, eliminate any duplicate rows of query results
      that were produced.
      7. If the statement is a UNION of SELECT statements, merge the query results for the
      individual statements into a single table of query results. Eliminate duplicate rows
      unless UNION ALL is specified.
      8. If there is an ORDER BY clause, sort the query results as specified.
   */

-- List the salespeople and the offices where they work. --
SELECT name, rep_office
FROM selesreps;

SELECT COUNT(*)
FROM selesreps;

-- List the salespeople and the cities where they work. --
SELECT name, city
FROM selesreps JOIN offices ON (selesreps.rep_office = offices.office);

SELECT COUNT(*)
FROM selesreps JOIN offices ON (selesreps.rep_office = offices.office);

  /*
  Full outer join
      1. Begin with the inner join of the two tables, using matching columns in the normal
      way.
      2. For each row of the first table that is not matched by any row in the second table,
      add one row to the query results, using the values of the columns in the first table,
      and assuming a NULL value for all columns of the second table.
      3. For each row of the second table that is not matched by any row in the first table,
      add one row to the query results, using the values of the columns in the second
      table, and assuming a NULL value for all columns of the first table.
      4. The resulting table is the outer join of the two tables.
   */

-- List the girls and boys who live in the same city. --
SELECT girls.name AS g_name, girls.city AS g_city, boys.name AS b_name, boys.city AS b_city
FROM girls INNER JOIN boys ON (girls.city = boys.city);

-- List girls and boys in the same city, including any unmatched girls. --
SELECT *
FROM girls LEFT JOIN boys ON (girls.city = boys.city);

-- List girls and boys in the same city, including any unmatched boys. --
SELECT *
FROM girls RIGHT JOIN boys ON (girls.city = boys.city);

-- List the salespeople and the cities where they work. --
SELECT name, city
FROM selesreps LEFT JOIN offices ON (selesreps.rep_office = offices.office);

  /*
      - The cross join will contain m×n rows, consisting of all possible row pairs from the
      two tables.
      - TBL1 INNER JOIN TBL2 will contain some number of rows, r, which is less than
      m×n. The inner join is strictly a subset of the cross join. It is formed by eliminating
      those rows from the cross join that do not satisfy the matching condition for the
      inner join.
      - The left outer join contains all of the rows from the inner join, plus each unmatched
      row from TBL1, NULL-extended.
      - The right outer join also contains all of the rows from the inner join, plus each
      unmatched row from TBL2, NULL-extended.
      - The full outer join contains all of the rows from the inner join, plus each unmatched
      row from TBL1, NULL-extended, plus each unmatched row from TBL2, NULLextended.
      Roughly speaking, its query results are equal to the left outer join “plus”
      the right outer join.
      -The union join contains all of the rows of TBL1, NULL-extended, plus all of the rows
      of TBL2, NULL-extended. Roughly speaking, its query results are the full outer join
      “minus” the inner join.
   */
-- Make a list of all of the girls, along with the names of their mothers and the names of the boys who live in the same city. --
SELECT
  girls.name g_name,
  girls.city g_city,
  parents.pname g_mother,
  boys.name b_name,
  boys.city b_city
FROM girls
  JOIN parents ON (girls.name = parents.child AND parents.ptype = 'MOTHER')
  JOIN boys ON (girls.city = boys.city);

SELECT
  girls.name g_name,
  girls.city g_city,
  parents.pname g_mother,
  boys.name b_name,
  boys.city b_city
FROM girls
  LEFT OUTER JOIN parents ON (girls.name = parents.child AND parents.ptype = 'MOTHER')
  LEFT OUTER JOIN boys ON (girls.city = boys.city);

SELECT
  girls.name g_name,
  girls.city g_city,
  parents.pname g_mother,
  boys.name b_name,
  boys.city b_city
FROM
  (
      (girls LEFT JOIN parents ON (girls.name = parents.child)
  )
      LEFT JOIN boys ON (girls.city = boys.city))
WHERE (ptype = 'MOTHER') OR (ptype IS NULL );

/*
Generate a girl/boy listing again, but this time you want to include the name of the boy’s father
and the girl’s mother in the query results.
 */
SELECT
  girls.name g_name,
  girls.city g_city,
  parents.pname g_mother,
  boys.name b_name,
  boys.city b_city,
  dad.pname AS f_name
FROM girls
  JOIN parents ON (girls.name = parents.child AND ptype = 'MOTHER')
  JOIN boys ON (boys.city = girls.city)
  JOIN parents AS dad ON (boys.name = dad.child AND dad.ptype = 'FATHER');

SELECT
  girls.name g_name,
  girls.city g_city,
  parents.pname g_mother,
  boys.name b_name,
  boys.city b_city,
  dad.pname AS f_name
FROM girls
  LEFT JOIN parents ON (girls.name = parents.child AND ptype = 'MOTHER')
  LEFT JOIN boys ON (boys.city = girls.city)
  LEFT JOIN parents AS dad ON (boys.name = dad.child AND dad.ptype = 'FATHER');