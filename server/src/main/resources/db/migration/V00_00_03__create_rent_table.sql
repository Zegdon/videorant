CREATE TABLE rent (
                      id INT AUTO_INCREMENT,
                      customer_id INT NOT NULL,                       --Ennek a costumer tábla id-jére kell mutatni (nem tudom hogy kell megcsinálni)
                      item_id INT NOT NULL,                                    --Ennek az item tábla id-jére kell mutatni (nem tudom hogy kell megcsinálni)
                      rent_date DATE NOT NULL,                                 --Ezt ellenőrizni kell, hogy automatikusan beírja-e a dátumot

                      CONSTRAINT PK_RENT PRIMARY KEY (id),

                      FOREIGN KEY(item_id) REFERENCES item(id)

                      FOREIGN KEY(customer_id) REFERENCES customer(id) ON DELETE CASCADE    --Ez lehet a jó idegen kulcs hivatkozás

) ENGINE = InnoDB DEFAULT CHARSET = utf8;



