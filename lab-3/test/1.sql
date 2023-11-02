.headers on
SELECT 
    count(*) as item_cnt
FROM 
    lineitem
WHERE 
    l_shipdate<l_commitdate;