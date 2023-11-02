.headers on
SELECT
    sum(customer.c_acctbal) AS tot_acct_bal
FROM
    customer
JOIN
    nation ON customer.c_nationkey = nation.n_nationkey,
    region ON nation.n_regionkey = region.r_regionkey
WHERE
    customer.c_mktsegment = 'FURNITURE' AND
    region.r_name = 'AMERICA';