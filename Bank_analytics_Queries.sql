use p863_bank_analytics;
## Bank Analytics KPI
select * from raw_bank_data limit 10;
select * from cleaned_bank_data limit 10;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Total Loan Amount Funded
select sum(funded_amount) as Total_loan_amount_funded from cleaned_bank_data;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Total Loans
select count(loan_amount) as Total_loans from cleaned_bank_data;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Total Collection
select sum(total_rec_principal)as total_principal, sum(total_rec_interest)as Total_interest,sum(total_rec_principal+total_rec_interest) 
as Total_collection from cleaned_bank_data;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Total Interest
select sum(total_rec_interest) as Total_Interest from cleaned_bank_data;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Branch-Wise (Interest, Fees, Total Revenue)
select branch_name, sum(total_rec_interest) as Interest, sum(total_fees) as Fees, 
sum(total_rec_interest+total_fees+total_rec_late_fee+recoveries+collection_recovery_fee) as Total_revenue from cleaned_bank_data group by 1 order by branch_name asc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## State-Wise Loan
select state_abbr, sum(loan_amount) as Loan from cleaned_bank_data group by 1 order by state_abbr asc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Religion-Wise Loan
select religion, sum(funded_amount) as Loan from cleaned_bank_data group by 1 order by religion desc;
select case when religion = '' then "Others" else religion end as Religion_Name, sum(funded_amount) as Loan from cleaned_bank_data group by 1 order by Loan desc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Product Group-Wise Loan
select purpose_category, sum(loan_amount) as Loan from cleaned_bank_data group by 1 order by purpose_category asc;
select case when purpose_category in ('Juicer- Mixer-Grinder','Inverter','Kitchen Set','Mobile Phones','Festive Loan-Product','Festive Loan-Product 2019','Individual Loan','Television','Trade','Washing Machine') then "Personl_Loan"
when purpose_category in ('Home Loan') then "Mortgage Loan"
when purpose_category in ('Bike') then "Auto_loan"
when purpose_category in ('Livestock Loan','Manufacturing') then "Agriculture_loan"
when purpose_category in('Agriculture','Business ') then "Business Loan"
else "Other"
end as Loan_Group, sum(loan_amount) as Total_Loan_amount from cleaned_bank_data group by 1 order by 2 desc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Disbursement Trend
select disbursement_year, sum(funded_amount) as Loan from cleaned_bank_data group by 1 order by disbursement_year desc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Grade-Wise Loan
select grade, sum(loan_amount) as Loan from cleaned_bank_data group by 1 order by grade asc;
select case when grade = '' then 'Others' else grade end as grade_group, sum(loan_amount) AS total_loan from cleaned_bank_data group by 1 order by 2 desc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Count of Default Loan
select count(is_default_loan) as Total_loan_count from cleaned_bank_data;
select count(is_default_loan) as Default_loan_count from cleaned_bank_data where is_default_loan="Y";
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Count of Delinquent Clients
select count(is_delinquent_loan) as Total_client_count from cleaned_bank_data;
select count(is_delinquent_loan) as Delinquent_client_count from cleaned_bank_data where is_delinquent_loan="Y";
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Delinquent Loans Rate
select (count(case when is_delinquent_loan = "Y" then 1 end)/count(loan_amount))*100 as Delinquent_Loans_Rate from cleaned_bank_data;
select concat((count(case when is_delinquent_loan = "Y" then 1 end)/count(loan_amount))*100,'%') as Delinquent_Loans_Rate from cleaned_bank_data;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Default Loan Rate
select concat((count(case when is_default_loan= "Y" then 1 end)/count(loan_amount))*100,'%') as Default_Loan_Rate from cleaned_bank_data;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Loan Status-Wise Loan
select case when is_delinquent_loan = "Y" then "delinquent"
when is_default_loan="Y" then "defaulted"
when loan_status = "Active Loan" then "Active"
when loan_status in ("Fully Paid", "Paid Off", "Insurance Paid Off") then "Closed"
when loan_status in ("Net_off"," Cancelled") then "Written Off"
when loan_status = "Transferred" then "Transferred"
else "Others" end as Loan_status, sum(loan_amount) as Total_loan from cleaned_bank_data group by 1 order by Total_loan desc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Age Group-Wise Loan
select age, sum(loan_amount) as total_loan from cleaned_bank_data group by 1 order by age asc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## No Verified Loan
select case when verification_status= "not verified" then "NO" else "YES" end as No_verfication_done, sum(loan_amount) 
as Total_loan_amount, count(loan_amount) as Total_loan_count from cleaned_bank_data group by 1 order by Total_loan_amount asc;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Loan Maturity
select term, sum(funded_amount) as Total_loan_amount_paid, count(loan_amount) as Loan_Count from cleaned_bank_data group by 1;