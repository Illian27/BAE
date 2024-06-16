# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;

-- Ejecutar las funciones antes de este procedimiento
DELIMITER $$
DROP PROCEDURE IF EXISTS es_jefe_de $$
CREATE PROCEDURE es_jefe_de (nombreJefe VARCHAR(15))
BEGIN
	-- Variable que terminará el bucle
	DECLARE final BOOL DEFAULT FALSE;
    -- Recibe el nombre de turno del cursor
    DECLARE nombreCursor VARCHAR(15) DEFAULT '';
    -- Variable donde se almacenarán todos los valores del cursor
    DECLARE nombresTrabajadores TEXT DEFAULT '';
    
    /* Declaramos un cursor que recorra todos los nombres de aquellos trabajadores que 
    tengan como id de jefe el id que nos devuelve la funcion*/
    DECLARE trabajadores CURSOR FOR
    SELECT nombre FROM trabajador INNER JOIN es_jefe_de
    ON trabajador_id = id
    WHERE jefe_id = (SELECT (devolver_id(nombreJefe)));
    
    /* Declaramos un handler para cuando el cursor ya no tenga más valores, no salte un error, 
    el procedimiento continue y ponga la variable "final" a true */
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET final=TRUE;
    
    -- Empezamos a recorrer el cursor indeterminadamente
    OPEN trabajadores;
    recorre: LOOP
		-- Guardando cada nombre en la lista de los nombres
		FETCH trabajadores INTO nombreCursor;
        
        -- Si hemos llegado al final del cursor nos salimos del bucle
        IF final = TRUE THEN
			LEAVE recorre;
        END IF;
        
		-- Añadimos el nombre obtenido a la lista de nombres
        SET nombresTrabajadores = concat(nombreCursor, '; ' , nombresTrabajadores);
        
	-- Cerramos todo
    END LOOP;
    CLOSE trabajadores;
    
    -- Si la variable donde se almacenan los nombres sigue por defecto asignale este valor
    IF (SELECT nombresTrabajadores) LIKE '' THEN
		set nombresTrabajadores = 'No es jefe de nadie';
    END IF;
    
    -- Seleccionamos lo obtenido
    SELECT nombresTrabajadores;
END $$

DELIMITER ;
CALL es_jefe_de('Juan'); -- Es jefe de dos
CALL es_jefe_de('Maria'); -- Es jefe de 1
CALL es_jefe_de('Carlos'); -- No es jefe de nadie