-- Users trigger: UPDATE

drop trigger "SANTIAGOUSER"."USERS_VIEW_AFTER_UPDATE";

CREATE TRIGGER users_view_after_update
    INSTEAD OF UPDATE ON users_view
    FOR EACH ROW
BEGIN
    -- First Name -----------------------------------------------------------------------------------------------------------------------------------------
     IF UPDATING ('FIRSTNAME') THEN
        -- Variabes:
        DECLARE
            UserPK     NUMBER;
            First_NamePK NUMBER;
            User_First_NamePK  NUMBER;
            Row_count    NUMBER;
        BEGIN
        -- Get the Users Primary Key (Constraint: Users PK must exists)
        SELECT userid INTO UserPK
        from users
        where userid = (select users_view.userid
                        from users_view
                        where users_view.firstname like :OLD.firstname AND users_view.lastname like :OLD.lastname
                        );
        -- Check if the First Name Exists
        SELECT COUNT(*) INTO Row_count
        FROM first_names_users
        WHERE firstname LIKE (:NEW.FirstName);
        
         -- If it does not exist
            IF Row_count = 0 THEN
                -- Add it to First_Names
                First_NamePK := first_names_users_AI.nextval;
                INSERT INTO first_names_users VALUES (First_NamePK, :NEW.FirstName);
         -- If it does exists 
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of the First Name
                SELECT firstnameid INTO First_NamePK
                FROM first_names_users
                WHERE firstname LIKE (:NEW.FirstName);
            END IF;
            
            -- Update Association Table
            User_First_NamePK := user_first_name_users_AI.nextval;
            UPDATE users_first_names_users SET endtime = TRUNC(SYSDATE) WHERE userid = UserPK AND endtime IS NULL;
            INSERT INTO users_first_names_users VALUES (User_First_NamePK, UserPK, First_NamePK, TRUNC(SYSDATE),NULL );             
        END;
    END IF;
    
    --LastName-------------------------------------------------------------------------------------------------------------------------------------------
    IF UPDATING ('LASTNAME') THEN
        -- Variabes:
        DECLARE
            UserPK     NUMBER;
            Last_NamePK NUMBER;
            User_Last_NamePK  NUMBER;
            Row_count    NUMBER;
        BEGIN
        -- Get the Users Primary Key (Constraint: Users PK must exists)
        SELECT userid INTO UserPK
        from users
        where userid = (select users_view.userid
                        from users_view
                        where users_view.firstname like :OLD.firstname AND users_view.lastname like :OLD.lastname
                        );
        -- Check if the First Name Exists
        SELECT COUNT(*) INTO Row_count
        FROM last_names_users
        WHERE lastname LIKE (:NEW.LastName);
        
        -- If it does not exists
        IF Row_count = 0 THEN
            -- Add it to Last_Names
            Last_NamePK := last_names_users_AI.nextval;
            INSERT INTO last_names_users VALUES (Last_NamePK, :NEW.LastName);
        -- If it does exists 
        ELSIF Row_count = 1 THEN
            -- Get the Primary Key of the Last Name
            SELECT Lastnameid INTO Last_NamePK
            FROM last_names_users
            WHERE lastname LIKE (:NEW.LastName);
        END IF;
        -- Update Association Table
        User_Last_NamePK := user_last_name_users_AI.nextval;
        UPDATE users_last_names_users SET endtime = TRUNC(SYSDATE) WHERE userid = UserPK AND endtime IS NULL;
        INSERT INTO users_last_names_users VALUES (User_Last_NamePK, UserPK, Last_NamePK, TRUNC(SYSDATE),NULL );             
        END;
    END IF;
END;