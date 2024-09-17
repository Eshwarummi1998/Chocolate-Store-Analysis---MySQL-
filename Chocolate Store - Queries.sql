use awesome_chocloates;

-- 1) See all Shipments

SELECT 
    *
FROM
    shipments;
    
-- 2)	All Shipments by SP02
select * from Shipments
where sales_person = "Sp02";

-- 3)	All Shipments by SP02 to G3
select * from Shipments 
where sales_person = "Sp02" and Geo = "G3"
order by amount Desc;

-- 4) All Shipments in Jan 2023

Select * from shipments
where date between "2023-1-1" and "2023-01-31"
order by date asc;

select * from shipments
where extract(year_month from date) = 202301;



-- 5)	All Shipments by SP02, SP03, SP12, SP15

Select * from shipments
where sales_person in ("sp02", "sp03", "sp12", "sp15")
order by sales_person asc;




-- 6)	Products that have word Choco in them

select *
from Products
where product like "%Choco%";



-- 7)	Sales Person whose name begins with S

select *
from people
where sales_person like "s%";




-- 8)	Sales per box of Chocolates in Feb 2023

select S.*,p.* ,ceil(round((s.Amount/s.Boxes),2)) as Box_Price
from shipments S join products p
on s.Product = p.product_ID
where extract(year_month from date) = 202302
order by Box_price desc;



-- 9)	All shipment data for subbarao

select p.sales_person, p.location, s.*
from people p join shipments s 
on p.sp_id = s.sales_person
where p.sales_person like "Subba%";




-- 10)	All shipment data for subbarao by month

select extract(year_month from s.order_Date) as date, sum(s.amount), sum(s.Boxes)
from people p join shipments s 
on p.sp_id = s.sales_person
where p.sales_person like "Subb%"
group by extract(year_month from s.order_Date)
order by Date Asc;




-- 11)	All shipment data for Subbarao to USA
select p.sales_person, s.product, sum(s.amount) as Total_Amount, sum(s.Boxes) as Total_Boxes
from people p 
join shipments s on p.sp_id = s.sales_person
join geo g on s.geo = g.geoId
where g.geo = "USA"
group by s.product, p.sales_person
order by p.sales_person asc, s.product asc;




-- 12)	What is the Total amount in each month

select extract(year_month from order_date) as month, sum(amount) as Sum_amount
from shipments
group by extract(year_month from order_date);



-- 13)	How many shipments we do by each country in the month of March 2023

select geo, count(order_date), sum(count(order_date)) over() as total_count
from shipments 
where order_date between "2023-03-01" and "2023-03-31"
group by Geo;

