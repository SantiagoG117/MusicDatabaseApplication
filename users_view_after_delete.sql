-- Users Trigger: Delete

drop trigger "SANTIAGOUSER"."USERS_VIEW_AFTER_DELETE";

CREATE TRIGGER users_view_after_delete
    INSTEAD OF DELETE ON users_view
    FOR EACH ROW
BEGIN
    DECLARE
        UserPK  NUMBER;
    BEGIN
        -- Get the Users Primary Key (Constraint: Users PK must exists)
        SELECT userid INTO UserPK
        from users
        where userid = (select users_view.userid
                        from users_view
                        where users_view.firstname like :OLD.firstname AND users_view.lastname like :OLD.lastname
                        );
        -- Remove records from the View
        -- First Name --------------------------------------------------------------------------------------------
        UPDATE users_first_names_users SET endtime = TRUNC(SYSDATE) WHERE userid = UserPK AND endtime IS NULL;
        -- Last Name ---------------------------------------------------------------------------------------------
        UPDATE users_last_names_users SET endtime = TRUNC(SYSDATE) WHERE userid = UserPK AND endtime IS NULL;
    END;
END;