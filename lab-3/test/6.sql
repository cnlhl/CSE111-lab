.headers on
SELECT
    nation.n_name,
    SUM(supplier.s_acctbal) AS total_acct_bal
FROM
    supplier
JOIN
    nation ON nation.n_nationkey = supplier.s_nationkey
GROUP BY
    nation.n_name, nation.n_nationkey;