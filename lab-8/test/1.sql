.eqp on
.headers on

select count(*) as item_cnt
from lineitem
where l_shipdate < l_commitdate;
