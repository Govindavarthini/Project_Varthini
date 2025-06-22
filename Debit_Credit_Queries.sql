use p863_bank_analytics;
select * from banking_data limit 10;
## Total Credit Amount
select transaction_type, sum(amount) as Total_Credit_amount from banking_data where transaction_type = "Credit";
-------------------------------------------------------------------------------------------------------------------------------------------
## Total Debit Amount
select transaction_type, sum(amount) as Total_Debit_amount from banking_data where transaction_type = "Debit";
-------------------------------------------------------------------------------------------------------------------------------------------
## Credit to Debit Ratio
select sum(case when transaction_type= "Credit" then amount else 0 end)/nullif(sum(case when transaction_type= "Debit" then amount else 0 end),0) 
as Credit_debit_Ratio from banking_data;
-------------------------------------------------------------------------------------------------------------------------------------------
## Net Transaction Amount
select sum(case when transaction_type= "Credit" then amount else 0 end)-nullif(sum(case when transaction_type= "Debit" then amount else 0 end),0) 
as Net_transaction_amount from banking_data;
-------------------------------------------------------------------------------------------------------------------------------------------
## Account Activity Ratio
select count(*)/sum(balance) as Account_Activity_Ratio from banking_data;
-------------------------------------------------------------------------------------------------------------------------------------------
## Transactions per Day/Week/Month
select date(transaction_date) as Day, weekofyear(transaction_date) as Week,monthname(transaction_date) as Month_name, 
count(*) as transaction_per_day from banking_data group by 1,2,3 order by 1,2,3;
-------------------------------------------------------------------------------------------------------------------------------------------
## Total Transaction Amount by Branch
select branch, sum(amount) as Total_transaction_amount from banking_data group by branch order by 2 desc;
-------------------------------------------------------------------------------------------------------------------------------------------
## Transaction Volume by Bank
select bank_name, sum(amount) as Total_transaction_amount from banking_data group by bank_name order by 2 desc;
-------------------------------------------------------------------------------------------------------------------------------------------
## Transaction Method Distribution
select transaction_method, count(transaction_method)as transation_method_distribution from banking_data group by transaction_method order by 2 desc;
-------------------------------------------------------------------------------------------------------------------------------------------
## Branch Transaction Growth
select branch, year(transaction_date) as Year, monthname(transaction_date) as Month_name, month(transaction_date) as Month, sum(amount) as Periodic_Transation_amount 
from banking_data group by 1,2,3,4 order by 4;
-------------------------------------------------------------------------------------------------------------------------------------------
## High-Risk Transaction Flag
select count(*) as Total_transations, sum(case when amount>=4500 then 1 else 0 end) as High_risk_Transactions from banking_data;
-------------------------------------------------------------------------------------------------------------------------------------------
## Suspicious Transaction Frequency
select year(transaction_date) as Year, monthname(transaction_date) as month, count(*) as Total_transations, sum(case when amount>=4500 then 1 else 0 end) 
as High_risk_Transactions from banking_data group by 1,2 order by 4 desc;



