--1 
SELECT SUM(si.UnitPrice * si.Quantity) AS TotalSales
FROM sales_items si
JOIN sales s ON si.SalesId = s.SalesId
WHERE s.ShipCountry = 'USA'
AND strftime('%Y', s.SalesDate) = '2012'
AND strftime('%m', s.SalesDate) BETWEEN '01' AND '03';

SELECT SUM(UnitPrice * Quantity) AS TotalSales
FROM sales_items
WHERE SalesId IN (
    SELECT SalesId
    FROM sales
    WHERE ShipCountry = 'USA'
    AND strftime('%Y', SalesDate) = '2012'
    AND strftime('%m', SalesDate) BETWEEN '01' AND '03'
);


--2 
SELECT c.FirstName
FROM customers c
LEFT JOIN employees e ON c.FirstName = e.FirstName
WHERE e.FirstName IS NULL
GROUP BY c.FirstName;

SELECT FirstName
FROM customers
WHERE (customers.FirstName not in (
    select employees.FirstName
    from employees))
GROUP BY customers.FirstName;

SELECT FirstName
FROM customers
GROUP BY FirstName
EXCEPT 
SELECT FirstName FROM employees;


--3
--НЕТ, данные запросы вернут разный результат. Разница между этими двумя запросами заключается в месте применения условия t1.column1=0.
--В первом запросе условие WHERE t1.column1=0 применится после LEFT JOIN, то есть из результата соединения будут выбраны только те строки, где t1.column1 равен 0. 
--Это уменьшит количество строк в результате, так как строки, где t1.column1 не равен 0, будут исключены из конечного результата.

--Во втором запросе условие t1.column1=0 применяется именно в ON у LEFT JOIN, то есть соединение будет выполнено только для тех строк из t1, где column1 равен 0.
--В этом случае все строки из t1, где column1 равен 0, будут включены в результат, даже если соответствующих строк в t2 не найдено.


--Вывод: второй запрос вернет больше строк.


--4
SELECT albums.Title as 'Название альбома', COUNT(tracks.TrackId) as 'Количество треков'
FROM albums
JOIN tracks ON albums.AlbumId = tracks.AlbumId
GROUP BY albums.AlbumId
ORDER BY COUNT(tracks.TrackId) DESC;

SELECT albums.Title as 'Название альбома', 
(SELECT COUNT(tracks.TrackId) 
FROM tracks 
WHERE tracks.AlbumId = albums.AlbumId) as 'Количество треков'
FROM albums
ORDER BY 'Количество треков' DESC;


--5
SELECT customers.LastName as 'Фамилия', customers.FirstName as 'Имя'
FROM customers
JOIN sales ON customers.CustomerId = sales.CustomerId
WHERE sales.ShipCity = 'Berlin' 
AND strftime('%Y', SalesDate) == '2009' 
AND customers.Country = 'Germany'


--6
SELECT LastName 
FROM customers 
INNER JOIN sales 
INNER JOIN sales_items ON customers.CustomerId = sales.CustomerId AND sales.SalesId = sales_items.SalesId 
GROUP BY LastName 
HAVING SUM(sales_items.Quantity) > 30;

SELECT (
    SELECT 
        (SELECT LastName 
        FROM customers 
        WHERE customers.CustomerId = sales.CustomerId)
            FROM sales 
            WHERE sales.SalesId = sales_items.SalesId
        ) as LastName 
    FROM sales_items 
    GROUP BY LastName 
    HAVING SUM(Quantity) > 30;


--7 
SELECT g.Name as 'Жанр', AVG(t.UnitPrice) as 'Средняя цена трека'
FROM genres g
JOIN tracks t ON g.GenreId = t.GenreId
GROUP BY g.GenreId, g.Name;


--8
SELECT g.Name as 'Жанр', AVG(t.UnitPrice) as 'Средняя цена трека'
FROM genres g
JOIN tracks t ON g.GenreId = t.GenreId
GROUP BY g.Name
HAVING AVG(t.UnitPrice) > 1;
