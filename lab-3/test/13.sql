.headers on
SELECT
    supplier.s_name,
    count(*) as discounted_items
FROM
    supplier
JOIN
    lineitem ON lineitem.l_suppkey = supplier.s_suppkey
WHERE
    lineitem.l_discount = 0.1
GROUP BY
    supplier.s_name