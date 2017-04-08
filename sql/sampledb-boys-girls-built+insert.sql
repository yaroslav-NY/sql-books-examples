CREATE TABLE girls
(
    name VARCHAR(25),
    city VARCHAR(25)
);
ALTER TABLE girls COMMENT = 'The girls table lists five girls and the cities where they live;';
INSERT INTO girls (name, city) VALUES 
    ('Mary','Boston'),
    ('Nancy',null),
    ('Susan','Chicago'),
    ('Betty','Chicago'),
    ('Anne','Denver');
COMMIT;
    
CREATE TABLE boys
(
    name VARCHAR(25),
    city VARCHAR(25)
);
ALTER TABLE boys COMMENT = 'The boys table lists five boys and the cities where they live;';
INSERT INTO boys (name, city) VALUES
    ('John','Boston'),
    ('Henry','Boston'),
    ('George',null),
    ('Sam','Chicago'),
    ('James','Dallas');
COMMIT;

CREATE TABLE parents
(
    child VARCHAR(25),
    ptype CHAR(6),
    pname VARCHAR(25)
);
ALTER Table parents COMMENT = 'The parents table lists fourteen mother''s or father''s names of particular child;';
INSERT INTO parents (child, ptype, pname) VALUES
    ('Mary', 'FATHER', 'Francis'),
    ('Mary','MOTHER', 'Joyce'),
    ('Nancy', 'FATHER', 'Robert'),
    ('Nancy','MOTHER', 'Norma'),
    ('Betty', 'FATHER', 'Cliff'),
    ('Betty','MOTHER', 'Besita'),
    ('Anne', 'FATHER', 'Walter'),
    ('Anne','MOTHER', 'Sophie'),
    ('John', 'FATHER', 'Carlos'),
    ('John','MOTHER', 'Marlena'),
    ('Sam', 'FATHER', 'Joseph'),
    ('Sam','MOTHER', 'Connie'),
    ('James', 'FATHER', 'James'),
    ('James','MOTHER', 'Mary');
COMMIT;
