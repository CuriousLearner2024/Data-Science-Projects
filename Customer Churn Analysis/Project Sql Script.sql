create database PROJECT;
use PROJECT;
describe customer_churn_records;

select*from customer_churn_records;

# Number of Rows
select count(*) as total_rows from Customer_Churn_Records;

-- RowNumber—corresponds to the record (row) number and has no effect on the output.
-- CustomerId—contains random values and has no effect on customer leaving the bank.
-- Surname—the surname of a customer has no impact on their decision to leave the bank.
-- CreditScore—can have an effect on customer churn, since a customer with a higher credit score is less likely to leave the bank.
-- Geography—a customer’s location can affect their decision to leave the bank.
-- Gender—it’s interesting to explore whether gender plays a role in a customer leaving the bank.
-- Age—this is certainly relevant, since older customers are less likely to leave their bank than younger ones.
-- Tenure—refers to the number of years that the customer has been a client of the bank. Normally, older clients are more loyal and less likely to leave a bank.
-- Balance—also a very good indicator of customer churn, as people with a higher balance in their accounts are less likely to leave the bank compared to those with lower balances.
-- NumOfProducts—refers to the number of products that a customer has purchased through the bank.
-- HasCrCard—denotes whether or not a customer has a credit card. This column is also relevant, since people with a credit card are less likely to leave the bank.
-- IsActiveMember—active customers are less likely to leave the bank.
-- EstimatedSalary—as with balance, people with lower salaries are more likely to leave the bank compared to those with higher salaries.
-- Exited—whether or not the customer left the bank.
-- Complain—customer has complaint or not.
-- Satisfaction Score—Score provided by the customer for their complaint resolution.
-- Card Type—type of card hold by the customer.
-- Points Earned—the points earned by the customer for using credit card.

# CHANGING THE NAMES OF COLUMNS 
Alter table  customer_churn_records rename column `Satisfaction Score` to Satisfaction_Score;
Alter table  customer_churn_records rename column `Card Type` to Card_Type;
Alter table  customer_churn_records rename column `Point Earned` to Point_Earned;

# Checking Null Values in the columnns

SELECT 
    COUNT(*) AS total_count, 
    SUM(CASE WHEN CreditScore IS NULL THEN 1 ELSE 0 END) AS null_creditscore,
    SUM(CASE WHEN Geography IS NULL THEN 1 ELSE 0 END) AS null_Geography,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS null_Gender,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_Age,
    SUM(CASE WHEN Balance IS NULL THEN 1 ELSE 0 END) AS null_balance,
    SUM(CASE WHEN NumOfProducts IS NULL THEN 1 ELSE 0 END) AS null_NumOfProducts,
    SUM(CASE WHEN HasCrCard IS NULL THEN 1 ELSE 0 END) AS null_HasCrCard,
    SUM(CASE WHEN EstimatedSalary IS NULL THEN 1 ELSE 0 END) AS null_EstimatedSalary,
    SUM(CASE WHEN Exited IS NULL THEN 1 ELSE 0 END) AS null_Exited,
    SUM(CASE WHEN Complain IS NULL THEN 1 ELSE 0 END) AS null_Complain,
    SUM(CASE WHEN Satisfaction_Score IS NULL THEN 1 ELSE 0 END) AS null_Satisfaction_Score,
    SUM(CASE WHEN Card_Type IS NULL THEN 1 ELSE 0 END) AS null_Card_Type,
    SUM(CASE WHEN Point_Earned IS NULL THEN 1 ELSE 0 END) AS null_Point_Earned
FROM Customer_Churn_Records;

# Delting Null values from the table
Delete from  customer_churn_records where CreditScore is null 
or Geography is null 
or Gender is null 
or Age is null 
or Tenure is null 
or Balance is null 
or NumOfProducts is null
or HasCrCard is null 
or IsActiveMember is null 
or EstimatedSalary is null 
or Exited is null 
or Complain is null 
or Satisfaction_Score is null 
or Card_Type is null 
or Point_Earned is null;
   
   
describe customer_churn_records;
   
# Performning Summary Satatistics
 
# CreditScore 
select AVG(CreditScore) as avg_credit_score, min(CreditScore) as min_credit_score, max(CreditScore) as max_credit_score, stddev(CreditScore) as std_credit_score from customer_churn_records;
#650.5288 , 350 , 850 , 96.64846595037089


Select Tenure,count(Tenure) as freq from customer_churn_records  where Exited="1" group by Tenure order by Tenure desc;
# Ranking Customers by their Geographical location
Select Geography, count(Geography) as frequency from customer_churn_records group by Geography order by frequency desc limit 3;
# More than half of the customers are from France

# Frquecny count of customers by their gender
Select Gender, count(Gender) as frequency from customer_churn_records group by Gender order by frequency desc limit 2;
# More than half of the customers are Male

