-- SQLite
DROP TABLE product;
DROP TABLE pc;
DROP TABLE laptop;
DROP TABLE Printer;

CREATE TABLE product (
    maker CHAR(32),
    model INTEGER PRIMARY KEY,
    type VARCHAR(20) NOT NULL
);

CREATE TABLE pc (
    model INTEGER PRIMARY KEY,
    speed FLOAT,
    ram INTEGER,
    hd INTEGER,
    price DECIMAL(7,2) NOT NULL
);

CREATE TABLE laptop (
    model INTEGER PRIMARY KEY,
    speed FLOAT,
    ram INTEGER,
    hd INTEGER,
    screen DECIMAL(4,1),
    price DECIMAL(7,2) NOT NULL
);

CREATE TABLE printer (
    model INTEGER PRIMARY KEY,
    color BOOL,
    type VARCHAR(30),
    price decimal(7,2) NOT NULL
);

SELECT * FROM product;

-- SQLite

DELETE FROM product;
DELETE FROM pc;
DELETE FROM laptop;
DELETE FROM Printer;


INSERT INTO product VALUES('A', 1001, 'pc');
INSERT INTO product VALUES('A', 1002, 'pc');
INSERT INTO product VALUES('A', 1003, 'pc');
INSERT INTO product VALUES('A', 2004, 'laptop');
INSERT INTO product VALUES('A', 2005, 'laptop');
INSERT INTO product VALUES('A', 2006, 'laptop');

INSERT INTO product VALUES('B', 1004, 'pc');
INSERT INTO product VALUES('B', 1005, 'pc');
INSERT INTO product VALUES('B', 1006, 'pc');
INSERT INTO product VALUES('B', 2007, 'laptop');

INSERT INTO product VALUES('C', 1007, 'pc');

INSERT INTO product VALUES('D', 1008, 'pc');
INSERT INTO product VALUES('D', 1009, 'pc');
INSERT INTO product VALUES('D', 1010, 'pc');
INSERT INTO product VALUES('D', 3004, 'printer');
INSERT INTO product VALUES('D', 3005, 'printer');

INSERT INTO product VALUES('E', 1011, 'pc');
INSERT INTO product VALUES('E', 1012, 'pc');
INSERT INTO product VALUES('E', 1013, 'pc');
INSERT INTO product VALUES('E', 2001, 'laptop');
INSERT INTO product VALUES('E', 2002, 'laptop');
INSERT INTO product VALUES('E', 2003, 'laptop');
INSERT INTO product VALUES('E', 3001, 'printer');
INSERT INTO product VALUES('E', 3002, 'printer');
INSERT INTO product VALUES('E', 3003, 'printer');

INSERT INTO product VALUES('F', 2008, 'laptop');
INSERT INTO product VALUES('F', 2009, 'laptop');

INSERT INTO product VALUES('G', 2010, 'laptop');

INSERT INTO product VALUES('H', 3006, 'printer');
INSERT INTO product VALUES('H', 3007, 'printer');


INSERT INTO pc(model, speed, ram, hd, price) VALUES(1001, 2.66, 1024, 250, 2114);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1002, 2.10, 512, 250, 995);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1003, 1.42, 512, 80, 478);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1004, 2.80, 1024, 250, 649);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1005, 3.20, 512, 250, 630);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1006, 3.20, 1024, 320, 1049);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1007, 2.20, 1024, 200, 510);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1008, 2.20, 2048, 250, 770);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1009, 2.00, 1024, 250, 650);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1010, 2.80, 2048, 300, 770);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1011, 1.86, 2048, 160, 959);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1012, 2.80, 1024, 160, 649);
INSERT INTO pc(model, speed, ram, hd, price) VALUES(1013, 3.06, 512, 80, 529);


INSERT INTO laptop VALUES(2001, 2.00, 2048, 240, 20.1, 3673);
INSERT INTO laptop VALUES(2002, 1.73, 1024, 80, 17.0, 949);
INSERT INTO laptop VALUES(2003, 1.80, 512, 60, 15.4, 549);
INSERT INTO laptop VALUES(2004, 2.00, 512, 60, 13.3, 1150);
INSERT INTO laptop VALUES(2005, 2.16, 1024, 120, 17.0, 2500);
INSERT INTO laptop VALUES(2006, 2.00, 2048, 80, 15.4, 1700);
INSERT INTO laptop VALUES(2007, 1.83, 1024, 120, 13.3, 1429);
INSERT INTO laptop VALUES(2008, 1.60, 1024, 100, 15.4, 900);
INSERT INTO laptop VALUES(2009, 1.60, 512, 80, 14.1, 680);
INSERT INTO laptop VALUES(2010, 2.00, 2048, 160, 15.4, 2300);


INSERT INTO Printer(model, color, type, price) VALUES(3001, true, 'ink-jet', 99);
INSERT INTO Printer(model, color, type, price) VALUES(3002, false, 'laser', 239);
INSERT INTO Printer(model, color, type, price) VALUES(3003, true, 'laser', 899);
INSERT INTO Printer(model, color, type, price) VALUES(3004, true, 'ink-jet', 120);
INSERT INTO Printer(model, color, type, price) VALUES(3005, false, 'laser', 120);
INSERT INTO Printer(model, color, type, price) VALUES(3006, true, 'ink-jet', 100);
INSERT INTO Printer(model, color, type, price) VALUES(3007, true, 'laser', 200);


