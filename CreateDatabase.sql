-- Drop tables
-- Artists
drop table "SANTIAGOUSER"."ARTISTS" cascade constraints PURGE
drop table "SANTIAGOUSER"."FIRST_NAMES" cascade constraints PURGE
drop table "SANTIAGOUSER"."LAST_NAMES" cascade constraints PURGE
drop table "SANTIAGOUSER"."CITIES" cascade constraints PURGE
drop table "SANTIAGOUSER"."ADDRESSES" cascade constraints PURGE
drop table "SANTIAGOUSER"."ZIP" cascade constraints PURGE
drop table "SANTIAGOUSER"."ARTISTS_FIRST_NAME" cascade constraints PURGE
drop table "SANTIAGOUSER"."ARTISTS_LAST_NAME" cascade constraints PURGE
drop table "SANTIAGOUSER"."ARTISTS_CITY" cascade constraints PURGE
drop table "SANTIAGOUSER"."ARTISTS_ADDRESS" cascade constraints PURGE
drop table "SANTIAGOUSER"."ARTISTS_ZIP" cascade constraints PURGE
drop table "SANTIAGOUSER"."USERS" cascade constraints PURGE
drop table "SANTIAGOUSER"."FIRST_NAMES_USERS" cascade constraints PURGE
drop table "SANTIAGOUSER"."LAST_NAMES_USERS" cascade constraints PURGE
drop table "SANTIAGOUSER"."USERS_FIRST_NAMES_USERS" cascade constraints PURGE
drop table "SANTIAGOUSER"."USERS_LAST_NAMES_USERS" cascade constraints PURGE
;


-- ARTIST TABLE ----------------------------------------------------------------

CREATE TABLE Artists (
    --ColumnName   --Datatype  --Constraints
    ArtistID        INTEGER    NOT NULL,
    
    --Primary Key
    PRIMARY KEY (ArtistID)
);

-- Multi Valued Fields Tables:
CREATE TABLE First_Names (
     --ColumnName   --Datatype  --Constraints
     FirstNameID    INTEGER     NOT NULL,
     FirstName      VARCHAR2(50)    NOT NULL,
     -- Primary Key
     PRIMARY KEY (FirstNameID)
);

CREATE TABLE Last_Names (
     --ColumnName   --Datatype  --Constraints
     LastNameID     INTEGER     NOT NULL,
     LastName       VARCHAR2(50) NOT NULL,
     -- Primary Key
     PRIMARY KEY (LastNameID)
);

CREATE TABLE Cities (
    --ColumnName   --Datatype   --Constraints
    CityID         INTEGER      NOT NULL,
    City           VARCHAR2(50)  NOT NULL,
    --Primary Key
    PRIMARY KEY (CityID)
);

CREATE TABLE Addresses(
    --ColumnName    --Datatype      --Constraints
    AddressID       INTEGER         NOT NULL,
    Address         VARCHAR2(250)   NOT NULL,
    --Primary Key
    PRIMARY KEY (AddressID)
);

CREATE TABLE Zip (
    --ColumnName    --Datatype  --Constraints
    ZipID           INTEGER     NOT NULL,
    Zip_code        CHAR(6)     NOT NULL,
    
    --Primary key
    PRIMARY KEY (ZipID)
);

-- Association tables (Audit):
CREATE TABLE Artists_First_Name(
    --ColumnName    --DataType  --Constraints
    ArtistID        INTEGER     NOT NULL,
    FirstNameID     INTEGER     NOT NULL,
    StartTime       DATE        NOT NULL,
    EndTime         DATE,
    
    -- First Foregin Key:
    CONSTRAINT fk_Artists_First_Names
    FOREIGN KEY(ArtistID)
    REFERENCES Artists (ArtistID),
    
    --Second Foreign Key:
    CONSTRAINT fk_First_Names_Artists
    Foreign KEY(FirstNameID)
    REFERENCES First_Names (FirstNameID)
);

