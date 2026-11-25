CREATE TABLE financial_loan (
    id BIGINT,
    address_state VARCHAR(10),
    application_type VARCHAR(50),
    emp_length VARCHAR(50),
    emp_title VARCHAR(255),
    grade VARCHAR(10),
    home_ownership VARCHAR(50),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(50),
    next_payment_date DATE,
    member_id BIGINT,
    purpose VARCHAR(100),
    sub_grade VARCHAR(10),
    term VARCHAR(50),
    verification_status VARCHAR(50),
    annual_income NUMERIC(15,2),
    dti NUMERIC(10,2),
    installment NUMERIC(15,2),
    int_rate NUMERIC(10,2),
    loan_amount BIGINT,
    total_acc INT,
    total_payment BIGINT
);
select * from  financial_loan;

--Toal loan application
select count(id)as Total_loan_application from financial_loan;

--MTD loan application
select count(id)as Total_loan_application from financial_loan
where extract(MONTH from issue_date)=12;

--pMTD loan application
select count(id)as pTotal_loan_application from financial_loan
where extract(MONTH from issue_date)=11;

--Total funded amount
select sum(loan_amount)as Total_funded_amount from financial_loan;

--MTD total funded amount
select sum(loan_amount)as MTD_Total_funded_amount from financial_loan
where extract(month from issue_date)=12 and extract(year from issue_date)=2021;

--PMTD total funded amount
select sum(loan_amount)as pMTD_Total_funded_amount from financial_loan
where extract(month from issue_date)=11 and extract(year from issue_date)=2021;

--Total amount recived
select sum(total_payment)as Total_amount_recived from financial_loan;

select sum(total_payment)as MTD_Total_amount_recived from financial_loan
where extract(month from issue_date)=12 and extract(year from issue_date)=2021;

select sum(total_payment)as PMTD_Total_amount_recived from financial_loan
where extract(month from issue_date)=11 and extract(year from issue_date)=2021;

--Average intrest rate
select round(avg(int_rate)*100,2) as avg_intrest_rate from financial_loan;

select round(avg(int_rate)*100,2) as MTD_avg_intrest_rate from financial_loan
where extract(month from issue_date)=12 and extract(year from issue_date)=2021;

select round(avg(int_rate)*100,2) as PMTD_avg_intrest_rate from financial_loan
where extract(month from issue_date)=11 and extract(year from issue_date)=2021;

--Average Debt-to-Income rate
select round(avg(dti),2)*100 as Average_dti from financial_loan;

select round(avg(dti),2)*100 as MTD_Average_dti from financial_loan
where extract(month from issue_date)=12 and extract(year from issue_date)=2021;

select round(avg(dti),2)*100 as PMTD_Average_dti from financial_loan
where extract(month from issue_date)=11 and extract(year from issue_date)=2021;

--Good loan percentage
select 
(count(case when loan_status='Fully Paid' or loan_status='Current' then id  end)*100)
/count(id)as good_loan_percentage
from financial_loan;

--Good loan application
select count(id) as good_loan_application from financial_loan
where loan_status='Fully Paid' or loan_status='Current';

--Good loan funded amount
select sum(loan_amount) as good_loan_funded_amount from financial_loan
where loan_status='Fully Paid' or loan_status='Current';

--Good loan total recived amount
select sum(total_payment) as good_loan_recived_amount from financial_loan
where loan_status='Fully Paid' or loan_status='Current';

--Bad loan percentage
select 
(count(case when loan_status='Charged Off'  then id  end)*100.0)
/count(id)as bad_loan_percentage
from financial_loan;

--bad loan application
select count(id) as bad_loan_application from financial_loan
where loan_status='Charged Off';

--Bad loan funded amount
select sum(loan_amount) as bad_loan_funded_amount from financial_loan
where loan_status='Charged Off' ;

--Bad loan total recived amount
select sum(total_payment) as Bad_loan_recived_amount from financial_loan
where loan_status='Charged Off';

--Loan status grid view
select 
loan_status,
count(id)as total_loan_application,
sum(total_payment)as total_amount_recived,
sum(loan_amount)as total_funded_amount,
avg(int_rate*100)as intrest_rate,
avg(dti *100) as dti
from financial_loan 
group by loan_status;

select 
loan_status,
sum(total_payment)as MTD_total_amount_recived,
sum(loan_amount)as MTD_total_funded_amount
from financial_loan 
where extract(month from issue_date)= 12
group by loan_status;

-- Monthly trends by issue date
select 
extract(month from issue_date)as month_number,
To_Char(issue_date,'month')as month_name,
count(id)as Total_loan_application,
sum(total_payment)as total_amount_recived,
sum(loan_amount)as total_funded_amount
from financial_loan
group by extract(month from issue_date),To_Char(issue_date,'month')
order by extract(month from issue_date);

--Regional analysis by state
select 
address_state,
count(id)as Total_loan_application,
sum(total_payment)as total_amount_recived,
sum(loan_amount)as total_funded_amount
from financial_loan
group by address_state
order by sum(loan_amount) desc;

--Loan term analyis
select 
term,
count(id)as Total_loan_application,
sum(total_payment)as total_amount_recived,
sum(loan_amount)as total_funded_amount
from financial_loan
group by term
order by term;

--Employee length analysis
select 
emp_length,
count(id)as Total_loan_application,
sum(total_payment)as total_amount_recived,
sum(loan_amount)as total_funded_amount
from financial_loan
group by emp_length
order by count(id)desc;

--Loan purpose breakdown
select 
purpose,
count(id)as Total_loan_application,
sum(total_payment)as total_amount_recived,
sum(loan_amount)as total_funded_amount
from financial_loan
group by purpose
order by count(id)desc;

--Home ownership analysis 
select 
home_ownership,
count(id)as Total_loan_application,
sum(total_payment)as total_amount_recived,
sum(loan_amount)as total_funded_amount
from financial_loan
group by home_ownership
order by count(id)desc;