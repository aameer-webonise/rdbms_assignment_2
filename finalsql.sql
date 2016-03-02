
create table user_type (id int primary key,type varchar(10));
alter table user_type add check (type='buyer' OR type='seller');


create table user(id int primary key,name varchar(20),email varchar(20) unique,password varchar(20),user_type_id int,FOREIGN KEY (user_type_id) REFERENCES user_type(id),CONSTRAINT name CHECK (name LIKE '%[^A-Z]%'));


create table info_color(color_id int primary key,name varchar(10));


create table product (id int primary key,name varchar(20),color_id int,seller int,FOREIGN KEY (color_id) REFERENCES info_color(color_id),FOREIGN KEY(seller) REFERENCES user(id));



create table info_price (id int,price double,FOREIGN KEY (id) REFERENCES product(id));


create table info_order(order_id int primary key,order_cost double,user_id int,date date,FOREIGN KEY (user_id) REFERENCES user(id));
alter table info_order AUTO_INCREMENT=1001;

create table t_order(order_id int,product_id int,FOREIGN KEY (order_id) REFERENCES info_order(order_id),FOREIGN KEY (product_id) REFERENCES product(id));



insert into user values(111,'Jack','jack@gmail.com','mynameisJack',1);
insert into user values(112,'Mack','Mack@gmail.com','mynameisMack',2);
insert into user values(113,'Jason','jason@gmail.com','mynameisJason',1);
insert into user values(114,'John','john@gmail.com','mynameisJohn',2);
insert into user values(115,'Jason','Raju@gmail.com','mynameisRaju',2);
insert into user values(116,'viru','viru@gmail.com','mynameisviru',2);
insert into user values(117,'Arjun','arjun@gmail.com','mynameisArjun',2);
insert into user values(118,'Rohit','rohit@gmail.com','mynameisRohit',1);


insert into user_type values(1,'buyer');
insert into user_type values(2,'seller');



insert into info_order values('or100001',3000,112,'2015-2-27');
insert into info_order values('or100002',3000,111,'2015-2-27');
insert into info_order values('or100003',4000,113,'2015-2-28');
insert into info_order values('or100004',3500,118,'2015-2-28');
insert into info_order values('or100005',9000,118,'2015-3-1');
insert into info_order values('or100006',9000,113,'2015-3-2');



insert into t_order values('or100001',1);
insert into t_order values('or100001',2);
insert into t_order values('or100002',4);
insert into t_order values('or100003',3);
insert into t_order values('or100003',5);
insert into t_order values('or100004',2);
insert into t_order values('or100004',3);
insert into t_order values('or100005',6);
insert into t_order values('or100005',7);
insert into t_order values('or100006',6);
insert into t_order values('or100006',7);




insert into product values(1,'Dell',201,112);
insert into product values(2,'Dell',202,114);
insert into product values(3,'HP',201,115);
insert into product values(4,'HP',203,116);
insert into product values(5,'Accer',201,117);
insert into product values(6,'Apple',201,117);
insert into product values(7,'Apple',202,117);



insert into info_price values(1,1000,9);
insert into info_price values(2,2000,6);
insert into info_price values(3,1500,4);
insert into info_price values(4,3000,10);
insert into info_price values(5,2500,3);
insert into info_price values(6,5000,7);
insert into info_price values(7,4000,6);



insert into info_color values(201,'black');
insert into info_color values(202,'white');
insert into info_color values(203,'orange');


<!--Question 3-->
select user_type.type from user inner join user_type on user.user_type_id=user_type.id where user.name='jack';


<!--Question 4-->
select user.name as "Seller",group_concat(concat(product.name,'-',info_color.name)) as "Product Names" from user inner join product on user.id=product.seller inner join info_color on info_color.color_id=product.color_id group by product.seller;


<!--Question 5-->
create or replace view order_details as select info_order.order_id as "Order ID",user.name as "Seller Name",sum(info_price.price),info_order.date from info_order inner join t_order on info_order.order_id=t_order.order_id inner join product on product.id=t_order.product_id inner join user on product.seller=user.id inner join info_price on product.id=info_price.id group by info_order.order_id,user.name;


<!--Question 6-->
select info_order.order_id as "Order ID",info_order.date as "Order Date",group_concat(concat(product.name,'-',info_color.name)) as "Product Names",group_concat(info_price.price) as "Price of Each Product",sum(info_price.price)as "Total Cost",user.name as "User Name",user.email as "Email" from info_order inner join t_order on info_order.order_id=t_order.order_id inner join product on t_order.product_id=product.id inner join info_price on product.id=info_price.id inner join info_color on info_color.color_id=product.color_id inner join user on info_order.user_id=user.id where 2=month(date) group by info_order.order_id;



