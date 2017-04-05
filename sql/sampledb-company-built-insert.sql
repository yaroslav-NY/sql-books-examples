CREATE TABLE products
(
  mfr_id CHAR(3) NOT NULL,
  prod_id CHAR(5) NOT NULL,
  description VARCHAR(20) NOT NULL,
  price DECIMAL(9,2) NOT NULL,
  qty_on_hand TINYINT NOT NULL,
    PRIMARY KEY (mfr_id, prod_id)
);
ALTER TABLE products COMMENT = 'Contains one row for each type of product that is available for sale.';


CREATE TABLE offices
(
  office INT NOT NULL,
  city VARCHAR(15) NOT NULL,
  region VARCHAR(10) NOT NULL,
  mgr INT,
  target DECIMAL(9,2),
  sales DECIMAL(9,2) NOT NULL,
    PRIMARY KEY (office)
);
ALTER TABLE offices COMMENT = 'Contains one row for each of the company’s five sales offices where the salespeople work.';


CREATE TABLE selesreps
(
  empl_num INT NOT NULL,
  name VARCHAR(15) NOT NULL,
  age TINYINT NOT NULL,
  rep_office INT,
  title VARCHAR(10),
  hire_date DATE NOT NULL,
  manager INT,
  quota DECIMAL(9,2),
  sales DECIMAL(9,2) NOT NULL,
    PRIMARY KEY (empl_num),
    FOREIGN KEY (rep_office) REFERENCES offices(office) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (manager) REFERENCES selesreps(empl_num) ON DELETE SET NULL ON UPDATE CASCADE
);
ALTER TABLE selesreps COMMENT = 'Contains one row for each of the company’s ten salespeople.';


ALTER TABLE offices ADD CONSTRAINT FOREIGN KEY (mgr) REFERENCES selesreps(empl_num) ON DELETE SET NULL ON UPDATE CASCADE;


CREATE TABLE customers
(
  cust_num INT NOT NULL,
  company VARCHAR(20) NOT NULL,
  cust_rep INT,
  credit_limit DECIMAL(9,2),
    PRIMARY KEY (cust_num),
    FOREIGN KEY (cust_rep) REFERENCES selesreps(empl_num) ON DELETE SET NULL ON UPDATE CASCADE
);
ALTER TABLE customers COMMENT = 'Contains one row for each of the company’s customers.';


