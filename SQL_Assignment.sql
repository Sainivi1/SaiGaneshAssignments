## customers

select * from org.customers

INSERT INTO Customers (CustomerID, Name, Email, JoinDate) VALUES
(1, 'John Doe', 'johndoe@example.com', '2020-01-10'),
(2, 'Jane Smith', 'janesmith@example.com', '2020-01-15'),
(3, 'Steven Smith', 'ssmith@example.com', '2020-01-20'),
(4, 'david warner', 'dwarner@example.com', '2020-01-25'),
(5, 'mitchell johnson', 'mjohnson@example.com', '2020-01-30'),
(6, 'pat cummins', 'pcummins@example.com', '2020-02-05'),
(7, 'travis head', 'thead@example.com', '2020-02-10'),
(8, 'glenn maxwell', 'gmaxwell@example.com', '2020-02-15'),
(9, 'tim southee', 'tsouthee@example.com', '2020-02-20'),
(10, 'Alice Johnson', 'alicejohnson@example.com', '2020-03-05');

## products

select * from org.Products;

INSERT INTO Products (ProductID, Name, Category, Price) VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Smartphone', 'Electronics', 499.99),
(3, 'Torch', 'Electronics', 259.99),
(4, 'LED Bulb', 'Electronics', 199.99),
(5, 'Washing Machine', 'Home Appliances', 4999.99),
(6, 'Air Conditioner', 'Home Appliances', 899.99),
(7, 'Chimney', 'Home Appliances', 599.99),
(8, 'Microwaven', 'Home Appliances', 839.99),
(9, 'Clocks', 'Home Decor', 1399.99),
(10, 'Desk Lamp', 'Home Decor', 29.99);



## orders

select * from org.Orders

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, '2020-02-15', 999.99),
(2, 2, '2020-02-17', 499.99),
(3, 3, '2020-02-19', 259.99),
(4, 4, '2020-02-21', 199.99),
(5, 5, '2020-02-23', 4999.99),
(6, 6, '2020-02-26', 899.99),
(7, 7, '2020-03-01', 599.99),
(8, 8, '2020-03-09', 839.99),
(9, 9, '2020-03-15', 1399.99),
(10, 10, '2020-03-21', 29.99);

## order details

select * from org.OrderDetails

 truncate table org.OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity,
PricePerUnit) VALUES
(1, 1, 1, 1, 999.99),
(2, 2, 2, 1, 499.99),
(3, 3, 3, 1, 259.99),
(4, 4, 4, 1, 199.99),
(5, 5, 5, 1, 4999.99),
(6, 6, 6, 1, 899.99),
(7, 7, 7, 1, 599.99),
(8, 8, 8, 1, 839.99),
(9, 9, 9, 1, 1399.99),
(10, 10, 10, 2, 29.99);

#1.1
select Name from customers;

#1.2
select Name from products where category = 'Electronics';

#1.3
select count(OrderID) as OrderCount from org.Orders;

#1.4
select od.OrderDetailID, od.OrderID, od.ProductID, od.Quantity,
od.PricePerUnit from org.orderdetails od
join org.orders o on od.OrderID = o.OrderID order by o.orderdate desc limit 1;


#2.1
select p.Name as ProductName,c.Name as CustomerName,o.orderID from org.orders o
join org.OrderDetails od on od.OrderID = o.OrderID
join org.products p on od.productid = p.ProductID 
join org.customers c on c.CustomerID = o.CustomerID

#2.2
select OrderID from org.Orderdetails where Quantity > 1;

#2.3
select c.name, sum(o.TotalAmount) as SalesAmout from org.orders o
join org.customers c on c.CustomerID = o.CustomerID 
group by c.name 

#3.1
select p.category,sum(o.TotalAmount) from org.Orderdetails od
join org.orders o on o.OrderID = od.OrderID
join org.products p on p.productID = od.ProductID
group by p.category

#3.2
select avg(TotalAmount) as AvgOrderValue from org.Orders;

#3.3
select month(OrderDate) as order_month,count(*) as order_count from org.Orders 
group by order_month
order by order_count desc
limit 1;

#4.1
select c.name from org.customers c
left join org.Orders o on c.CustomerID = o.CustomerID
where o.customerID IS NULL

#4.2
select p.name from org.OrderDetails od
left join org.products p on p.ProductID = od.ProductID
where od.ProductID IS NULL

#4.3
select p.name, sum(od.Quantity) as BestSellingProducts from Org.OrderDetails od
join org.products p on p.ProductID = od.ProductID
group by p.name
order by BestSellingProducts desc
limit 3;

#5.1
select * from Orders where year(orderdate) = year(current_date() - interval 1 month)
and month(orderdate) = month(current_date() - interval 1 month)

#5.2
select * from org.customers order by JoinDate asc limit 1;

#6.1
SELECT
  name,
  TotalAmount,
  RANK() OVER (ORDER BY TotalAmount DESC) AS customer_rank
FROM (
  SELECT
    c.name,
    SUM(o.TotalAmount) AS total_spending
  FROM org.customers c
  JOIN org.orders o ON c.customerid = o.customerid
  GROUP BY c.customerid	
) AS customer_spending
ORDER BY customer_rank;

#6.2
select p.category,sum(o.TotalAmount) as Amount from org.Orderdetails od
join org.orders o on o.OrderID = od.OrderID
join org.products p on p.productID = od.ProductID
group by p.category
Order by Amount desc
limit 1

#6.3


#7.1
INSERT INTO Customers (CustomerID, Name, Email, JoinDate) VALUES
(11, 'Mitchell Starc', 'mstarc@example.com', '2024-01-12');

#7.2
Update org.products set price='10950.40' where productid=2

