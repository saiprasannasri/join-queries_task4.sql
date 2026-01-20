
-- Task 4: SQL Joins – Chinook Database Example
-- Database: Chinook (PostgreSQL/MySQL compatible)

-- 1. INNER JOIN: Orders (Invoices) with Customers
SELECT 
    i.InvoiceId,
    i.InvoiceDate,
    c.CustomerId,
    c.FirstName || ' ' || c.LastName AS customer_name,
    c.Country,
    i.Total
FROM Invoice i
INNER JOIN Customer c
    ON i.CustomerId = c.CustomerId;

-- 2. LEFT JOIN: Customers who never placed any orders
SELECT 
    c.CustomerId,
    c.FirstName,
    c.LastName,
    c.Country
FROM Customer c
LEFT JOIN Invoice i
    ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL;

-- 3. Revenue per Product
SELECT 
    t.TrackId,
    t.Name AS product_name,
    SUM(il.UnitPrice * il.Quantity) AS total_revenue
FROM InvoiceLine il
INNER JOIN Track t
    ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY total_revenue DESC;

-- 4. Category-wise (Genre) Revenue
SELECT 
    g.GenreId,
    g.Name AS category_name,
    SUM(il.UnitPrice * il.Quantity) AS category_revenue
FROM InvoiceLine il
INNER JOIN Track t
    ON il.TrackId = t.TrackId
INNER JOIN Genre g
    ON t.GenreId = g.GenreId
GROUP BY g.GenreId, g.Name
ORDER BY category_revenue DESC;

-- 5. Business Question:
-- Sales in USA between 2013-01-01 and 2013-12-31
SELECT 
    c.Country,
    COUNT(i.InvoiceId) AS total_orders,
    SUM(i.Total) AS total_sales
FROM Invoice i
INNER JOIN Customer c
    ON i.CustomerId = c.CustomerId
WHERE c.Country = 'USA'
  AND i.InvoiceDate BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY c.Country;
