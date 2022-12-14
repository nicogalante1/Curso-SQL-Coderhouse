-- Primer Script
-- Este script generará una cuenta de email, una contraseña segura y registrará en la tabla 'operadores' a un operador a partir de su nombre y apellido.

CREATE DEFINER=`root`@`localhost` PROCEDURE `nuevo_operador`(IN operator_name VARCHAR(50), IN surname VARCHAR(50))
BEGIN
DECLARE email VARCHAR(50);
DECLARE operator_password VARCHAR(50);
SET email = CONCAT(operator_name, surname, '@prestapp.com');   -- El mail será el nombre y apellido del operador + el dominio (prestapp.com)
SET operator_password =  MD5(CONCAT('prestapp', surname));     -- está función la encontré en internet, "hashea" un texto creando una contraseña única, irrepetible a partir de la palabra "prestapp" y el apellido del operador. No se puede regresar el hash así que no se pueden adivinar las contraseñas al menos que un agente externo conozca los parámetros
INSERT INTO operator (`email`,`operator_name`,`surname`,`password`) VALUES (email, operator_name,surname,operator_password);   -- Lo inserta en la tabla
END

--Segundo Script
--Cambia a estado cerrado a los clientes que en el proceso hayan hecho una denuncia

CREATE DEFINER=`root`@`localhost` PROCEDURE `pasar_a_judicial`(in client_id int, in due_amount float)
BEGIN
IF due_amount < 500 then
UPDATE prestapp.loan SET loan_status = '12' WHERE (loan.client_id = client_id);
else 
select 'No se pueden cerrar casos que deben 500 o más. Resolver con abogado';
end IF; 
END
