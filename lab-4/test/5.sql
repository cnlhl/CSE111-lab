.headers on
SELECT
    nation.n_name as country,
    count(*) as cnt
FROM
    supplier
JOIN
    nation ON supplier.s_nationkey = nation.n_nationkey
WHERE
    country = 'ARGENTINA' OR
    country = 'BRAZIL'
GROUP BY
    country;