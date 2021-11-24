-- Memahami table

SELECT * FROM orders_1 limit 5;
SELECT * FROM orders_2 limit 5;
SELECT*FROM customer limit 5;

-- Total Penjualan dan Revenue pada Quarter-1 (Jan, Feb, Mar) dan Quarter-2 (Apr,Mei,Jun)

SELECT
     SUM(quantity) as total_penjualan,
     SUM(quantity*priceEach) as revenue 
FROM orders_1 
WHERE status="Shipped";
SELECT 
     SUM(quantity) as total_penjualan,
     SUM(quantity*priceEach) as revenue 
FROM orders_2 
WHERE status="Shipped";

-- Menghitung persentasi keseluruhan penjualan

SELECT  
    1 AS quarter, 
    SUM(quantity) as total_penjualan,
    SUM(quantity*priceEach) as revenue 
FROM orders_1 
WHERE status="Shipped" 
UNION 
SELECT  
    2 AS quarter, 
    SUM(quantity) as total_penjualan,
    SUM(quantity*priceEach) as revenue 
FROM orders_2 
WHERE status="Shipped";

-- Apakah jumlah customers xyz.com semakin bertambah?

SELECT 
    1 AS quarter, 
    COUNT(customerID) AS total_customers 
FROM customer 
WHERE createDate BETWEEN "2004-01-01" AND "2004-03-31" 
UNION 
SELECT 
    2 AS quarter, 
    COUNT(customerID) AS total_customers 
FROM customer 
WHERE createDate BETWEEN "2004-04-01" AND "2004-06-30";

-- Seberapa banyak customers tersebut yang sudah melakukan transaksi?

SELECT 
    1 AS quarter, 
    COUNT(DISTINCT customerID) AS total_customers 
FROM orders_1 
WHERE status =”Shipped” 
UNION 
SELECT 
    2 AS quarter, 
    COUNT(DISTINCT customerID) AS total_customers 
FROM orders_2 
WHERE customerID IN (SELECT customerID FROM customer WHERE createDate BETWEEN “2004–04–01” AND “2004–06–30”);

-- Category produk apa saja yang paling banyak di-order oleh customers di Quarter-2?

SELECT 
    (SELECT SUBSTR(productCode,1,3)) AS categoryid, 
    COUNT(distinct orderNumber) AS total_order,
    SUM(quantity) AS total_penjualan 
FROM orders_2 
WHERE status=’Shipped’ 
GROUP BY categoryid 
ORDER BY total_order DESC;

-- Seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertamanya?

SELECT 
    COUNT(DISTINCT customerID) AS total_customers 
FROM orders_1;
SELECT 
    1 AS quarter,
    (SELECT 
         COUNT(distinct customerID) 
     FROM orders_1 
     WHERE customerID IN (SELECT 
                               customerID 
                         FROM orders_2
                          )
     )*100/count(DISTINCT customerID) AS q2 
FROM orders_1  
GROUP BY quarter;