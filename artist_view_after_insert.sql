-- Artists Triggers: INSERT
drop trigger "SANTIAGOUSER"."ARTISTS_VIEW_AFTER_INSERT";

CREATE TRIGGER artists_view_after_insert
    INSTEAD OF INSERT ON artists_view
    FOR EACH ROW
BEGIN
    DECLARE
        ArtistPK NUMBER := artists_ai.nextval;
    BEGIN
        -- ARTISTS -----------------------------------------------------------------------------------------------------------------------------
        INSERT INTO artists VALUES(ArtistPK);
        
        --First_Name ----------------------------------------------------------------------------------------------------------------------------
        DECLARE
            First_NamePK NUMBER;
            Row_count   Number;
        BEGIN
            -- Check if First_Name already exists
              SELECT COUNT(*) INTO row_count
              FROM first_names
              WHERE firstname LIKE (:NEW.FirstName);
              
            -- If it does not exist
            IF Row_count = 0 THEN
                -- Create a new Primary Key
                First_NamePK := first_names_ai.nextval;
                -- Insert the value in First_Name table
                INSERT INTO First_Names VALUES(First_NamePK, :NEW.FirstName);
                
            -- If it does exist 
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of First_Name
                SELECT firstnameid INTO First_NamePK
                FROM first_names
                where firstname LIKE (:New.FirstName);
    --            INSERT INTO First_Names VALUES(First_NamePK, :NEW.FirstName);
    --            -- Insert into Artists_First_Name
            END IF;
            -- Update Artists_First_Name
            INSERT INTO Artists_First_Name VALUES (ArtistPK, First_NamePK, TRUNC(SYSDATE),NULL);
        END;
        
        --Last_Name ------------------------------------------------------------------------------------------------
        DECLARE
            Last_NamePK NUMBER;
            Row_count   Number;
        BEGIN
            -- Check if First_Name already exists
            SELECT COUNT(*) INTO row_count
            FROM last_names
            WHERE lastname LIKE (:NEW.LastName);
            
            -- If it does not exist
            IF Row_count = 0 THEN
                -- Create a new Primary Key
                Last_NamePK := last_names_ai.nextval;
                -- Insert the value in First_Name table
                INSERT INTO last_names VALUES (Last_NamePK, :NEW.LastName);
            
            -- If it does exist 
            ELSIF Row_count = 1 THEN 
                -- Get the Primary Key of Last_Name
                SELECT lastnameid INTO Last_NamePK
                FROM last_names
                WHERE lastname LIKE (:NEW.LastName);
            END IF; 
            --Update Artists_Last_Names
            INSERT INTO artists_last_name VALUES (ArtistPK, Last_NamePK, TRUNC(SYSDATE),NULL);
        END;
        
        --CITY --------------------------------------------------------------------------------------
        
        DECLARE
            CityPK NUMBER;
            Row_count NUMBER;
        BEGIN
            -- Check if City already exists
            SELECT COUNT(*) INTO row_count
            FROM cities
            WHERE city LIKE (:NEW.city);
            
             -- If it does not exist
            IF Row_count = 0 THEN
                -- Create a new Primary Key
                CityPK := city_AI.nextval;
                -- Insert the value in Cities table
                INSERT INTO cities VALUES(CityPK, :NEW.city);
            -- If it does exist 
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of City
                SELECT cityid INTO CityPK
                FROM cities 
                WHERE city LIKE (:NEW.city);
            END IF;
            -- Update Artists_City
            INSERT INTO artists_city VALUES(ArtistPK, CityPK ,TRUNC(SYSDATE),NULL);
        END;    
    
        -- Address -----------------------------------------------------------------------------------
        DECLARE
            AddressPK NUMBER;
            Row_count Number;
        BEGIN
             -- Check if Address already exists
            SELECT COUNT(*) INTO row_count
            FROM addresses
            WHERE address LIKE (:NEW.address);
            
            -- If it does not exist
            IF Row_count = 0 THEN
                -- Create a new Primary Key
                AddressPK := address_AI.nextval;
                -- Insert the value in Addresses table
                INSERT INTO addresses VALUES (AddressPK, :NEW.address);
            -- If it does exist 
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of Address
                SELECT addressid INTO AddressPK
                FROM addresses
                WHERE address Like (:NEW.address);
            END IF;
            -- Update Artists_Address
            INSERT INTO artists_address VALUES(ArtistPK, AddressPK,TRUNC(SYSDATE),NULL);
        END;
        
        -- Zip------------------------------------------------------------------------------------------------------------
        DECLARE
            ZipPK NUMBER;
            Row_count Number;
        BEGIN
            --Check if Zip already exists
            SELECT COUNT(*) INTO Row_count
            FROM zip
            where zip_code LIKE (:NEW.Zip_code);
            
            -- If it does not exist
            IF Row_count = 0 THEN
                -- Create a new Primary Key
                ZipPK := zip_AI.nextval;
                -- Insert the value in Zip tables
                INSERT INTO zip VALUES (ZipPK, :NEW.Zip_code);
            ELSIF Row_count = 1 THEN
                -- Get the Primary Key of the zip
                SELECT zipid INTO ZipPK
                FROM zip
                WHERE zip_code LIKE (:NEW.Zip_code);
            END IF;
            
            -- Insert into Artists_Zip
            INSERT INTO artists_zip VALUES(ArtistPK, ZipPK, TRUNC(SYSDATE),NULL);
        END;
    END;
END;