CREATE TABLE Artists_Last_Name(
    --ColumnName    --DataType  --Constraints
    ArtistID        INTEGER     NOT NULL,
    LastNameID      INTEGER     NOT NULL,
    StartTime       DATE        NOT NULL,
    EndTime         DATE,
    
    -- Primary Key
    --PRIMARY KEY (ArtistID,LastNameID),
    -- First Foregin Key:
    CONSTRAINT fk_Artists_Last_Names
    FOREIGN KEY(ArtistID)
    REFERENCES Artists (ArtistID),
    
    --Second Foreign Key:
    CONSTRAINT fk_Last_Names_Artists
    Foreign KEY(LastNameID)
    REFERENCES Last_Names (LastNameID)
);

CREATE TABLE Artists_City(
    --ColumnName    --DataType  --Constraints
    ArtistID        INTEGER     NOT NULL,
    CityID          INTEGER     NOT NULL,
    StartTime       DATE        NOT NULL,
    EndTime         DATE,
    
    -- Primary Key
    PRIMARY KEY (ArtistID, CityID),
    -- First Foregin Key:
    CONSTRAINT fk_Artists_Cities
    FOREIGN KEY(ArtistID)
    REFERENCES Artists (ArtistID),
    
    --Second Foreign Key:
    CONSTRAINT fk_Cities_Artists
    Foreign KEY(CityID)
    REFERENCES Cities (CityID)
);

CREATE TABLE Artists_Address(
    --ColumnName    --DataType  --Constraints
    ArtistID        INTEGER     NOT NULL,
    AddressID       INTEGER     NOT NULL,
    StartTime       DATE        NOT NULL,
    EndTime         DATE,
    
    -- Primary Key
    PRIMARY KEY (ArtistID, AddressID),
    -- First Foregin Key:
    CONSTRAINT fk_Artists_Addresses
    FOREIGN KEY(ArtistID)
    REFERENCES Artists (ArtistID),
    
    --Second Foreign Key:
    CONSTRAINT fk_Addresses_Artists
    Foreign KEY(AddressID)
    REFERENCES Addresses (AddressID)
);

CREATE TABLE Artists_Zip (
    --ColumnName    --DataType  --Constraints
    ArtistID        INTEGER     NOT NULL,
    ZipID           INTEGER     NOT NULL,
    StartTime       DATE        NOT NULL,
    EndTime         DATE,
    
    -- Primary Key
    PRIMARY KEY (ArtistID, ZipID),
    -- First Foregin Key:
    CONSTRAINT fk_Artists_Zip
    FOREIGN KEY(ArtistID)
    REFERENCES Artists (ArtistID),
    
    --Second Foreign Key:
    CONSTRAINT fk_Zip_Artists
    Foreign KEY(ZipID)
    REFERENCES Zip (ZipID)
);

-- Albums ----------------------------------------------------------------------

CREATE TABLE Albums (
    --ColumnName   --Datatype  --Constraints
    Album_ID            INTEGER         NOT NULL,
    Album_Name          VARCHAR2(50)    NOT NULL,
    Date_of_release     DATE            NOT NULL,
    ArtistID            INTEGER         NOT NULL,
    
    --Primary Key
    PRIMARY KEY (Album_ID),
    
    -- Foreign Key
    CONSTRAINT fk_Artists_Albums
    FOREIGN KEY(ArtistID)
    REFERENCES Artists (ArtistID)
);

-- Album Songs -----------------------------------------------------------------
CREATE TABLE Album_songs (
    Album_SongID        INTEGER         NOT NULL,
    Song_Name           VARCHAR2(100)   NOT NULL,
    DURATION            CHAR(5)         NOT NULL,
    Album_ID            INTEGER         NOT NULL,
    
    --Primary Key
    PRIMARY KEY (Album_SongID),
    
    --Foreign Key
    CONSTRAINT fk_Albums_Songs
    FOREIGN KEY(Album_ID)
    REFERENCES Albums (Album_ID)
);


