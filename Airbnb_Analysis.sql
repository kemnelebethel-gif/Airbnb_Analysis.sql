use Airbnbcasestudy
select * from Airbnb_Listing
select * from Airbnb_Pricing
select * from Reviews

--MASTERING JOIN IN SQL
--Exam 1:(inner join)
--which room type has the highest number of reviews?
select room_type,count (distinct review.id) as total_reviews
from Airbnb_Listing as listing
inner join Reviews AS review
on listing.id = review.listing_id
group by room_type
ORDER BY total_reviews desc


select listing.id,review.listing_id,listing.name,review.comment,
listing.room_type
from Airbnb_Listing AS listing
inner join Reviews AS review
on listing.id=review.listing_id

--2 display the listing name together with the reviewer name
select l.name,r.reviwer_name
from Airbnb_Listing as l
inner join Reviews as r
on l.id = r.listing_id



--bonus show each reviewer's name and the listing name they reviwed
select r.reviwer_name,l.name
from Reviews as r
inner join Airbnb_Listing AS l
on l.id= r.listing_id

--exm 3 show avg price per room_type, join pricing table and listing table
select room_type, avg(p.price ) as price_room_type
from Airbnb_Pricing AS p
inner join Airbnb_Listing as l 
on l.id = p.listing_id
group by room_type

--clw 1 show listing name,neighbourhood and review comments
select name,neighbourhood,comment
from Airbnb_Listing as listing
inner join Reviews as reviews
on listing.id =reviews.listing_id

--cl 2 display listing and daily price
select name,p.price
from Airbnb_Listing as l
inner join Airbnb_Pricing as p
on l.id = p.listing_id

select * from Airbnb_Listing
select * from Airbnb_Pricing
select * from Reviews

--something i worked on
select name,p.price
from Airbnb_Listing as l
inner join Airbnb_Pricing As p
on l.id=p.listing_id

select name,HOST_NAME,p.price,reviwer_name,comment
from Airbnb_Listing AS l
inner join Airbnb_pricing as p
on l.id=p.listing_id
inner join Reviews as r
on l.id = r.listing_id

--LEFT JOIN
--Exam 1 find listing that have null comment
select name,comment
from Airbnb_Listing as l
left join Reviews as r
on l.id = r.listing_id
WHERE r.comment IS NULL;


--exam 2: Display every listing together with minimum nights


--cls 1:show all listings and the date of their most recent 
-- review - include listing with no reviews
SELECT name,MAX(r.date) AS most_recent_review
FROM Airbnb_Listing as l
LEFT JOIN Reviews as r
ON l.id = r.listing_id
GROUP BY name
order by most_recent_review desc;

-- RIGHT JOIN
-- Exam 1 find listing that have null comment
select name,comment
from Airbnb_Listing as l
right join Reviews as r
on l.id = r.listing_id

-- show listing name and comment using right join
select name,comment
from Airbnb_Listing as l
right join Reviews as r
on l.id = r.listing_id

-- Exam 2: display every pricing records,together with the listing name
select name,p.*
from Airbnb_Pricing as p
right join Airbnb_Listing as l
on p.listing_id = l.id

/* FULL OUTER JOIN
exam 1: show all listings and all reviews*/
select name,r.comment
from Airbnb_Listing as l
full outer join Reviews as r
on l.id = r.listing_id

--clw 1: display evry listing and evry price
select l.*,p.*
from Airbnb_Listing as l join
 Airbnb_Pricing as p
on l.id = p.listing_id

/* SUB QUERY:A query inside a query
exam 1: find listings whose price is above the overall avg price
STEP 1: WHat is the avg price? (sub query) */
select avg(price) as avg_price from Airbnb_Listing

-- step 2: what is our query
select name,neighbourhood,price
from Airbnb_Listing
where Price > (select avg(price) as avg_price from Airbnb_Listing)

-- EXAM 2: FIND listing that appear in the pricing table
select id,name,neighbourhood
from Airbnb_Listing
where id in (select distinct listing_id from Airbnb_Pricing)

--Cls w1: find the cheapest listing using join
select name,min(p.price) as pricing_table_price
from Airbnb_Listing as l
inner join Airbnb_Pricing AS p
on l.id = p.listing_id
group by name
order by pricing_table_price

-- with sub qu
select name,p.price
from Airbnb_Listing as l
inner join Airbnb_Pricing as p
on l.id = p.listing_id
where p.price = (select min(price) from Airbnb_Pricing)

/*write a single query that: joins airbnb_listings to airbnb_reviews and only includes listings 
that have at least one review;
couns the total number of reviews per listings;
labels each listing as'popular' if has more than 10 reviews and 'needs more reviews otherwise;
shows each host's name in upercase;
and only includes listings whose price is not null.
order the results by total reviews, highest first.*/

SELECT UPPER(l.host_name) AS host_name_upper,
     l.name,
      COUNT(r.id) AS total_reviews,
     CASE
       WHEN COUNT(r.id) > 10 then 'popular'
       ELSE 'need more reviews'
       end as popularity_status
       FROM Airbnb_listing l
       INNER JOIN Reviews r
       ON l.id = r.listing_id
       WHERE L. price is NOT NULL
       GROUP BY l.host_name, l.name
       ORDER BY total_reviews DESC;

/* write a query that finds all listings that:
are located in a neighbourhood containing the word  'park'
are priced above the overall avg price of all listings
and were last reviewed within the last 2 years from today*/


 SELECT *
FROM Airbnb_Listing
WHERE neighbourhood LIKE '%park%'
AND price > (SELECT AVG(price)FROM Airbnb_Listing)
AND last_review >= DATEADD(YEAR, -2, GETDATE());