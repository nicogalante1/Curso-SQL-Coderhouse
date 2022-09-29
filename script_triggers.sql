 -- Alumno: Nicola Galante Giovannone / Parrilla 34945

-- PRIMER TRIGGER
  --El trigger que crearemos, será uno que registrará en la tabla loan_status_history (que ya de por sí era una tabla para LOGs) cada vez que alguien haga un cambio de estado en la tabla loan.

  --Para que funcione, vamos a cambiar la tabla para que operators ya no sea un foreing key y en vez de registrar los mails de los operadores, registre el user SQL.

  ALTER TABLE `prestapp`.`loan_status_history` 
  DROP FOREIGN KEY `loan_status_history_ibfk_2`;
  ALTER TABLE `prestapp`.`loan_status_history` 
  CHANGE COLUMN `operator` `operator` VARCHAR(50) NULL ,
  DROP INDEX `operator` ;
  ;

  -- Le agregamos una columna que registre la hora, así satisface el requerimiento de la entreg
  ALTER TABLE `prestapp`.`loan_status_history` 
  ADD COLUMN `history_time` TIME NULL DEFAULT NULL AFTER `history_date`;

  --Ahora sí, el trigger se vería así:
  CREATE TRIGGER log_cambio_status_loan
  BEFORE UPDATE ON loan
  FOR each row
  INSERT INTO loan_status_history (status_history_id, loan_id, operator, status_id, history_date, history_time) VALUES (NULL, old.loan_id, user(), NEW.loan_status, CURDATE(), CURTIME());

  --Con este script, cambiamos un estado en la tabla loans y podemos ver como el trigger registra en loan_status_history

  UPDATE `prestapp`.`loan` SET `loan_status` = '5' WHERE (`loan_id` = '11');

  SELECT * FROM prestapp.loan_status_history;

-- SEGUNDO TRIGGER
  -- Este trigger, se activará al eliminar un cliente de la tabla clients.
  -- Antes, se fijará si existe ese cliente con leads en tabla leads y préstamos en la tabla loans, de ser así, los eliminará y luego el registro será registrado en una nueva tabla llamada deleted_Ccients
    
    -- Creamos nueva tabla
    create table deleted_clients
  (
  deleted_client_id	int not null,
  client_name	varchar(20) not null,
  document_number varchar(11) not null,
  address		varchar(50) not null,
  email		varchar(50) not null,
  deletion_date date not null,
  deletion_time time,
  operator varchar(50),
  primary key (deleted_client_id)); 
  
  --Triggers
DROP TRIGGER IF EXISTS deleted_before;
CREATE TRIGGER deleted_before
BEFORE DELETE ON clients	
FOR each row
DELETE FROM prestapp.leads WHERE leads.client_id = old.client_id ;

CREATE TRIGGER deleted_before_loan
BEFORE DELETE ON clients	
FOR each row
DELETE FROM prestapp.loan WHERE loan.client_id = old.client_id;

CREATE TRIGGER deleted
AFTER DELETE ON clients	
FOR each row
INSERT INTO deleted_clients (deleted_client_id, client_name, document_number, address, email, deletion_date, deletion_time, operator) VALUES (OLD.client_id, OLD.client_name, OLD.document_number, OLD.address, OLD.email, CURDATE(), CURTIME(), USER())
;

--Probamos eliminando el cliente 50 y chequeamos
DELETE FROM `prestapp`.`clients` WHERE (`client_id` = '50');
SELECT * FROM prestapp.deleted_clients;
  
--El cliente 36 'Valeria Gray' tiene lead y loan, así que debería funcionar también
--fijarse en estas tablas, está la cliente de client_id 36
SELECT * FROM prestapp.loan;
SELECT * FROM prestapp.leads;

--Eliminamos en la tabla clients
DELETE FROM `prestapp`.`clients` WHERE (`client_id` = '36');

--La cliente ha sido eliminada y ha quedado registrada en 
SELECT * FROM prestapp.deleted_clients;

  
   
  
  
  
  
  
  
