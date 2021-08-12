SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue 
FROM sausage.lineorder_flat_left_all
WHERE toYear(LO_ORDERDATE) = 1993 
AND LO_DISCOUNT BETWEEN 1 AND 3 
AND LO_QUANTITY < 25;

SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue 
FROM sausage.lineorder_flat_left_all 
WHERE toYYYYMM(LO_ORDERDATE) = 199401 
AND LO_DISCOUNT BETWEEN 4 AND 6 
AND LO_QUANTITY BETWEEN 26 AND 35;

SELECT sum(LO_EXTENDEDPRICE * LO_DISCOUNT) AS revenue 
FROM sausage.lineorder_flat_left_all 
WHERE toISOWeek(LO_ORDERDATE) = 6 
AND toYear(LO_ORDERDATE) = 1994 
AND LO_DISCOUNT BETWEEN 5 AND 7 
AND LO_QUANTITY BETWEEN 26 AND 35;

SELECT sum(LO_REVENUE), toYear(LO_ORDERDATE) AS year, P_BRAND 
FROM sausage.lineorder_flat_left_all  
WHERE P_CATEGORY = 'MFGR#12' 
AND S_REGION = 'AMERICA' 
GROUP BY year, P_BRAND 
ORDER BY year, P_BRAND;

SELECT sum(LO_REVENUE), toYear(LO_ORDERDATE) AS year, P_BRAND 
FROM sausage.lineorder_flat_left_all  
WHERE P_BRAND BETWEEN 'MFGR#2221' AND 'MFGR#2228' 
AND S_REGION = 'ASIA' 
GROUP BY year, P_BRAND 
ORDER BY year, P_BRAND;

SELECT sum(LO_REVENUE), toYear(LO_ORDERDATE) AS year, P_BRAND 
FROM sausage.lineorder_flat_left_all  
WHERE P_BRAND = 'MFGR#2239' AND S_REGION = 'EUROPE' 
GROUP BY year, P_BRAND 
ORDER BY year, P_BRAND;

SELECT C_NATION, S_NATION, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue 
FROM sausage.lineorder_flat_left_all  
WHERE C_REGION = 'ASIA' 
AND S_REGION = 'ASIA' 
AND year >= 1992 
AND year <= 1997 
GROUP BY C_NATION, S_NATION, year 
ORDER BY year asc, revenue desc;

SELECT C_CITY, S_CITY, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue 
FROM sausage.lineorder_flat_left_all  
WHERE C_NATION = 'UNITED STATES' 
AND S_NATION = 'UNITED STATES' 
AND year >= 1992 
AND year <= 1997 
GROUP BY C_CITY, S_CITY, year 
ORDER BY year asc, revenue desc;

SELECT C_CITY, S_CITY, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue 
FROM sausage.lineorder_flat_left_all  
WHERE (C_CITY = 'UNITED KI1' OR C_CITY = 'UNITED KI5') 
AND (S_CITY = 'UNITED KI1' OR S_CITY = 'UNITED KI5') 
AND year >= 1992 AND year <= 1997 
GROUP BY C_CITY, S_CITY, year 
ORDER BY year asc, revenue desc;

SELECT C_CITY, S_CITY, toYear(LO_ORDERDATE) AS year, sum(LO_REVENUE) AS revenue 
FROM sausage.lineorder_flat_left_all  
WHERE (C_CITY = 'UNITED KI1' OR C_CITY = 'UNITED KI5') 
AND (S_CITY = 'UNITED KI1' OR S_CITY = 'UNITED KI5') 
AND toYYYYMM(LO_ORDERDATE) = '199712' 
GROUP BY C_CITY, S_CITY, year 
ORDER BY year asc, revenue desc;

SELECT toYear(LO_ORDERDATE) AS year, C_NATION, sum(LO_REVENUE - LO_SUPPLYCOST) AS profit 
FROM sausage.lineorder_flat_left_all  
WHERE C_REGION = 'AMERICA' 
AND S_REGION = 'AMERICA' 
AND (P_MFGR = 'MFGR#1' OR P_MFGR = 'MFGR#2') 
GROUP BY year, C_NATION 
ORDER BY year, C_NATION;

SELECT toYear(LO_ORDERDATE) AS year, S_NATION, P_CATEGORY, sum(LO_REVENUE - LO_SUPPLYCOST) AS profit 
FROM sausage.lineorder_flat_left_all  
WHERE C_REGION = 'AMERICA' 
AND S_REGION = 'AMERICA' 
AND (year = 1997 OR year = 1998) 
AND (P_MFGR = 'MFGR#1' OR P_MFGR = 'MFGR#2') 
GROUP BY year, S_NATION, P_CATEGORY 
ORDER BY year, S_NATION, P_CATEGORY;

SELECT toYear(LO_ORDERDATE) AS year, S_CITY, P_BRAND, sum(LO_REVENUE - LO_SUPPLYCOST) AS profit 
FROM sausage.lineorder_flat_left_all  
WHERE S_NATION = 'UNITED STATES' 
AND (year = 1997 OR year = 1998) 
AND P_CATEGORY = 'MFGR#14' 
GROUP BY year, S_CITY, P_BRAND 
ORDER BY year, S_CITY, P_BRAND;