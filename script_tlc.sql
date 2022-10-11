START TRANSACTION;
DELETE FROM `prestapp`.`clients` WHERE (`client_id` = '39');
ROLLBACK;
COMMIT;

START TRANSACTION;
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_25','Privado',2);
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_26','Privado',2);
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_27','Privado',2);
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_28','Privado',2);
SAVEPOINT lote_1;
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_29','Privado',2);
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_30','Privado',2);
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_31','Privado',2);
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_32','Privado',2);
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_33','Privado',2);
INSERT INTO `prestapp`.`employer` (`employer_id`,`employer_name`,`employer_type`,`payment_date`) VALUES (NULL,'Random_employer_34','Privado',2);
SAVEPOINT lote_2;
RELEASE SAVEPOINT lote1;
