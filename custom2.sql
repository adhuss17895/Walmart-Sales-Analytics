use walmart1;

-- -----------FEATURE ENGINEERNING---------------

-- --------------TIME_OF_DAY-----------
select 
	Timeof,
	(CASE	
			WHEN salesdata.Timeof BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN salesdata.Timeof BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END) AS time_of_day
from salesdata;

alter table salesdata add time_of_day VARCHAR(20);

UPDATE salesdata
SET time_of_day = (
	CASE
		WHEN salesdata.Timeof BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN salesdata.Timeof BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);

-- -------DAY_NAME-------
SELECT Dateof,DATENAME(WEEKDAY, Dateof) FROM salesdata;

alter table salesdata add day_name VARCHAR(10);

update salesdata
set day_name = DATENAME(WEEKDAY, Dateof);
-- -------------MONTH_NAME----------------

SELECT Dateof, DATENAME(MONTH, Dateof) FROM salesdata;

ALTER TABLE salesdata ADD month_name VARCHAR(20);

UPDATE salesdata
SET month_name = DATENAME(MONTH, Dateof);
-- -------------------------------- END --------------------------

-- ------------Generic---------------------------------------------

select * from salesdata;

-- How many unique cities are present?-----------------------------
select distinct City from salesdata;

-- In which city is each branch? --------------------------------
select distinct City,Branch from salesdata;

-- --------------Product----------------------------------------
select * from salesdata;
-- How many unique product lines does the data have?-----------
select count(distinct Product_line) from salesdata;

-- -------Most common payment method---------------------------
select Payment,COUNT(Payment) as Payment_count from salesdata
group by Payment;

-- ------------Most selling product line --------------
select Product_line,COUNT(Product_line) as count_pl from salesdata
group by Product_line
order by count_pl DESC;

-- --------------Total revenue by month ------------------------

select month_name as MONTH,
	SUM(Total) as Total_Revenue
	from salesdata
	group by month_name
	order by Total_Revenue DESC;

-- ------------------Which month had largest COGS ----------------

select month_name as MONTH,
	sum(cogs) as COGS
	from salesdata
	group by month_name
	order by COGS DESC;

-- ---------- Product line with largest revenue -----------------
select Product_line,
	sum(Total) as Total_Revenue
	from salesdata
	group by Product_line
	order by Total_Revenue DESC;

-- ------------- City with the largest revenue ------------------
select City,
	sum(Total) as Total_Revenue
	from salesdata
	group by City
	order by Total_Revenue DESC;

-- ------------- Product line with largest VAT ----------------
select Product_line,
	avg(Tax_5) as Total_Tax
	from salesdata
	group by Product_line
	order by Total_Tax DESC;

-- ------------- Good, Bad - Good if greater than average sales ---------
select Product_line
	avg(Total) as Average_Sales
	from salesdata

-- ----------- Which branch sold more products than average product sold -------
select Branch,
	sum(Quantity) as Sum_Quantity
from salesdata
group by Branch
having SUM(Quantity) > (select AVG(Quantity)from salesdata)
order by Sum_Quantity DESC;

-- ------------- Most common product line  by gender ----------------
select Gender,
	Product_line,
	COUNT(Gender) as total_cnt
from salesdata
group by Gender, Product_line
order by total_cnt DESC;

-- -------------Avg rating of each prodcut line ------------
select Product_line,
	avg(Rating) as Avg_Rating
from salesdata
group by Product_line
order by Avg_Rating DESC;

select * from salesdata;