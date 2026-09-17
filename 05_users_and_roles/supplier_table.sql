USE ROLE ice_cream_writer;

CREATE TABLE supplier (
    supplier_id INT,
    supplier_name STRING
)

SELECT CURRENT_ROLE();

USE ROLE SYSADMIN; 

DROP TABLE supplier;

USE ROLE SECURITYADMIN;

GRANT ROLE ice_cream_writer to ROLE SYSADMIN;

USE ROLE SYSADMIN;

DROP TABLE supplier;

