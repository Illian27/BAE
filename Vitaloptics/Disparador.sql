# Hecho por: Illian Santiago Ortega Posso
USE vitaloptics;

DELIMITER $$

-- Cuando solo quede un producto en el stock, no se permitirá borrarlo y saltará un aviso de que es el último
DROP TRIGGER IF EXISTS vigilaStock $$
CREATE TRIGGER vigilaStock BEFORE UPDATE ON producto FOR EACH ROW
BEGIN
	IF NEW.stock <= 1 THEN
		SIGNAL SQLSTATE '45000' SET message_text='Solo queda esta unidad';
	END IF;
END $$

DELIMITER ;
UPDATE producto SET stock = 1 WHERE nombre like 'Silla';