-- USER Table ------------------------------------------------------------------

CREATE TABLE Users (
    --ColumnName   --Datatype  --Constraints
    UserID          INTEGER         NOT NULL,
--    UserName        varchar2(50)    NOT NULL,
--    Password        Char(5)         NOT NULL,
    
    -- Primary Key
    PRIMARY KEY (UserID)
);

-- Multi Valued Fields Tables:
CREATE TABLE First_Names_Users (
    --ColumnName   --Datatype  --Constraints
    FirstNameID    INTEGER     NOT NULL,
    FirstName      VARCHAR(50) NOT NULL,
    
    --Primary Key
    PRIMARY KEY (FirstNameID)
);

CREATE TABLE Last_Names_Users (
    --ColumnName   --Datatype  --Constraints
    LastNameID     INTEGER     NOT NULL,
    LastName       VARCHAR(50) NOT NULL,
    
    -- Primary Key
    PRIMARY KEY (LastNameID)
);

-- Association tables:
CREATE TABLE Users_First_Names_Users (
    --ColumnName   --Datatype       --Constraints
    User_First_Name_user_ID  INTEGER     NOT NULL,
    UserID              INTEGER     NOT NULL,
    FirstNameID         INTEGER     NOT NULL,
    StartTime           DATE        NOT NULL,
    EndTime             DATE        NULL,
    
    --Primary Key
    PRIMARY KEY(User_First_Name_user_ID),
    
    --First Foregin Key
    CONSTRAINT fk_Users_First_Names_Users
    FOREIGN KEY (UserID)
    REFERENCES Users (UserID),
    
    -- Second Foreign Key
    CONSTRAINT fk_First_Names_Users_Users
    FOREIGN KEY (FirstNameID)
    REFERENCES First_Names_Users (FirstNameID)
);

CREATE TABLE Users_Last_Names_Users (
    --ColumnName   --Datatype  --Constraints
    User_Last_Name_user_ID  INTEGER     NOT NULL,
    UserID         INTEGER     NOT NULL,
    LastNameID     INTEGER     NOT NULL,
    StartTime      DATE        NOT NULL,
    EndTime        DATE        NULL,
    
     --Primary Key
    PRIMARY KEY(User_Last_Name_user_ID),
    
    --First Foregin Key
    CONSTRAINT fk_Users_Last_Names_Users
    FOREIGN KEY (UserID)
    REFERENCES Users (UserID),
    
    -- Second Foreign Key
    CONSTRAINT fk_Last_Names_Users_Users
    FOREIGN KEY (LastNameID)
    REFERENCES Last_Names_Users (LastNameID)
);

-- Playlists--------------------------------------------------------------------
CREATE TABLE Playlist (
    --ColumnName   --Datatype       --Constraints
    PlaylistID      INTEGER         NOT NULL,
    Name            varchar2(100)   NOT NULL,
    Date_Created    DATE            NOT NULL,
    UserID          INTEGER         NOT NULL,
    
    -- Primary Key
    PRIMARY KEY (PlaylistID),
    
    --Foreign Key
    CONSTRAINT fk_Users_Playlist
    FOREIGN KEY (UserID)
    REFERENCES Users(UserID)
);

CREATE TABLE Album_Songs_Playlists (
    --ColumnName   --Datatype       --Constraints
    Album_SongID   INTEGER          NOT NULL,
    PlaylistID     INTEGER          NOT NULL,
    
    --Primary Key
    PRIMARY KEY(Album_SongID, PlaylistID),
    
    --Foregin Key 1
    CONSTRAINT fk_Album_Song_Playlist
    FOREIGN KEY (Album_SongID)
    REFERENCES Album_songs(Album_SongID),
    
    --Foreign Key 2
    CONSTRAINT fk_Playlist_Album_Song
    FOREIGN KEY (PlaylistID)
    REFERENCES Playlist(PlaylistID)
);









