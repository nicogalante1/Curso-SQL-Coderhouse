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
  -- Este trigger hará un respaldo de los clientes eliminados en una nueva tabla
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
  
  --Trigger
  CREATE TRIGGER deleted
  BEFORE DELETE ON clients	
  FOR each row
  INSERT INTO deleted_clients (deleted_client_id, client_name, document_number, address, email, deletion_date, deletion_time, operator) VALUES (OLD.client_id, OLD.client_name, OLD.document_number, OLD.address, OLD.email, CURDATE(), CURTIME(), USER())

  --Probamos eliminando el cliente 50 y chequeamos
  DELETE FROM `prestapp`.`clients` WHERE (`client_id` = '50');
  SELECT * FROM prestapp.deleted_clients;
  
  --NOTA: Este trigger solo elimina clientes que no tengan leads. (Las dos tablas estan relacionadas mediante una foreing key). Esto está hecho a propósito pues no queremos jamás borrar un cliente con un préstamo abierto.
  
  
  
  
  
  
  
  
  
