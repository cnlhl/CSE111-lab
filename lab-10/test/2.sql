CREATE TRIGGER t2 AFTER UPDATE ON customer
FOR EACH ROW
WHEN (OLD.c_acctbal > 0 AND NEW.c_acctbal < 0)
BEGIN
    UPDATE customer SET c_comment = 'Negative balance!!!' 
    WHERE c_custkey = NEW.c_custkey;
END;

UPDATE customer 
SET c_acctbal = -100 
WHERE c_nationkey IN (
    SELECT n_nationkey FROM nation WHERE n_regionkey IN (
        SELECT r_regionkey FROM region WHERE r_name = 'AFRICA'
    )
);

SELECT COUNT(*) AS customer_cnt
FROM customer
JOIN nation ON c_nationkey = n_nationkey
WHERE n_nationname = 'EGYPT' AND c_acctbal < 0;
