--  1era: Funcion que calcula montos a ofertar a clientes que ya finalizaron un prestamo
CREATE  FUNCTION monto_renovar (finalizados INT, ultimo_monto_aprobado FLOAT) RETURNS float
    DETERMINISTIC
BEGIN
	DECLARE calculo float;
    DECLARE multiplicador float;
    set multiplicador = ((finalizados/10) + 1.00);              -- Aquí, la cantidad de créditos finalizados hacen una especie de multiplicador, para ofrecer cada vez más.
    set calculo = (ultimo_monto_aprobado * multiplicador);      -- Aquí, aplica el multiplicador al monto del último prestamo, resultando en el nuevo monto.
RETURN calculo;
END

    -- Ejemplo de uso
    SELECT clients.client_id, clients.client_name, 
    monto_renovar(
    (select count(loan_id) from loan where loan.loan_status = 11 group by loan.client_id)
    ,
    (select total_amount from loan group by client_id order by loan_id desc limit 1)) as Monto_Oferta
    FROM clients 
    join loan on clients.client_id = loan.client_id
    where loan.loan_status = 11
    group by loan.client_id;
    

-- 2da:
 
