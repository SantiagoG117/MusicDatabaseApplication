-- Artists Triggers: UPDATE

drop trigger "SANTIAGOUSER"."ARTISTS_VIEW_AFTER_UPDATE";

CREATE TRIGGER artists_view_after_update
    INSTEAD OF UPDATE ON artists_view
    FOR EACH ROW
BEGIN
    ----FIRST NAME---------------------------------------------------------------------------------------
    IF UPDATING ('FIRSTNAME') THEN
        -- Variabes:
        DECLARE
            ArtistPK     NUMBER;
            First_NamePK NUMBER;
            Row_count    NUMBER;
        BEGIN
            -- Define Primary Key
            select artists.artistid INTO ArtistPK
            from artists
            where artistid = (select artists_view.artistid
                              from artists_view
                              where artists_view.firstname LIKE :OLD.firstname AND artists_view.lastname LIKE :OLD.lastname
                              );
            
            -- Check if the First Name exist
            SELECT COUNT(*) INTO row_count
            FROM first_names
            WHERE firstname LIKE (:NEW.FirstName);
            
            -- If it does not exist
            IF Row_count = 0 THEN
                -- Add it to First_Names
                First_NamePK := first_names_ai.nextval;
                
                INSERT INTO first_names (firstnameid, firstname)
                VALUES(First_NamePK, :NEW.FirstName);
                
                -- Update Arists_First_Name
                UPDATE artists_first_name SET endtime = TRUNC(SYSDATE)WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO Artists_First_Name VALUES (ArtistPK, First_NamePK, TRUNC(SYSDATE),NULL); 
                
            -- If it does exists 
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of First_Name
                SELECT firstnameid INTO First_NamePK
                FROM first_names
                where firstname LIKE (:New.FirstName); --Here is where the swap happens
                
                 -- Update Artists_First_Name
                UPDATE artists_first_name SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO Artists_First_Name VALUES (ArtistPK, First_NamePK, TRUNC(SYSDATE),NULL);
            END IF;
        END;        
      END IF;
      
      
      --LAST NAME-----------------------------------------------------------------------------------------
      IF UPDATING ('LASTNAME') THEN
        -- Variabes:
        DECLARE
            ArtistPK   NUMBER;
            Last_NamePK NUMBER;
            Row_Count   Number;
        BEGIN
             -- Define Primary Key
            select artists.artistid INTO ArtistPK
            from artists
            where artistid = (select artists_view.artistid
                              from artists_view
                              where artists_view.firstname LIKE :OLD.firstname AND artists_view.lastname LIKE :OLD.lastname
                              );
            
            -- Check if the Last Name exist
            SELECT COUNT(*) INTO Row_Count
            FROM last_names
            WHERE LastName LIKE (:NEW.LastName);
            
            -- If it does not exist
            IF Row_Count = 0 THEN
                -- Add it to Last_Names
                Last_NamePK := Last_Names_AI.nextval;
                
                INSERT INTO last_names (lastnameid, lastname)
                VALUES(Last_NamePK, :NEW.LastName);
                
                --Update Artists_Last_Name
                UPDATE Artists_Last_Name SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO Artists_Last_Name VALUES(ArtistPK, Last_NamePK, TRUNC(SYSDATE), NULL);
            
            -- If it does exist
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of Last_Name
                SELECT LastNameID INTO Last_NamePK
                FROM Last_Names
                WHERE LastName LIKE (:NEW.LastName);
                
                
                -- Update Artists_Last_Name
                UPDATE Artists_Last_Name SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO Artists_Last_Name VALUES(ArtistPK, Last_NamePK, TRUNC(SYSDATE), NULL);
            END IF;
        END;        
      END IF;
      ----CITY------------------------------------------------------------------------------------------------------------
      IF UPDATING ('CITY') THEN
      -- Variabes:
        DECLARE
            ArtistPK     NUMBER;
            CityPK       NUMBER;
            Row_count    NUMBER;
        BEGIN
            -- Get the Artist Primary Key (Constraint: Artist PK always Exists)
            SELECT artistid INTO ArtistPK
            FROM artists_first_name
            where firstnameid = (select FirstNameID
                                 from first_names
                                 where first_names.firstname LIKE :OLD.firstname 
                                );
            --Check if City already exists
            SELECT COUNT(*) INTO Row_count
            FROM cities
            WHERE city LIKE (:NEW.City);
            
            --If it does not exists
            IF Row_count = 0 THEN
                -- Add it to cities
                CityPK := city_ai.nextval;
                
                INSERT INTO cities (CityID, city)
                VALUES(CityPK, :NEW.City);
                
                -- Update Artists_City
                UPDATE artists_city SET endtime = TRUNC(SYSDATE)WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO artists_city VALUES (ArtistPK, CityPK, TRUNC(SYSDATE),NULL);
            
            -- If it already exists    
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of First_Name
                SELECT cityid INTO CityPK
                FROM cities
                WHERE city LIKE (:NEW.City);
                
                --Update Artists_City
                UPDATE artists_city SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO artists_city VALUES(ArtistPK, CityPK, TRUNC(SYSDATE),NULL);
            END IF;
        END;
    END IF;
    --ADDRESS--------------------------------------------------------------------------------------------------------
    IF UPDATING ('ADDRESS') THEN
        -- Variables
        DECLARE
            ArtistPK   NUMBER;
            AddressPK   NUMBER;
            Row_Count   NUMBER;
        BEGIN
             -- Get the Artist Primary Key (Constraint: Artist PK always Exists)
                SELECT artistid INTO ArtistPK
                FROM artists_first_name
                where firstnameid = (select FirstNameID
                                     from first_names
                                     where first_names.firstname LIKE :OLD.firstname 
                                    );
            -- Check if the Address exists
            select count(*) into Row_Count
            from addresses
            where address LIKE (:NEW.Address);
            
            -- If it does not exist:
            IF row_count = 0 THEN
            -- Add it to Addresses
            AddressPK := Address_AI.nextval;
            
            INSERT INTO addresses (addressid, address)
            VALUES (AddressPK, :NEW.Address);
            
            -- Update artists_Address
            UPDATE artists_address SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
            INSERT INTO artists_address VALUES(ArtistPK, AddressPK, TRUNC(SYSDATE), NULL);
            
            -- If it does exist
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of Address
               SELECT AddressID INTO AddressPK
               FROM addresses
               where address LIKE (:NEW.Address);
                
                -- Update Artists_Addresses
                UPDATE artists_address SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO artists_address VALUES(ArtistPK, AddressPK, TRUNC(SYSDATE), NULL);
            END IF;
        END;
    END IF;    
    -- Zip ----------------------------------------------------------------------------------------------------
    --Variables
    IF UPDATING ('ZIP') THEN
        DECLARE
            ArtistPK   NUMBER;
            Zip_PK   NUMBER;
            Row_Count   NUMBER;
        BEGIN
             -- Get the Artist Primary Key (Constraint: Artist PK always Exists)
                SELECT artistid INTO ArtistPK
                FROM artists_first_name
                where firstnameid = (select FirstNameID
                                     from first_names
                                     where first_names.firstname LIKE :OLD.firstname 
                                    );
                                    
            -- Check if the Zip exists
            select count(*) into Row_Count
            from zip
            where zip_code LIKE (:NEW.zip_code);
            
            -- If it does not exist:
            IF row_count = 0 THEN
                -- Add it to Zip codes:
                Zip_PK := zip_ai.nextval;
                
                INSERT INTO zip(zipid,zip_code)
                VALUES(Zip_PK, :NEW.Zip_code);
                
                -- Update artists_Address
                UPDATE artists_zip SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO artists_zip VALUES(ArtistPK, Zip_PK, TRUNC(SYSDATE), NULL);
                
            -- If it does exist
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of Zip
                SELECT zipID INTO Zip_PK
                from zip
                where zip_code LIKE (:NEW.Zip_code);
                
                -- Update Artists_Addresses
                UPDATE artists_zip SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
                INSERT INTO artists_zip VALUES(ArtistPK, Zip_PK, TRUNC(SYSDATE), NULL);
            END IF;
        END;
    END IF;
END;










