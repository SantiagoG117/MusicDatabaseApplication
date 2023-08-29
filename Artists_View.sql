-- Artists View
drop view "SANTIAGOUSER"."ARTISTS_VIEW";

CREATE VIEW Artists_View AS
    SELECT
        artists.artistid,
        first_names.FirstName,
        last_names.lastname,
        cities.city,
        addresses.address,
        zip.zip_code
    FROM artists
    -- First_Name
    LEFT JOIN Artists_First_Name ON artists.artistid = artists_first_name.artistid
    LEFT JOIN First_Names ON artists_first_name.firstnameid = first_names.firstnameid
    -- Last_Name
    LEFT JOIN artists_last_name ON artists.artistid = artists_last_name.artistid
    LEFT JOIN last_names on artists_last_name.lastnameid = last_names.lastnameid
    -- City
    LEFT JOIN artists_city on artists.artistid = artists_city.artistid
    LEFT JOIN Cities on artists_city.cityid = cities.cityid
    -- Address
    LEFT JOIN artists_address ON artists.artistid = artists_address.artistid
    LEFT JOIN addresses ON artists_address.addressid = addresses.addressid
    -- Zip
    LEFT JOIN artists_zip ON artists.artistid = artists_zip.artistid
    LEFT JOIN zip on artists_zip.zipid = zip.zipid
    --Condition: get only the current state
    where (artists_first_name.endtime IS NULL) 
          AND
          (artists_last_name.endtime IS NULL)
          AND
          (artists_city.endtime IS NULL) 
          AND
          (artists_address.endtime IS NULL)
          AND
          (artists_zip.endtime IS NULL)
;
