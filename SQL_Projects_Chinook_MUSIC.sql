use chinook;
select * from album;
select * from invoice;
-- 1.Calculate Monthly-Wise invoice Sales and sort them in descending order.
select monthname(invoicedate) as Month,sum(Total) as Total_sales from invoice group by 1 order by 2 desc;


-- 2.Write an SQL query to fetch the names of all employees and their managers.
select concat(e.firstname," ",e.lastname) as Employee_Name ,concat(s.firstname," ",s.lastname) as Manager_Name from employee e 
join employee s on s.reportsto = e.employeeid group by 1,2;

select * from employee; 


-- 3.Find the names of customers who have made a purchase in the USA?
select * from invoice;
select * from customer;
select concat(c.firstname," ",c.lastname) as Names from customer c left join invoice i on c.customerid = i.customerid where i.Billingcountry in ("USA") group by 1;
select distinct firstname from customer where country="USA";
select distinct concat(a.firstname," ",a.lastname) as Names from customer a left join invoice b on a.customerid = b.customerid where a.country in ("USA");

 -- 4.Show the name of each genre and the total number of tracks in that genre
 select * from genre;
 select * from track;
 select g.name as Genre_name,count(t.name) Genre_Count from genre g join track t on g.genreid = t.genreid group by 1 order by 2 desc;
 
-- 5.Show the name of each customer and the total amount they have spent on purchases
select * from invoice;
select * from customer;
select concat(c.firstname," ",c.lastname) as Customer_Name ,sum(i.Total) as Total  from customer c join invoice i on c.customerid = i.customerid group by 1 order by 2 desc;

-- 6.Find the name of the album with the highest unit price
select * from invoiceline;
select * from track;
select * from album;
select a.Title, sum(b.unitprice) from album a inner join track b on b.albumid = a.albumid group by 1 order by 2 desc limit 1;

-- 7.Display the percentage of missing values for “billingstate” and “billingpostalcode” columnsrespectively for the invoice table.
select ((count(*)-count(Billingstate))/count(*))*100 as Billingstate_Null,((count(*)-count(Billingpostalcode))/count(*))*100 as BillingPostalcode from invoice;

-- 8.Show the name of each track and the total number of times it has been purchased.
select * from track;
select * from invoice;
select * from invoiceline;
select * from customer;
select t.Name,count(t.trackid) from track t inner join invoiceline i on t.trackid = i.trackid  group by 1 order by 2 desc;
select a.name,count(b.quantity) from track a inner join invoiceline b on a.trackid = b.trackid group by 1 order by 2 desc;

-- 9.Find the name of the customer who has made the largest purchase in terms of total cost.
select concat(c.firstname," ",c.lastname) as Name,sum(i.total) as Largest_Purchase from customer c 
inner join invoice i on c.customerid = i.customerid group by 1 order by 2 desc limit 1;

-- 10.Display the total amount spent by each customer and the number of invoices they have.
SELECT 
    CONCAT(firstname, ' ', lastname) AS Customer,
    SUM(i.total) AS Total_Purchase,
    COUNT(i.invoiceid) AS Count_of_Invoice
FROM
    customer c
        JOIN
    invoice i ON c.customerid = i.customerid
GROUP BY 1
ORDER BY 3 DESC;

select * from invoice;
-- 11.Find the name of the artist who has the most tracks in the chinook database.
select * from track;
select * from artist;
select * from album;

select a.name as Artist_name, count(c.trackid) as Count_of_Tracks from artist a join album b on b.artistid = a.artistid 
inner join track c on c.albumid = b.albumid group by 1 order by 2 desc;

-- 12.Find the names and email addresses of customers who have spent more than the average amounton invoices
select c.firstname,c.email,avg(i.total) as Total from customer c join invoice i on c.customerid = i.customerid join invoice o on c.customerid = o.customerid;
select avg(total) from invoice;
select * from customer;
select * from invoice;
select distinct concat(a.firstname," ",a.lastname),a.email from customer a join invoice b on b.customerid = a.customerid 
where total>(select avg(total) from invoice); 

-- 13.List the names of all the artists that have tracks in the 'Rock' genre.
select * from genre;
select * from artist;
select * from track;
select * from album;
select a.name as Name from artist a join album b on b.artistid = a.artistid 
inner join track c on c.albumid = b.albumid where c.genreid = 1 group by 1;
