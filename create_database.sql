SHOW DATABASES;

--remember to make this statement idempotent
CREATE DATABASE IF NOT EXISTS DEMO_DB; 

CREATE SCHEMA IF NOT EXISTS DEMO_DB.staging; 

CREATE TABLE IF NOT EXISTS customer (
    customer_id integer PRIMARY KEY,
    age integer, 
    email varchar(50)
);

INSERT INTO customer (customer_id, age, email)
VALUES
(1, 32, 'abc@gmail.com'),
(2, 23, 'cdf@gmail.com');

SELECT * FROM customer;

DROP DATABASE DEMO_DB; 