# Age   
select min(Age) as min_age, max(Age) as max_age,avg(Age) as avg_age,stddev(Age) as stddev_age from customer_churn_records;
#18, 92, 38.9218, 10.48728204827159

# Tenure
select min(Tenure) as min_Tenure, max(Tenure) as max_Tenure,avg(Tenure) as avg_Tenure,stddev(Tenure) as stddev_Tenure from customer_churn_records;
# 0,	10,	5.0128,	2.8920297647154327

# Balance
Select min(Balance) as min_Balance, max(Balance) as max_Balance,avg(Balance) as avg_Balance,stddev(Balance) as stddev_Balance from customer_churn_records;
# 0,	250898.09,	76485.88928799961,	62394.285254125214
select max(Balance) as max_Balance from customer_churn_records where Exited="0";
# NumOfProducts
Select min(NumOfProducts) as min_NumOfProducts, max(NumOfProducts) as max_NumOfProducts,avg(NumOfProducts) as avg_NumOfProducts,stddev(NumOfProducts) AS stddev_NumOfProducts from customer_churn_records;

# Mode of NumOfProducts used 
Select NumOfProducts, count(NumOfProducts) as frequency from customer_churn_records group by NumOfProducts order by frequency desc limit 4;
# Most people at best have 1 product or 2 bank product a very small portion of the customer use 3 or more products


# Mode of IsActiveMember 
Select IsActiveMember, count(IsActiveMember) as frequency from customer_churn_records group by IsActiveMember order by frequency desc limit 2;
# 5151 are active customers

# EstimatedSalary
Select min(EstimatedSalary) as min_EstimatedSalary, max(EstimatedSalary) AS max_EstimatedSalary,avg(EstimatedSalary) as avg_EstimatedSalary,stddev(EstimatedSalary) as stddev_EstimatedSalary from customer_churn_records;

# Mode of Exited 
Select Exited, count(Exited) as frequency from customer_churn_records group by Exited order by frequency desc limit 2;
# 2038 customer have lef the bank

# Mode of Complain
Select Complain, count(Complain) as frequency from customer_churn_records group by Complain order by frequency desc limit 2;
-- only 20.44% customer complained

# Mode of Satisfaction Score
Select Satisfaction_Score, count(Satisfaction_Score) as frequency from customer_churn_records group by  Satisfaction_Score order by frequency desc limit 5;
# 60.5% customer gave more then 2 satisfaction score 

# Types of Card
select distinct Card_Type from customer_churn_records;

# Mode of Card_Type 
Select Card_Type, count(Card_Type) as frequency from customer_churn_records group by  Card_Type order by frequency desc limit 5;
# Card_Type amog customer is almost equally distributed

# Point_Earned
Select min(Point_Earned) as min_Point_Earned, max(Point_Earned) as max_Point_Earned,avg(Point_Earned) as avg_Point_Earned,stddev(Point_Earned) as stddev_Point_Earned from customer_churn_records;

# Geography
Select distinct Geography from customer_churn_records;
# Customers belong from three different country France Spain Germany

# Mode of Geography
select Geography, count(Geography) as Location from customer_churn_records group by Geography order by Location desc limit 3 ;

# Number of customers Churned 
select*from Customer_Churn_Records where Exited="1" ;
select Exited,count(Exited) as Churned_Customer from Customer_Churn_Records where Exited="1" ;

# Churn Rate 
SELECT sum(Exited) / count(*) AS churn_rate from Customer_Churn_Records;


# Churned customers and their Geographical location in descending order
select Geography,count(Geography) as Location from customer_churn_records  where Exited ="1" group by Geography order by Location desc limit 3;
# Almost 80 % of the bchurned customer belong from Germany and Spain

# Churn rate by geography
select Geography, sum(Exited) / count(*) as churn_rate from customer_churn_records group by  Geography;

# Churned customers and their Gender in a descending order
select Gender,count(Gender) as Gender from customer_churn_records  where Exited ="1" group by Gender order by Gender desc;
# Females are the most churned customers

# Churn rate by geography
select Gender, sum(Exited) / count(*) as churn_rate from customer_churn_records group by  Gender;


# Churned customers and their creditscore
select min(CreditScore) as minimum_CreditScore, max(CreditScore) as maximum_CreditScore,avg(CreditScore) as average_CreditScore ,sum(CreditScore)/2 as median_CreditScore
from customer_churn_records where Exited in (select Exited from Customer_Churn_Records where Exited="1") group by Exited,minimum_CreditScore,maximum_CreditScore,average_CreditScore,median_CreditScore;



select min(CreditScore) as minimum_CreditScore, max(CreditScore) as maximum_CreditScore,avg(CreditScore) as average_CreditScore ,sum(CreditScore)/2 as median_CreditScore from customer_churn_records where Exited="1" and Gender="Female";

#from customer_churn_records where Exited (select Exited from customer_churn_records where Exited ="1");

select HasCrCard,count(HasCrCard) from customer_churn_records where HasCrCard="0"and Exited="1";








