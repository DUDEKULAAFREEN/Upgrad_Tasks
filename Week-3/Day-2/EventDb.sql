CREATE DATABASE EventDb;
Use EventDb;

CREATE TABLE UserInfo (
    EmailId VARCHAR(100) PRIMARY KEY,

    UserName VARCHAR(50) NOT NULL
        CHECK (LEN(UserName) BETWEEN 1 AND 50),

    Role VARCHAR(20) NOT NULL
        CHECK (Role IN ('Admin', 'Participant')),

    Password VARCHAR(20) NOT NULL
        CHECK (LEN(Password) BETWEEN 6 AND 20)
);


CREATE TABLE EventDetails (
    EventId INT PRIMARY KEY,

    EventName VARCHAR(50) NOT NULL
        CHECK (LEN(EventName) BETWEEN 1 AND 50),

    EventCategory VARCHAR(50) NOT NULL
        CHECK (LEN(EventCategory) BETWEEN 1 AND 50),

    EventDate DATETIME NOT NULL,

    Description VARCHAR(255) NULL,

    Status VARCHAR(20) NOT NULL
        CHECK (Status IN ('Active', 'In-Active'))
);


CREATE TABLE SpeakersDetails (
    SpeakerId INT PRIMARY KEY,

    SpeakerName VARCHAR(50) NOT NULL
        CHECK (LEN(SpeakerName) BETWEEN 1 AND 50)
);


CREATE TABLE SessionInfo (
    SessionId INT PRIMARY KEY,

    EventId INT NOT NULL,
    SpeakerId INT NOT NULL,

    SessionTitle VARCHAR(50) NOT NULL
        CHECK (LEN(SessionTitle) BETWEEN 1 AND 50),

    Description VARCHAR(255) NULL,

    SessionStart DATETIME NOT NULL,
    SessionEnd DATETIME NOT NULL,

    SessionUrl VARCHAR(255) NULL,

    FOREIGN KEY (EventId)
        REFERENCES EventDetails(EventId),

    FOREIGN KEY (SpeakerId)
        REFERENCES SpeakersDetails(SpeakerId)
);

CREATE TABLE ParticipantEventDetails (
    Id INT PRIMARY KEY,

    ParticipantEmailId VARCHAR(100) NOT NULL,

    EventId INT NOT NULL,
    SessionId INT NOT NULL,

    IsAttended BIT NOT NULL,

    FOREIGN KEY (ParticipantEmailId)
        REFERENCES UserInfo(EmailId),

    FOREIGN KEY (EventId)
        REFERENCES EventDetails(EventId),

    FOREIGN KEY (SessionId)
        REFERENCES SessionInfo(SessionId)
);

