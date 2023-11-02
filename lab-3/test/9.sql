.headers on
SELECT
    strftime('%Y-%m', lineitem.l_receiptdate) AS year_month,
    count(*) AS items
FROM
    lineitem
JOIN
    orders ON lineitem.l_orderkey = orders.o_orderkey
WHERE
    orders.o_custkey = '000000227'
GROUP BY
    year_month
ORDER BY
    year_month;
