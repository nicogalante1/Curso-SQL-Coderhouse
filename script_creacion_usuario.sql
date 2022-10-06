-- Alumno: Nicola Galante Giovannone / Parrilla 34945

-- Entramos a la tabla user
USE mysql;

-- Creamos los nuevos usuaros en ala instancia local
CREATE USER 'leonel'@'localhost';
CREATE USER 'daniela'@'localhost';

--Verificamos
SELECT * from user;

-Otorgamos persmisos
GRANT SELECT ON *.* to 'daniela'@'localhost';
GRANT SELECT, UPDATE, INSERT ON *.* to 'leonel'@'localhost';

--Guardamos
COMMIT;
