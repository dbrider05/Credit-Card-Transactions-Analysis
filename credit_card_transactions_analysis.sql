--1- write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 


with cte1 as 
(select sum(cast(amount as bigint)) as total_spent 
from credit_card_transcations)
select top 5 city,sum(amount) as expense, total_spent,(sum(amount)*1.0/total_spent)*100 as percentage_cont
from credit_card_transcations 
inner join cte1   on 1=1
group by city,total_spent
order by expense desc

--2- write a query to print highest spend month and amount spent in that month for each card type
--month  card type ampount
select * from credit_card_transcations

with cte as (
select card_type,datepart(year,transaction_date) as yo,DATEPART(month,transaction_date) as mo,sum(amount) as m_expense
from credit_card_transcations
group by card_type,datepart(year,transaction_date),DATEPART(month,transaction_date))
select * from(
select *, rank() over(partition by card_type order by m_expense desc) as rn 
from cte)a
where rn=1

--3- write a query to print the transaction details(all columns from the table) for each card type when
--it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)

with cte1 as (
select *, sum(amount) over (partition by card_type order by transaction_date, transaction_id) as cum_sum from credit_card_transcations
)
select * from (select *,rank() over (partition by card_type order by cum_sum) as rn from cte1 where cum_sum >=1000000) a
where rn=1


--4- write a query to find city which had lowest percentage spend for gold card type

city goldspend total_spend

select top 1 city,sum(amount) as total_spend,
sum(case when card_type='gold' then amount else 0 end ) as gold_spend,
(sum(case when card_type='gold' then amount else 0 end )*1.0/sum(amount))*100 as gold_percentage
from credit_card_transcations
group by city
having sum(case when card_type='gold' then amount else 0 end )>0
order by gold_percentage

--5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)

select * from credit_card_transcations
select exp_type from credit_card_transcations group by exp_type

with high_expense as(
select city,exp_type,sum(amount) as spend,
rank() over (partition by city order by sum(amount) desc) as h_rn  
from credit_card_transcations
group by city,exp_type),
low_expense as (
select city,exp_type,sum(amount) as spend,
rank() over (partition by city order by sum(amount) ) as l_rn  
from credit_card_transcations
group by city,exp_type
)select h.city,h.exp_type,l.exp_type
from high_expense h
inner join low_expense l on h.city=l.city
where h_rn=1 and l_rn=1

--6- write a query to find percentage contribution of spends by females for each expense type

select exp_type,sum(amount) as total_spend
,sum( case when gender='f' then amount else 0 end) as female_spend,
(sum( case when gender='f' then amount else 0 end)*1.0/sum(amount))*100 as female_spend_percentagee
from credit_card_transcations
group by exp_type
order by female_spend_percentagee

---- 7- which card and expense type combination saw highest month over month growth in Jan-2014 7757562  7530968
select * from credit_card_transcations
with cte1 as(
select card_type,exp_type ,datepart(year,transaction_date) as yo,datepart(month,transaction_date) as mo,sum(amount) as current_sum
from credit_card_transcations
group by card_type,exp_type,datepart(year,transaction_date),datepart(month,transaction_date)),
cte2 as(
select *,lag(current_sum) over (partition by card_type,exp_type order by yo,mo ) as previous_sum
from cte1
)select*, current_sum-previous_sum as mom
from cte2
where yo='2014' and mo='01'
order by mom desc

--8- during weekends which city has highest total spend to total no of transcations ratio 
select * from credit_card_transcations
select top 1 city,(sum(amount)*1.0)/ count(transaction_id) as trans_ratio
from credit_card_transcations
where datepart(weekday,transaction_date) in (1,7)
group by city
order by trans_ratio desc

-- 9- which city took least number of days to reach its 500th transaction after the first transaction in that city
with abc as(select city,transaction_date,transaction_id,
row_number() over (partition by city order by transaction_date,transaction_id) as rn
from credit_card_transcations
group by city,transaction_date,transaction_id)
select top 1 city,datediff(day,min(transaction_date),max(transaction_date)) as diff_of_days
from abc
where rn in (1,500)
group by city
having count(*)=2
order by diff_of_days



