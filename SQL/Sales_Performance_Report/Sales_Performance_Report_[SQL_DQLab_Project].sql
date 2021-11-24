-- Overall Performance by Year
-- Buatlah Query dengan menggunakan SQL untuk mendapatkan total penjualan (sales) dan jumlah order (number_of_order) dari tahun 2009 sampai 2012 (years). 

SELECT 
	YEAR(order_date) as years,
	SUM(sales) as sales,
	COUNT(order_id) as number_of_order 
FROM dqlab_sales_store 
WHERE order_status= 'Order Finished' 
GROUP BY years;

-- Overall Performance by Product Sub Category
-- Buatlah Query dengan menggunakan SQL untuk mendapatkan total penjualan (sales) berdasarkan sub category dari produk (product_sub_category) pada tahun 2011 dan 2012 saja (years) 

SELECT 
	YEAR(order_date) as years,
	product_sub_category,
	SUM(sales) as sales 
FROM dqlab_sales_store
WHERE order_status= 'Order Finished'
 and 
order_date between '2011-01-01' and '2012-12-31' 
GROUP BY years,product_sub_category 
ORDER BY years, sales DESC;

-- Promotion Effectiveness and Efficiency by Years

SELECT 
	YEAR(order_date) as years,
	SUM(sales) as sales,
	SUM(discount_value) as promotion_value,
	ROUND(SUM(discount_value)*100/SUM(sales),2) as burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished' 
GROUP BY years
ORDER BY years;

-- Promotion Effectiveness and Efficiency by Product Sub Category

SELECT 
	YEAR(order_date) as years,
	product_sub_category as product_sub_category,
	product_category as product_category,
	SUM(sales) as sales,
	SUM(discount_value) as promotion_value,
	ROUND(SUM(discount_value)*100/SUM(sales),2) as burn_rate_percentage
FROM dqlab_sales_store
where order_status = 'Order Finished' 
and YEAR(order_date)='2012'
GROUP BY years, product_sub_category,product_category
order by sales DESC;

-- Customers Transactions per Year

SELECT 
	YEAR(order_date) AS years,
	COUNT(DISTINCT customer) AS number_of_customer
FROM dqlab_sales_store
WHERE order_status = ‘Order Finished’
GROUP BY years

