DELIMITER //
CREATE procedure place_order(IN array varchar(10),IN id int,IN num int)
BEGIN
DECLARE i INT DEFAULT 1;

SET @sql=CONCAT('SELECT sum(price) INTO @sum from info_price where id in(',array,')');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql=CONCAT('INSERT INTO info_order (order_cost,user_id,date) values( ',@sum,',',id,',\'',CURDATE(),'\')');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql=CONCAT('SELECT max(order_id) INTO @order_id from info_order');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

while num > 0 do
SET @sql=CONCAT('INSERT INTO t_order values(',@order_id,',',SUBSTR(array, i, 1),')');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql=CONCAT('UPDATE info_price SET quantity=quantity-1 where id=',SUBSTR(array, i, 1));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET i:=i+2;
SET num:=num-1;
END while;
END; //
