CREATE TABLE users
(
    id 				INT AUTO_INCREMENT,
    username 		VARCHAR(50) NOT NULL,
    -- binary(60) is used because https://stackoverflow.com/a/16605381/433835
    password 		BINARY(60) NOT NULL,
    enabled 		BOOLEAN NOT NULL,
    name 			VARCHAR(150),
    email 			VARCHAR(250),
    phone_number 	VARCHAR(30),

    CONSTRAINT PK_USERS
        PRIMARY KEY(id),
    CONSTRAINT U_USERS_USERNAME
        UNIQUE (username)
)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE authorities
(
    username 	VARCHAR(50) NOT NULL,
    authority 	VARCHAR(50) NOT NULL,

    CONSTRAINT FK_AUTHORITIES_2_USERS
        FOREIGN KEY(username) REFERENCES users(username),
    CONSTRAINT U_AUTHORITIES_USERNAME_AND_AUTHORITY
        UNIQUE (username, authority)
)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE groups
(
    id 			INT AUTO_INCREMENT,
    group_name 	VARCHAR(50) NOT NULL,

    CONSTRAINT PK_GROUPS
        PRIMARY KEY(id)
)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE group_authorities
(
    group_id 	INT NOT NULL,
    authority 	VARCHAR(50) NOT NULL,

    CONSTRAINT FK_GROUP_AUTHORITIES_2_GROUPS
        FOREIGN KEY(group_id) REFERENCES groups(id)
)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE group_members
(
    id 			INT AUTO_INCREMENT,
    username 	VARCHAR(50) NOT NULL,
    group_id 	INT NOT NULL,

    CONSTRAINT PK_GROUP_MEMBERS
        PRIMARY KEY(id),
    CONSTRAINT FK_GROUP_MEMBERS_2_GROUPS
        FOREIGN KEY(group_id) REFERENCES groups(id)
)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE spring_session
(
    primary_id 				CHAR(36),
    session_id 				CHAR(36) NOT NULL,
    creation_time 			BIGINT NOT NULL,
    last_access_time 		BIGINT NOT NULL,
    max_inactive_interval 	INT NOT NULL,
    expiry_time 			BIGINT NOT NULL,
    principal_name 			VARCHAR(100),

    CONSTRAINT PK_SPRING_SESSION
        PRIMARY KEY(primary_id),
    CONSTRAINT U_SPRING_SESSION_SESSION_ID
        UNIQUE (session_id),
    INDEX I_SPRING_SESSION_EXPIRY_TIME
        (expiry_time),
    INDEX I_SPRING_SESSION_PRINCIPAL_NAME
        (principal_name)
)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE spring_session_attributes
(
    session_primary_id 	CHAR(36) NOT NULL,
    attribute_name 		VARCHAR(200) NOT NULL,
    attribute_bytes 	BLOB NOT NULL,

    CONSTRAINT PK_SPRING_SESSION_ATTRIBUTES
        PRIMARY KEY(session_primary_id, attribute_name),
    CONSTRAINT FK_SPRING_SESSION_ATTRIBUTES_2_SPRING_SESSION
        FOREIGN KEY(session_primary_id) REFERENCES spring_session(primary_id) ON DELETE CASCADE
)
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO users (username, name, password, enabled) VALUES ('admin', 'Admin', '$2a$10$2Gi3G9XaKalERoIa74OYruEHZyqSUqn10uSiOzk4PvOgL49vejna.', true);

INSERT INTO authorities (username, authority) VALUES ('admin', 'ROLE_ADMIN');
