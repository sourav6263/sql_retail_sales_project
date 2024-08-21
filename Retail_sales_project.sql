select top 10 * from Retail_Sales 
order by transactions_id

--To get the countn of data
select count(*) from Retail_Sales


--Data Cleaning
select * from Retail_Sales
where transactions_id is null
	 or sale_date is null
	 or sale_time is null
	 or customer_id is null
	 or gender is null
	 or category is null
	 or quantiy is  null
	 or quantiy is null
	 or price_per_unit is null
	 or cogs is null
	 or total_sale is null;

delete from Retail_Sales
where transactions_id is null
	 or sale_date is null
	 or sale_time is null
	 or customer_id is null
	 or gender is null
	 or category is null
	 or quantiy is  null
	 or quantiy is null
	 or price_per_unit is null
	 or cogs is null
	 or total_sale is null;

--Data Exploration

--How many sales we have?
select count(*) as Total_Sales from Retail_Sales

--How many customers we have?
select count(distinct transactions_id) as total_customer from Retail_Sales

--Data Analysis & Business Key Problems & Answers

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
select * 
	from Retail_Sales 
	where sale_date = '2022-11-05';

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is
--more than 4 in the month of Nov-2022.

select *
	from Retail_Sales
	where 
    category = 'Clothing'
    and 
    convert(varchar(7),sale_date, 120) = '2022-11'
    and
    quantiy >= 4;

--3.Write a SQL query to calculate the total sales (total_sale) for each category.
select 
		category, 
	   sum(total_sale) as net_sales
from Retail_Sales
group by category

--4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
		round(avg(age),2) as avg_age
from Retail_Sales
where category = 'Beauty'

--5.Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * 
	from retail_sales
	where total_sale > 1000

--6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select	
		gender,
		category,
		count(*) as total_trans
from Retail_Sales
	group by category,
				gender
	order by gender

--7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

select 
		year,
		month,
		avg_sale
from
(
select
			year(sale_date) as year,
			month(sale_date) as month,
			avg(total_sale) as avg_sale,
			rank () over (partition by year(sale_date) order by avg(total_sale)desc) as rank
from retail_sales
group by 
		year(sale_date) ,
		month(sale_date) 
) as t1
where rank = 1

--8.Write a SQL query to find the top 5 customers based on the highest total sales 
select top 5
		customer_id,
		sum(total_sale) as highest_sales
from Retail_Sales
group by customer_id
order by sum(total_sale) desc


--9.Write a SQL query to find the number of unique customers who purchased items from each category.
select 
		category,
		count(distinct customer_id) as unique_customers
from Retail_Sales
group by 
		category

--10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
with hourly_sale
as
(
select *,
		case
			when datepart(hour, sale_time) <=12 then 'Morning'
			when datepart(hour, sale_time) between 12 and 17 then 'Afternoon'
			else 'Evening'
		end as shift
from Retail_Sales
)
select 
		shift,
		count(*) as total_orders
from hourly_sale
group by shift



select * from Retail_Sales