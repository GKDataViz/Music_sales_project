                  -- Music_Sales_Project-----
-- Query_1
-- Who is the senior most employee based on job title?
use music_database;
select employee_id,concat(first_name," ",last_name) as name from employee
order by levels desc
limit 1;

-- Query_2
-- Which countries have the most invoices?
select billing_country, count(total) as country_count from invoice
group by billing_country
order by country_count desc
limit 1;

-- Query_3
-- What are top 3 values of total invoice?
select invoice_id, total as top_3_values from invoice
order by top_3_values desc
limit 3;

-- Query_4
-- Which city has the best customers? We would like to thow a promotional music festival
-- in the city we made the money. Write a queary that returns one city that has the highest sum of invoice totals.
-- Return both the city name & sum of all invoice totals.
select billing_city, sum(total) total_amount from invoice
group by billing_city
order by total_amount desc
limit 1;

-- Query_5
-- Who is the best customer? The customer who has spent the most money will be declared the best customer.
-- Write a queary that returs the person who has spent the most money.
select concat(c.first_name," ",last_name) as the_best_customer, sum(i.total) as total_amount from invoice i
join customer c
on c.customer_id = i.customer_id
group by the_best_customer
order by total_amount desc
limit 1;

-- Query_6
-- Write query to return email, first name, last name, & Genre of all rock music listeners.
-- Return your list ordered alphabetically by email starting with A.
SELECT c.email, c.first_name, c.last_name, genre.name from customer c
join invoice on c.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
-- here we can also simply use it like--(where genre.name = "Rock")
where  genre.genre_id = (select genre_id from genre where name = "Rock")
order by email;

-- Query_7
-- Let's invite the artists who have written the most rock music in our dataset write a query
-- that returns the artist name and total track count of the top 10 rock bands.
select a.artist_id, a.name,count(a.artist_id) from genre g
join track on track.genre_id = g.genre_id
join album on album.album_id = track.album_id
join artist a on a.artist_id = album.artist_id
where g.name like "Rock"
group by a.artist_id, a.name
order by count(a.artist_id) desc
limit 1;

-- Query_8
-- Return all the track names that have song length longer than the average song length.
-- Return the name and milliseconds for each track order by the sound length with the longest songs list first.
select name, milliseconds from track
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;