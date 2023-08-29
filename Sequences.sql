DROP SEQUENCE "SANTIAGOUSER"."ARTISTS_AI";
DROP SEQUENCE "SANTIAGOUSER"."FIRST_NAMES_AI";
DROP SEQUENCE "SANTIAGOUSER"."LAST_NAMES_AI";
DROP SEQUENCE "SANTIAGOUSER"."ADDRESS_AI";
DROP SEQUENCE "SANTIAGOUSER"."CITY_AI";
DROP SEQUENCE "SANTIAGOUSER"."ZIP_AI";
DROP SEQUENCE "SANTIAGOUSER"."USER_AI";
DROP SEQUENCE "SANTIAGOUSER"."FIRST_NAMES_USERS_AI";
DROP SEQUENCE "SANTIAGOUSER"."USER_FIRST_NAME_USERS_AI";
DROP SEQUENCE "SANTIAGOUSER"."LAST_NAMES_USERS_AI";
DROP SEQUENCE "SANTIAGOUSER"."USER_LAST_NAME_USERS_AI";

-- Artists Sequence
CREATE SEQUENCE Artists_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- First Names Sequence
CREATE SEQUENCE first_names_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

-- Last Names Sequence
CREATE SEQUENCE last_names_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
CREATE SEQUENCE city_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE SEQUENCE address_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE SEQUENCE zip_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
    
CREATE SEQUENCE user_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
CREATE SEQUENCE first_names_users_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE SEQUENCE user_first_name_users_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE SEQUENCE last_names_users_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

CREATE SEQUENCE user_last_name_users_AI
    START WITH 1
    INCREMENT BY 1
    NOCACHE;
    
    