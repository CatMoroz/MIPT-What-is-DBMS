--1
select LastName, FirstName 
from customers 
where City = 'Prague';


--2
select LastName, FirstName
from customers 
where FirstName like "M%";

select LastName, FirstName 
from customers 
where FirstName like "%ch%";


--3
select Name, Bytes/(1024*1024) as MBytes
from tracks;


--4
select LastName, FirstName 
from employees 
where City = 'Calgary' and HireDate like "2002%" ;


--5
select LastName, FirstName 
from employees 
where (HireDate - BirthDate) >= 40;


--6 
select LastName, FirstName 
from customers 
where Country = 'USA' and Fax is NULL;


--7
select ShipCity 
from sales
where ShipCountry = 'Canada' and (strftime("%m", SalesDate) == "08" or strftime("%m", SalesDate) == "09");


--8
select Email
from customers
where Email like "%gmail.com";


--9
select LastName, FirstName 
from employees 
where (CURRENT_DATE- BirthDate) >= 18;


--10
select Title
from employees 
ORDER BY Title;


--11
select LastName
from customers
ORDER BY LastName;

select FirstName
from customers
ORDER BY FirstName;

select (CURRENT_DATE- Age) as BirthDate
from customers
ORDER BY BirthDate;


--12
select (Milliseconds/1000) as Seconds
from tracks
WHERE Milliseconds =  ( SELECT MIN(Milliseconds) FROM tracks );


--13
select Name, (Milliseconds/1000) as Seconds
from tracks
WHERE Milliseconds =  ( SELECT MIN(Milliseconds) FROM tracks );


--14
select Country, AVG(Age) as Avg_Age
from customers
group by Country;


--15
select LastName
from employees 
where strftime("%m", HireDate) == "10";


--16
select LastName
from employees
ORDER BY HireDate LIMIT 1;
