.headers on
SELECT 
    min(c_acctbal) AS min_acct_bal,
    max(c_acctbal) AS max_acct_bal,
    sum(c_acctbal) AS tot_acct_bal
FROM
    customer
WHERE
    c_mktsegment = "FURNITURE";
