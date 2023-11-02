CREATE TABLE R(
a INTEGER,
b INTEGER
)

CREATE TABLE S(
a INTEGER,
c INTEGER,
d INTEGER
)

drop TABLE S

.schema

INSERT INTO R(a,b) VALUES (2,7)
INSERT INTO R(a,b) VALUES (4,5)
INSERT INTO R(a,b) VALUES (3,6)

INSERT INTO S VALUES (3,6,4)
INSERT INTO S VALUES (4,7,2)
INSERT INTO S VALUES (2,5,5)

select * from R

select * from R,S

select R.a,R.b from R,S WHERE b=c

select R.a from R,S WHERE b>=c

select * from S S1,S S2 WHERE S1.a<>S2.d

select * from R,S S1,S S2 WHERE R.a = S1.d

SELECT b AS x FROM R INTERSECT SELECT c AS x FROM s