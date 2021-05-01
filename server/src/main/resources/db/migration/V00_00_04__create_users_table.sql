CREATE TABLE users (
                      id INT AUTO_INCREMENT,
                      name VARCHAR(100) NOT NULL,

                      CONSTRAINT PK_USER PRIMARY KEY (id),
                      CONSTRAINT U_NAME UNIQUE (name)                          -- Szerintem ha nem egyedülálló akkor zavart fog okozni
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
