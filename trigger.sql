DELIMITER //
CREATE TRIGGER update_product_id
BEFORE UPDATE ON product
FOR EACH ROW
BEGIN
	SET @new=NEW.id;
	SET @old=OLD.id;
	UPDATE t_order SET product_id=@new WHERE product_id=@old;
	UPDATE info_price SET id=@new WHERE id=@old;

END;//