--Exercise 6.5.1 (page 295)
--a)
INSERT INTO product(model, maker, type) VALUES (1100, 'C', 'pc');
INSERT INTO pc VALUES (1100, 3.2, 1024, 180, 2499);

--c)
DELETE FROM pc WHERE hd < 100;

--e)
UPDATE product SET maker = 'A' WHERE maker = 'B';

--f)
UPDATE pc SET ram = ram*2, hd = hd+60;


with pc1 as(
select * from pc join product on pc.model = product.model
),
laptop1 as(
select * from laptop join product on laptop.model = product.model
)
select pc1.maker,pc1.model,laptop1.model,min(pc1.price+laptop1.price) 
from pc1,laptop1 
where pc1.maker = laptop1.maker 
group by pc1.maker;

with pc_min as (
    select maker, pc.model as pc_model, min(price) as pc_price from pc join product on pc.model = product.model group by maker
),
laptop_min as (
    select maker, laptop.model as laptop_model, min(price) as laptop_price from laptop join product on laptop.model = product.model group by maker
)
select p.maker, pc_model, laptop_model, pc_price + laptop_price as total_price 
from pc_min p join laptop_min l on p.maker = l.maker;

with makers as (
    select maker from product where type = 'pc'
    intersect
    select maker from product where type = 'laptop'
    intersect
    select maker from product where type = 'printer'
),
pc_avg as (
    select maker, avg(price) as pc_avg from pc join product on pc.model = product.model where maker in (select maker from makers) group by maker
),
laptop_avg as (
    select maker, avg(price) as laptop_avg from laptop join product on laptop.model = product.model where maker in (select maker from makers) group by maker
),
printer_avg as (
    select maker, avg(price) as printer_avg from printer join product on printer.model = product.model where maker in (select maker from makers) group by maker
)
select p.maker, pc_avg, laptop_avg, printer_avg 
from pc_avg p 
join laptop_avg l on p.maker = l.maker 
join printer_avg pr on p.maker = pr.maker;

   with makers as (
       select maker from product where type = 'pc'
       intersect
       select maker from product where type = 'laptop'
       intersect
       select maker from product where type = 'printer'
   ),
   pc_avg as (
       select maker, avg(price) as pc_avg from pc join product on pc.model = product.model where maker in (select maker from makers) group by maker
   ),
   laptop_avg as (
       select maker, avg(price) as laptop_avg from laptop join product on laptop.model = product.model where maker in (select maker from makers) group by maker
   ),
   printer_avg as (
       select maker, avg(price) as printer_avg from printer join product on printer.model = product.model where maker in (select maker from makers) group by maker
   )
   select p.maker, pc_avg, laptop_avg, printer_avg 
   from pc_avg p 
   join laptop_avg l on p.maker = l.maker 
   join printer_avg pr on p.maker = pr.maker;

WITH Maker_Avg AS (
    SELECT 
        p.maker,
        AVG(CASE WHEN p.type = 'pc' THEN pc.price ELSE NULL END) AS pc_avg,
        AVG(CASE WHEN p.type = 'laptop' THEN l.price ELSE NULL END) AS laptop_avg,
        AVG(CASE WHEN p.type = 'printer' THEN pr.price ELSE NULL END) AS printer_avg
    FROM product p
    LEFT JOIN pc ON p.model = pc.model
    LEFT JOIN laptop l ON p.model = l.model
    LEFT JOIN printer pr ON p.model = pr.model
    GROUP BY p.maker
    HAVING 
        COUNT(DISTINCT CASE WHEN p.type = 'pc' THEN p.model END) > 0 AND
        COUNT(DISTINCT CASE WHEN p.type = 'laptop' THEN p.model END) > 0 AND
        COUNT(DISTINCT CASE WHEN p.type = 'printer' THEN p.model END) > 0
)
SELECT maker, pc_avg, laptop_avg, printer_avg
FROM Maker_Avg;

with pc_maker as(
select pc.model,maker,price from product join pc on pc.model = product.model
),
laptop_maker as(
select laptop.model,maker,price from product join laptop on laptop.model = product.model
),
printer_maker as(
select printer.model,maker,price from product join printer on printer.model = product.model
)

select pc_maker.maker,pc_maker.model as pc_model,printer_maker.model as printer_model, laptop_maker.model as laptop_model, pc_maker.price+laptop_maker.price+printer_maker.price as total_price from pc_maker,laptop_maker,printer_maker where pc_maker.maker = printer_maker.maker and pc_maker.maker = laptop_maker.maker order by total_price asc limit 1

select maker,pc.model from pc,product where pc.model = product.model group by maker having min(price)

select count(distinct pc_model) from (
)

select count(distinct pc.model) from pc

select  
    maker,count(distinct printer.model),count(distinct pc.model) 
from 
    product
left outer join 
    pc on pc.model = product.model
left outer join
    printer on printer.model = product.model
group by maker
