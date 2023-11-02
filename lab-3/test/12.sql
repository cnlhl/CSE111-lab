.headers on
SELECT
    strftime('%Y', orders.o_orderdate) AS year,
    count(*) AS item_cnt
FROM
    orders
JOIN
    lineitem ON orders.o_orderkey = lineitem.l_orderkey,
    supplier ON supplier.s_suppkey = lineitem.l_suppkey,
    nation ON supplier.s_nationkey = nation.n_nationkey
WHERE
    orders.o_orderpriority = '3-MEDIUM' AND
    (nation.n_name = 'ARGENTINA' OR nation.n_name = 'BRAZIL')
GROUP BY
    strftime('%Y', orders.o_orderdate)