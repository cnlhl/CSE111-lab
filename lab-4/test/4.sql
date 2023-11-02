.headers on
SELECT
    supplier.s_name as supplier,
    count(*) as cnt
FROM
    part
JOIN
    partsupp ON part.p_partkey = partsupp.ps_partkey,
    supplier ON partsupp.ps_suppkey = supplier.s_suppkey,
    nation ON supplier.s_nationkey = nation.n_nationkey
WHERE
    nation.n_name = 'KENYA' AND
    part.p_container LIKE '%BOX%'
GROUP BY
    supplier;

