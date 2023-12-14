CREATE TRIGGER t5 AFTER DELETE ON part 
FOR EACH ROW
BEGIN
    DELETE FROM partsupp WHERE partsupp.ps_partkey = OLD.p_partkey;
    DELETE FROM lineitem WHERE lineitem.l_partkey = OLD.p_partkey;
END;

DELETE FROM part
WHERE part.p_partkey IN (
    SELECT partsupp.ps_partkey
    FROM partsupp
    JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
    JOIN nation ON supplier.s_nationkey = nation.n_nationkey
    WHERE nation.n_name = 'KENYA' OR 'MOROCCO'
);

SELECT nation.n_name AS country, count(DISTINCT partsupp.ps_partkey) AS parts_cnt
FROM partsupp
JOIN supplier ON partsupp.ps_suppkey = supplier.s_suppkey
JOIN nation ON supplier.s_nationkey = nation.n_nationkey
JOIN region ON nation.n_regionkey = region.r_regionkey
WHERE region.r_name = 'AFRICA'
GROUP BY nation.n_name
ORDER BY parts_cnt ASC;