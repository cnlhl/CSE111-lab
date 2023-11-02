.headers on

SELECT
    nation.n_name AS country
FROM
    lineitem
JOIN
    partsupp ON partsupp.ps_partkey = lineitem.l_partkey,
    supplier ON partsupp.ps_suppkey = supplier.s_suppkey,
    nation ON nation.n_nationkey = supplier.s_nationkey
WHERE
    strftime('%Y', lineitem.l_shipdate) = '1994'
GROUP BY
    country
HAVING
    sum(lineitem.l_extendedprice) = (
        SELECT
            min(revenue)
        FROM
            (
                SELECT
                    sum(lineitem.l_extendedprice) AS revenue
                FROM
                    lineitem
                JOIN
                    partsupp ON partsupp.ps_partkey = lineitem.l_partkey,
                    supplier ON partsupp.ps_suppkey = supplier.s_suppkey,
                    nation ON nation.n_nationkey = supplier.s_nationkey
                WHERE
                    strftime('%Y', lineitem.l_shipdate) = '1994'
                GROUP BY
                    nation.n_name
            )
    )
ORDER BY
    sum(lineitem.l_extendedprice) ASC;

    