CREATE TABLE orders
(
  order_num INT NOT NULL,
  order_date DATE NOT NULL,
  cust INT NOT NULL,
  rep INT,
  mfr CHAR(3) NOT NULL,
  product CHAR(5) NOT NULL,
  qty SMALLINT NOT NULL,
  amount DECIMAL(9,2) NOT NULL,
    PRIMARY KEY (order_num),
    FOREIGN KEY (cust) REFERENCES customers(cust_num) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (rep) REFERENCES selesreps(empl_num) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (mfr, product) REFERENCES products(mfr_id, prod_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
ALTER TABLE orders COMMENT = 'Contains one row for each order placed by a customer. For simplicity, each order is assumed to be for a single product.';

INSERT INTO products (mfr_id, prod_id, description, price, qty_on_hand) VALUES
  ('REI','2A45C','Ratchet Link',79.00,210),
  ('ACI','4100Y','Widget Remover',2750.00,25),
  ('QSA','XK47 ','Reducer',355.00,38),
  ('BIC','41627','Plate',180.00,0),
  ('IMM','779C ','900-LB Brace',1875.00,9),
  ('ACI','41003','Size 3 Widget',107.00,207),
  ('ACI','41004','Size 4 Widget',117.00,139),
  ('BIC','41003','Handle',652.00,3),
  ('IMM','887P ','Brace Pin',250.00,24),
  ('QSA','XK48 ','Reducer',134.00,203),
  ('REI','2A44L','Left Hinge',4500.00,12),
  ('FEA','112  ','Housing',148.00,115),
  ('IMM','887H ','Brace Holder',54.00,223),
  ('BIC','41089','Retainer',225.00,78),
  ('ACI','41001','Size 1 Wiget',55.00,277),
  ('IMM','775C ','500-lb Brace',1425.00,5),
  ('ACI','4100Z','Widget Installer',2500.00,28),
  ('QSA','XK48A','Reducer',177.00,37),
  ('ACI','41002','Size 2 Widget',76.00,167),
  ('REI','2A44R','Right Hinge',4500.00,12),
  ('IMM','773C ','300-lb Brace',975.00,28),
  ('ACI','4100X','Widget Adjuster',25.00,37),
  ('FEA','114  ','Motor Mount',243.00,15),
  ('IMM','887X ','Brace Retainer',475.00,32),
  ('REI','2A44G','Hinge Pin',350.00,14);
COMMIT ;

INSERT INTO offices (office, city, region, mgr, target, sales) VALUES
  (22,'Denver','Western',null,300000.00,186042.00),
  (11,'New York','Eastern',null,575000.00,692637.00),
  (12,'Chicago','Eastern',null,800000.00,735042.00),
  (13,'Atlanta','Eastern',null,350000.00,367911.00),
  (21,'Los Angeles','Western',null,725000.00,835915.00);
COMMIT ;

INSERT INTO selesreps (empl_num, name, age, rep_office, title, hire_date, manager, quota, sales) VALUES
  (106,'Sam Clark',52,11,'VP Sales','2006-06-14',null,275000.00,299912.00),
  (109,'Mary Jones',31,11,'Sales Rep','2007-10-12',106,300000.00,392725.00),
  (104,'Bob Smith',33,12,'Sales Mgr','2005-05-19',106,200000.00,142594.00),
  (108,'Larry Fitch',62,21,'Sales Mgr','2007-10-12',106,350000.00,361865.00),
  (105,'Bill Adams',37,13,'Sales Rep','2006-02-12',104,350000.00,367911.00),
  (102,'Sue Smith',48,21,'Sales Rep','2004-12-10',108,350000.00,474050.00),
  (101,'Dan Roberts',45,12,'Sales Rep','2004-10-20',104,300000.00,305673.00),
  (110,'Tom Snyder',41,null,'Sales Rep','2008-01-13',101,null,75985.00),
  (103,'Paul Cruz',29,12,'Sales Rep','2005-03-01',104,275000.00,286775.00),
  (107,'Nancy Angelli',49,22,'Sales Rep','2006-11-14',108,300000.00,186042.00);
COMMIT ;

INSERT INTO customers (cust_num, company, cust_rep, credit_limit) VALUES
  (2111,'JCP Inc.',103,50000.00),
  (2102,'First Corp.',101,65000.00),
  (2103,'Acme Mfg.',105,50000.00),
  (2123,'Carter & Sons',102,40000.00),
  (2107,'Ace International',110,35000.00),
  (2115,'Smithson Corp.',101,20000.00),
  (2101,'Jones Mfg.',106,65000.00),
  (2112,'Zetacorp',108,50000.00),
  (2121,'QMA Assoc.',103,45000.00),
  (2114,'Orion Corp.',102,20000.00),
  (2124,'Peter Brothers',107,40000.00),
  (2108,'Holm & Landis',109,55000.00),
  (2117,'J.P. Sinclair',106,35000.00),
  (2122,'Three Way Lines',105,30000.00),
  (2120,'Rico Enterprises',102,50000.00),
  (2106,'Fred Lewis Corp.',102,65000.00),
  (2119,'Solomon Inc.',109,25000.00),
  (2118,'Midwest Systems',108,60000.00),
  (2113,'Ian & Schmidt',104,20000.00),
  (2109,'Chen Associates',103,25000.00),
  (2105,'AAA Investments',101,45000.00);
COMMIT ;

INSERT INTO orders (order_num, order_date, cust, rep, mfr, product, qty, amount) VALUES
  (112961,'2007-12-17',2117,106,'REI','2A44L',7,31500.00),
  (113012,'2008-01-11',2111,105,'ACI','41003',35,3745.00),
  (112989,'2008-01-03',2101,106,'FEA','114',6,1458.00),
  (113051,'2008-02-10',2118,108,'QSA','XK47',4,1420.00),
  (112968,'2007-10-12',2102,101,'ACI','41004',34,3978.00),
  (113036,'2008-01-30',2107,110,'ACI','4100Z',9,22500.00),
  (113045,'2008-02-02',2112,108,'REI','2A44R',10,45000.00),
  (112963,'2007-12-17',2103,105,'ACI','41004',28,3276.00),
  (113013,'2008-01-14',2118,108,'BIC','41003',1,652.00),
  (113058,'2008-02-23',2108,109,'FEA','112',10,1480.00),
  (112997,'2008-01-08',2124,107,'BIC','41003',1,652.00),
  (112983,'2007-12-27',2103,105,'ACI','41004',6,702.00),
  (113024,'2008-01-20',2114,108,'QSA','XK47',20,7100.00),
  (113062,'2008-02-24',2124,107,'FEA','114',10,2430.00),
  (112979,'2007-10-12',2114,102,'ACI','4100Z',6,15000.00),
  (113027,'2008-01-22',2103,105,'ACI','41002',54,4104.00),
  (113007,'2008-01-08',2112,108,'IMM','773C',3,2925.00),
  (113069,'2008-03-02',2109,107,'IMM','775C',22,31350.00),
  (113034,'2008-01-29',2107,110,'REI','2A45C',8,632.00),
  (112992,'2007-11-04',2118,108,'ACI','41002',10,760.00),
  (112975,'2007-10-12',2111,103,'REI','2A44G',6,2100.00),
  (113055,'2008-02-15',2108,101,'ACI','4100X',6,150.00),
  (113048,'2008-02-10',2120,102,'IMM','779C',2,3750.00),
  (112993,'2007-01-04',2106,102,'REI','2A45C',24,1896.00),
  (113065,'2008-02-27',2106,102,'QSA','XK47',6,2130.00),
  (113003,'2008-01-25',2108,109,'IMM','779C',3,5625.00),
  (113049,'2008-02-10',2118,108,'QSA','XK47',2,776.00),
  (112987,'2007-12-31',2103,105,'ACI','4100Y',11,27500.00),
  (113057,'2008-02-18',2111,103,'ACI','4100X',24,600.00),
  (113042,'2008-02-20',2113,101,'REI','2A44R',5,22500.00);
COMMIT ;

UPDATE offices SET mgr=108 WHERE office=22;
UPDATE offices SET mgr=106 WHERE office=11;
UPDATE offices SET mgr=104 WHERE office=12;
UPDATE offices SET mgr=105 WHERE office=13;
UPDATE offices SET mgr=108 WHERE office=21;
COMMIT ;