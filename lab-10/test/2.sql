CREATE TRIGGER t2 AFTER UPDATE bal ON OF c_acctcustomer
FOR EACH ROW
WHEN (OLD.c_acctbal > 0 AND NEW.c_acctbal < 0)
BEGIN
    UPDATE customer SET c_comment = 'Negative balance!!!' WHERE c_custkey = NEW.c_custkey;
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
WHERE c_nationkey IN (
    SELECT n_nationkey FROM nation WHERE n_name = 'EGYPT'
) AND c_acctbal < 0;
