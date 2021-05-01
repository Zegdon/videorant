CREATE TABLE item (
                      id INT AUTO_INCREMENT,
                      name VARCHAR(100) NOT NULL,
                      purchase_date DATE NOT NULL,                            --ezt ellenőrizni kell, hogy automatikusan beírja-e a dátumot
                      serialnumber INT NOT NULL,
                      status BOOLEAN NOT NULL,                            --varchar nem biztos, hogy jó. Itt csak foglat vagy szabad lesz beírva.

                      CONSTRAINT PK_ITEM PRIMARY KEY (id),
                      CONSTRAINT U_SORSZAM UNIQUE (sorszam)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
