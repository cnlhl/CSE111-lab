.headers on
SELECT
    count(*) AS order_cnt
FROM
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    nation ON customer.c_nationkey = nation.n_nationkey
WHERE
    orders.o_orderpriority = '1-URGENT' AND
    nation.n_name = 'ROMANIA' AND
    orders.o_orderdate >= '1993-01-01' AND
    orders.o_orderdate <= '1997-12-31';
