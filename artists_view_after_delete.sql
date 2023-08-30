-- Artists Trigger: Update

drop trigger "SANTIAGOUSER"."ARTISTS_VIEW_AFTER_DELETE";

CREATE TRIGGER artists_view_after_delete
    INSTEAD OF DELETE ON artists_view
    FOR EACH ROW
BEGIN
    DECLARE
    ArtistPK            NUMBER;
    BEGIN
        -- Define Primary Key
        select artists.artistid INTO ArtistPK
        from artists
        where artistid = (select artists_view.artistid
                          from artists_view
                          where artists_view.firstname LIKE :OLD.firstname AND artists_view.lastname LIKE :OLD.lastname
                          );
        
        -- Remove the Records from the view
        -- First Name -------------------------------------------------------------------------------------------------------------------------------------------------------
        UPDATE artists_first_name SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
        -- Last Name --------------------------------------------------------------------------------------------------------------------------------------------------------
        UPDATE Artists_Last_Name SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
        -- City -------------------------------------------------------------------------------------------------------------------------------------------------------------
        UPDATE artists_city SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
        -- Address ----------------------------------------------------------------------------------------------------------------------------------------------------------
        UPDATE artists_address SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL; 
        -- Zip  -------------------------------------------------------------------------------------------------------------------------------------------------------------
        UPDATE artists_zip SET endtime = TRUNC(SYSDATE) WHERE artistid = ArtistPK AND endtime IS NULL;
    END;
END;