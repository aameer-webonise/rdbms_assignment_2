DELIMITER //
CREATE procedure profit()
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
	DECLARE user_name VARCHAR(50);
	DECLARE price INT;
	DECLARE cost INT;
	DECLARE profit INT;
	DECLARE user_id INT;
	DECLARE user_cur CURSOR FOR select user.name,info_price.price,info_price.seller_price from product inner join user on product.seller=user.id 					    inner join info_price on product.id=info_price.id;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	OPEN user_cur;
	get_user: LOOP
		  FETCH user_cur INTO user_name,price,cost;
		  IF finished THEN
	    	  	LEAVE get_user;
		  END IF;
		  SET profit:=price-cost;
		  SELECT CONCAT('Profit For Seller ',user_name,' is ',profit);
	END LOOP get_user;
	CLOSE user_cur;
END; //
