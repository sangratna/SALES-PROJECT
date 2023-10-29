select * from sales_database.sales_data_sample;
select distinct YEAR_ID from sales_database.sales_data_sample;
select distinct PRODUCTLINE from sales_database.sales_data_sample;
select distinct DEALSIZE from sales_database.sales_data_sample;
select distinct TERRITORY from sales_database.sales_data_sample;

select sum(SALES),PRODUCTLINE 
from sales_database.sales_data_sample
group by PRODUCTLINE
order by PRODUCTLINE desc;

select distinct MONTH_ID from sales_database.sales_data_sample
where YEAR_ID=2005;

select YEAR_ID, sum(SALES)
from sales_database.sales_data_sample
group by YEAR_ID
order by sum(SALES);


select MONTH_ID, sum(SALES) Revenue, count(ORDERNUMBER) Frequency
from sales_database.sales_data_sample
group by MONTH_ID
order by Revenue desc;

select MONTH_ID, PRODUCTLINE,sum(SALES) AS Revenue, count(ORDERNUMBER)AS Frequency
from sales_database.sales_data_sample
where YEAR_ID = 2003
group by MONTH_ID, PRODUCTLINE
order by Revenue desc;

-- Who is best customer
SELECT 
    CUSTOMERNAME,
    SUM(SALES) AS Total_sale,
    AVG(SALES) AS Average_sale,
    COUNT(ORDERNUMBER) AS Frequency,
    MAX(STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i')) AS Latest_order_date,
    MIN(STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i')) AS Last_order_date,
    DATEDIFF(
        MAX(STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i')), 
        MIN(STR_TO_DATE(ORDERDATE, '%m/%d/%Y %H:%i'))
    ) AS Resency
FROM 
    sales_database.sales_data_sample
GROUP BY 
    CUSTOMERNAME;

-- What product are most often sold together
SELECT 
    p1.PRODUCTCODE AS Product_1, p1.PRODUCTLINE,
    p2.PRODUCTCODE AS Product_2, p2.PRODUCTLINE,
    COUNT(*) AS Frequency 
FROM 
    sales_database.sales_data_sample p1
JOIN 
    sales_database.sales_data_sample p2
ON 
    p1.ORDERNUMBER = p2.ORDERNUMBER 
    AND p1.PRODUCTCODE < p2.PRODUCTCODE
WHERE 
    p1.STATUS = 'Shipped' AND p2.STATUS = 'Shipped'
GROUP BY 
    p1.PRODUCTCODE, p1.PRODUCTLINE, p2.PRODUCTCODE, p2.PRODUCTLINE
ORDER BY 
    Frequency DESC
LIMIT 10;



