DELIMITER //
CREATE procedure sale(IN month1 INT)
BEGIN
	SELECT sum(order_cost) as sale from info_order where month(info_order.date)=month1; 
END; //
