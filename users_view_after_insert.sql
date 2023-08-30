-- Users Trigger: INSERT
drop trigger "SANTIAGOUSER"."USERS_VIEW_AFTER_INSERT";

CREATE TRIGGER users_view_after_insert
    INSTEAD OF INSERT ON users_view
    FOR EACH ROW
BEGIN
    DECLARE
        UserPK NUMBER := user_AI.nextval;
    BEGIN
        -- USERS -------------------------------------------------------------------------------------------------
        INSERT INTO users VALUES (UserPK);
        
        -- First_Name --------------------------------------------------------------------------------------------
        DECLARE
             First_NamePK       NUMBER;
             User_First_NamePK  NUMBER;
             Row_count          Number;         
        BEGIN
             -- Check if First_Name already exists
             SELECT COUNT(*) INTO row_count
             FROM first_names_users
             where firstname LIKE (:NEW.firstname);
            
            -- If it does not exist
            IF Row_count = 0 THEN
                -- Create a new Primary Key
                First_NamePK := first_names_users_AI.nextval;
                -- Insert the value in First_Names_Users table
                INSERT INTO first_names_users VALUES (First_NamePK, :NEW.FirstName);
            
            -- If it does exists
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of First_Name
                SELECT firstnameid INTO First_NamePK
                FROM first_names_users
                WHERE firstname LIKE (:NEW.FirstName);
            END IF;
            -- Update association table
            User_First_NamePK := user_first_name_users_AI.nextval;
            INSERT INTO users_first_names_users VALUES (User_First_NamePK ,UserPK, First_NamePK, TRUNC(SYSDATE), NULL);
        END;
        
        --LastNames ----------------------------------------------------------------------------------------------
        DECLARE
             Last_NamePK       NUMBER;
             User_Last_NamePK  NUMBER;
             Row_count          Number;  
        BEGIN
             -- Check if First_Name already exists
             SELECT COUNT(*) INTO row_count
             FROM last_names_users
             where lastname LIKE (:NEW.lastname);
             
             -- If it does not exist
             IF Row_count = 0 THEN
                -- Create a new Primary Key
                Last_NamePK := last_names_users_AI.nextval;
                -- Insert the value in Last_Names_Users table
                INSERT INTO last_names_users VALUES(Last_NamePK, :NEW.LastName);
             -- If it does exists
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of First_Name
                SELECT lastnameid INTO Last_NamePK
                FROM last_names_users
                WHERE lastname LIKE (:NEW.LastName);
            END IF;
            -- Update association table
            User_Last_NamePK := user_last_name_users_AI.nextval;
            INSERT INTO users_Last_Names_Users VALUES (User_Last_NamePK ,UserPK, Last_NamePK, TRUNC(SYSDATE), NULL);
        END;
    END;
END;






