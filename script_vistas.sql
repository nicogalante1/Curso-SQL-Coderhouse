-- Alumno: Nicola Galante Giovannone / Parrilla 34945

-- Vista renovadores 
-- Esta vista muestra los clientes que han finalizado un préstamo y son aptos de renovación

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `renovadores` AS
    SELECT 
        `loan`.`client_id` AS `client_id`,
        `leads`.`lead_name` AS `lead_name`,
        `loan`.`employer_id` AS `employer_id`,
        `leads`.`payroll` AS `payroll`
    FROM
        (`loan`
        JOIN `leads` ON ((`loan`.`client_id` = `leads`.`client_id`)))
   WHERE 
        (`loan`.`loan_status` = '11')       --status 11 es "Cerrado/finalizado"
    GROUP BY `loan`.`client_id`

--Vista morosos
-- Esta vista muestra los clientes que no han pagado en tiempo y forma y deben ser contactado por los operadores



-- Vista cambios_por_operador
-- Esta vista enumera la cantidad de cambios de estado ejecutados por operador para controlar la cantidad de interacción manual que ha habido fuera de los procesos normales, la idealidad es 0.

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `cambios_por_operador` AS
    SELECT 
        `operator`.`email` AS `operador`,
        COUNT(`loan_status_history`.`operator`) AS `cambios`
    FROM
        (`operator`
        JOIN `loan_status_history` ON ((`operator`.`email` = `loan_status_history`.`operator`)))
    GROUP BY `operador`
    
-- Vista prestamos_por_cliente    
-- Esta vista enumera la cantidad de créditos que ha pedido un cliente y puede usarse como dato fundamental en diferentes dashboards de análisis de datos.

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `prestamos_por_cliente` AS
    SELECT 
        `leads`.`client_id` AS `client_id`,
        `leads`.`lead_name` AS `nombre`,
        COUNT(`leads`.`lead_status`) AS `cantidad_prestamos`
    FROM
        `leads`
    WHERE
        (`leads`.`lead_status` = 2)
    GROUP BY `leads`.`client_id`
    
    -- Vista listado_aceptados
    -- Esta vista lista históricamente los clientes con créditos aprobados
    CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `listado_aceptados` AS
    SELECT 
        `leads`.`lead_id` AS `lead_id`,
        `leads`.`lead_name` AS `lead_name`,
        `status_leads`.`status_name` AS `status_name`
    FROM
        (`leads`
        JOIN `status_leads` ON ((`leads`.`lead_status` = `status_leads`.`status_id`)))
    WHERE
        (`leads`.`lead_status` = 2)

