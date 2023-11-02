.headers on
SELECT
    region.r_name,
    count(*) AS order_cnt
FROM
    region
JOIN
    nation ON nation.n_regionkey = region.r_regionkey,
    customer ON customer.c_nationkey = nation.n_nationkey,
    orders ON orders.o_custkey = customer.c_custkey
WHERE
    orders.o_orderstatus = 'F'
GROUP BY
    region.r_name;