 -- Alumno: Nicola Galante Giovannone / Parrilla 34945

-- El trigger que crearemos, será uno que registrará en la tabla loan_status_history (que ya de por sí era una tabla para LOGs) cada vez que alguien haga un cambio de estado en la tabla loan.

--Para que funcione, vamos a cambiar la tabla operators para que ya no sea un foreing key y en vez de registrar los mails de los operadores, registre el user SQL.

ALTER TABLE `prestapp`.`loan_status_history` 
DROP FOREIGN KEY `loan_status_history_ibfk_2`;
ALTER TABLE `prestapp`.`loan_status_history` 
CHANGE COLUMN `operator` `operator` VARCHAR(50) NULL ,
DROP INDEX `operator` ;
;

--Ahora sí, el trigger se vería así:

DROP TRIGGER IF EXISTS log_cambio_status_loan;
CREATE TRIGGER log_cambio_status_loan
BEFORE UPDATE ON loan
FOR each row
INSERT INTO loan_status_history (status_history_id, loan_id, operator, status_id, history_date) VALUES (NULL, old.loan_id, user(), NEW.loan_status, NOW());

--Con este script, cambiamos un estado en la tabla loans y podemos ver como el trigger registra en loan_status_history

UPDATE `prestapp`.`loan` SET `loan_status` = '5' WHERE (`loan_id` = '11');
