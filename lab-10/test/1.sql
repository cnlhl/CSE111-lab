CREATE TRIGGER t1 AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderdate = '2023-12-01'
    WHERE rowid = NEW.rowid;
END;

INSERT INTO orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment)
SELECT  (SELECT MAX(o_orderkey) FROM orders) + row_number() OVER (ORDER BY o_orderkey), o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment
FROM orders
WHERE o_orderdate >= '1995-12-01' AND o_orderdate < '1996-01-01';

SELECT  max(o_orderkey) FROM orders;

SELECT COUNT(*) AS orders_cnt
FROM orders
WHERE o_orderdate >= '2023-01-01' AND o_orderdate < '2024-01-01';
