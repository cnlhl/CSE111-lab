.headers on
-- largest money: per custome or the whole nation

SELECT
    nation.n_name AS country
FROM
    orders
JOIN
    customer ON customer.c_custkey = orders.o_custkey,
    nation ON customer.c_nationkey = nation.n_nationkey
GROUP BY
    customer.c_name
ORDER BY
    sum(orders.o_totalprice) DESC
LIMIT
    1;
