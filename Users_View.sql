-- Users View
drop view "SANTIAGOUSER"."USERS_VIEW";

CREATE VIEW Users_View AS
    SELECT
        users.userid,
--        users.username,
--        users.password,
        first_names_users.firstname,
        last_names_users.lastname
    FROM users 
    --First Names
    LEFT JOIN users_first_names_users ON users.userid = users_first_names_users.userid
    LEFT JOIN first_names_users ON users_first_names_users.firstnameid = first_names_users.firstnameid
    --Last Names
    LEFT JOIN users_last_names_users ON users.userid = users_last_names_users.userid
    LEFT JOIN last_names_users ON users_last_names_users.lastnameid = last_names_users.lastnameid
    -- Condition: Get only the current active state of each record
    where (users_first_names_users.endtime IS NULL)
           AND
           (users_last_names_users.endtime IS NULL)
;