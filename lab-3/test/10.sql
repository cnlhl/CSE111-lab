.headers on
SELECT
    supplier.s_name,
    supplier.s_acctbal
FROM
    supplier
JOIN
    nation ON supplier.s_nationkey = nation.n_nationkey,
    region ON nation.n_regionkey = region.r_regionkey
WHERE
    supplier.s_acctbal>5000 AND
    region.r_name = 'ASIA';