CREATE TRIGGER update_orderpriority_after_insert AFTER INSERT ON lineitem
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderpriority = '2-HIGH'
    WHERE o_orderkey = NEW.l_orderkey;
END;

CREATE TRIGGER update_orderpriority_after_delete AFTER DELETE ON lineitem
FOR EACH ROW
BEGIN
    UPDATE orders
    SET o_orderpriority = '2-HIGH'
    WHERE o_orderkey = OLD.l_orderkey;
END;

DELETE FROM lineitem
WHERE l_orderkey IN (
    SELECT o_orderkey
    FROM orders
    WHERE strftime('%Y-%m', o_orderdate) = '1995-12'
);

SELECT COUNT(*) AS orders_cnt
FROM orders
WHERE o_orderpriority = 'HIGH' AND
    strftime('%Y-%m', o_orderdate) IN ('1995-09', '1995-10', '1995-11', '1995-12');