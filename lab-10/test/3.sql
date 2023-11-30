CREATE TRIGGER t3 AFTER UPDATE ON customer
FOR EACH ROW
WHEN (NEW.c_acctbal > 0 AND OLD.c_acctbal < 0)
BEGIN
    UPDATE customer SET c_comment = 'Positive balance' WHERE c_custkey = NEW.c_custkey;
END;

UPDATE customer 
SET c_acctbal = 100 
WHERE c_nationkey IN (
    SELECT n_nationkey 
    FROM nation 
    WHERE n_name = 'MOZAMBIQUE'
);

SELECT COUNT(*) AS customer_cnt
FROM customer
JOIN nation ON c_nationkey = n_nationkey
JOIN region ON n_regionkey = r_regionkey
WHERE r_name = 'AFRICA' AND c_acctbal < 0;
