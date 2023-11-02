.headers on
select
    customer.c_name as customer,
    sum(orders.o_totalprice) as total_price
FROM
    orders
JOIN
    customer on customer.c_custkey = orders.o_custkey,
    nation on nation.n_nationkey = customer.c_nationkey
WHERE
    nation.n_name = 'ARGENTINA' AND
    strftime('%Y',orders.o_orderdate) = '1996'
GROUP BY
    customer;
