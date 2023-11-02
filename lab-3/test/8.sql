.headers on
SELECT
    DISTINCT nation.n_name
FROM
    nation
JOIN 
    customer ON customer.c_nationkey = nation.n_nationkey,
    orders ON orders.o_custkey = customer.c_custkey
WHERE
    strftime('%Y', orders.o_orderdate) = '1994' AND 
    strftime('%m', orders.o_orderdate) = '12'
ORDER BY
    nation.n_name;