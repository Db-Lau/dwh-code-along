USE ROLE USERADMIN;

CREATE ROLE ice_cream_reader COMMENT = 'Able to read ice_cream database';
CREATE ROLE ice_cream_writer COMMENT
= 'Able to do CRUD operations on ice_cream database';
CREATE ROLE ice_cream_analyst COMMENT
= 'Able to create views on ice_cream database';

USE ROLE SECURITYADMIN;

--manage grants for the role ice_cream_reader
GRANT USAGE ON WAREHOUSE dev_wh TO ROLE ice_cream_reader;
GRANT USAGE ON DATABASE ice_cream_db TO ROLE ice_cream_reader;
GRANT USAGE ON ALL SCHEMAS IN DATABASE ice_cream_db TO ROLE ice_cream_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA ice_cream_db.public TO ROLE ice_cream_reader;
GRANT SELECT ON FUTURE TABLES IN SCHEMA ice_cream_db.public TO ROLE ice_cream_reader;