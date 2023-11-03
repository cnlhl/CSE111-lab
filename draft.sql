-- # w_warehousekey, increasing number that is unique across the tuples in the table
-- # w_name: concatenating the supplier name with “____” and with the name of the nation where the warehouse is located
-- # w_capacity: triple of the maximum total part size across all the nations(total size is sum of the parts (p size) supplied by the supplier to the customers in a nation.),three warehouses owned by a supplier have the same capacity
-- # s_suppkey, each supplier has three warehouses
-- # n_nationkey: have the largest number of lineitems supplied by the supplier that are ordered by customers from that nation.

CREATE TABLE warehouse (
    w_warehousekey INTEGER PRIMARY KEY AUTOINCREMENT,
    w_name TEXT NOT NULL,
    w_capacity INTEGER NOT NULL,
    s_suppkey INTEGER NOT NULL,
    n_nationkey INTEGER NOT NULL
);

SELECT * FROM(
    SELECT *,row_number() over (partition by s_suppkey order by l_extendedprice ) as rn
    FROM(
        SELECT s_suppkey,l_extendedprice
        FROM  Supplier,Lineitem
        WHERE s_suppkey = l_suppkey
        ORDER BY s_suppkey,l_extendedprice DESC
    ) AS newtab
) WHERE rn <= 3;

WITH temp_tb AS(
    SELECT  *
    FROM(
        SELECT  supplier.s_suppkey AS supplier_key,
                supplier.s_name AS supplier_name,
                nation.n_nationkey AS cus_nationkey,
                nation.n_name AS cus_nationname,
                sum(part.p_size) AS total_size,
                count(*) AS total_lineitem,
                row_number() over (partition by supplier.s_suppkey order by count(*) DESC) AS rn
        FROM    lineitem
        JOIN    part ON lineitem.l_partkey = part.p_partkey
        JOIN    supplier ON lineitem.l_suppkey = supplier.s_suppkey
        JOIN    orders ON lineitem.l_orderkey = orders.o_orderkey
        JOIN    customer ON orders.o_custkey = customer.c_custkey
        JOIN    nation ON customer.c_nationkey = nation.n_nationkey
        GROUP BY supplier.s_suppkey, nation.n_nationkey
    ) WHERE rn <= 3
)

INSERT INTO warehouse (w_warehousekey,w_name,w_capacity,w_suppkey,w_nationkey)
SELECT  row_number() OVER () AS w_warehousekey,
        supplier_name || '____' || cus_nationname AS w_name,
        total_size*3 AS w_capacity,
        supplier_key AS w_suppkey,
        cus_nationkey AS w_nationkey
FROM    temp_tb;

SELECT * FROM warehouse;