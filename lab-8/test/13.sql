.eqp on
.headers on

select s_name, count(*) as discounted_items
from lineitem, supplier
where l_suppkey = s_suppkey and l_discount = 0.10
group by s_name;
