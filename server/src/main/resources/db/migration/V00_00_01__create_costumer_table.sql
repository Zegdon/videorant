CREATE TABLE costumer (
    id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    full_adress VARCHAR(200) NOT NULL,
    personal_id_number VARCHAR(8) NOT NULL,
    phone_number VARCHAR(11) NOT NULL,

    CONSTRAINT PK_COSTUMER PRIMARY KEY (id),
    CONSTRAINT U_PERSONAL_ID_NUMBER UNIQUE (personal_id_number)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

