/*
use sakila;

DELIMITER $$
DROP PROCEDURE IF EXISTS damelistacorreo $$
CREATE PROCEDURE damelistacorreo(idstore INTEGER(10))
BEGIN
	DECLARE fin BOOL DEFAULT FALSE;
    DECLARE listacorreos TEXT DEFAULT '';
    DECLARE tmpemail VARCHAR(250) DEFAULT '';
    DECLARE correos CURSOR FOR SELECT email FROM sakila.customer WHERE store_id = idstore;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;
    
    OPEN correos;
    
    recorre: LOOP
		FETCH correos INTO tmpemail;
        
        IF fin THEN
			LEAVE recorre;
        END IF;
        
        SET listacorreos = concat(tmpemail, ';', listacorreos);
	END LOOP;
    
    CLOSE correos;
END $$

DELIMITER ;
call damelistacorreo(@damelista);
*/

