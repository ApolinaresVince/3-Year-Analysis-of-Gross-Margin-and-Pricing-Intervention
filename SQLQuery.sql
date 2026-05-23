With a as ( 

select 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from dbo.Orders_2023

Union all

select 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from dbo.Orders_2024

Union all

select 
OrderID,
CustomerID,
ProductID,
OrderDate,
Quantity,
Revenue,
COGS
from dbo.Orders_2025
) -- append all the data

-- Main dataset
select 
a.OrderID,
a.CustomerID,
b.Region,
b.CustomerJoinDate,
a.ProductID,
c.ProductName,
c.ProductCategory,
a.OrderDate,
DATEADD(week,DATEDIFF(week,0,a.OrderDate),0) as Week_Date, -- for sorting weekly 
c.Price,
c.Base_Cost,
a.Quantity,
a.Revenue,
CASE WHEN a.Revenue is null then c.Price*a.Quantity 
	else a.Revenue 
	end as clean_revenue, -- replaced null value through computation through item price and quantity sold
a.Revenue - a.COGS as profit,
a.COGS
from a 
left join dbo.customers b on
a.CustomerID = b.CustomerID	
left join dbo.products c on
a.ProductID = c.ProductID
where a.CustomerID is not null -- dropping non customer id

