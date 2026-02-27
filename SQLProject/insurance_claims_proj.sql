SELECT * from insurance_claims where age = 42;
-- Top 5 claims by policy 
SELECT months_as_customer,age,policy_number,SUM(total_claim_amount) as totals
FROM insurance_claims
GROUP BY months_as_customer,age,policy_number
ORDER BY totals DESC LIMIT 5;
---Update table add new col Fraud_flag 
--ALTER TABLE insurance_claims ADD COLUMN fraud_flag INTEGER;
--UPDATE  insurance_claims SET fraud_flag = CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END; 

--find the fraud rate based on severtity
SELECT incident_severity,ROUND(100 *SUM(CASE WHEN fraud_reported = 'Y' THEN 1 ELSE 0 END)/count(*),2) as Percentage_fraud,COUNT(*) as counts FROM insurance_claims
GROUP BY incident_severity
ORDER BY Percentage_fraud;

--avg claim by age GROUP
SELECT CASE
	WHEN age < 20 THEN 'Under 20'
	WHEN age BETWEEN 20 AND 29 THEN '20-29'
	WHEN age BETWEEN 30 AND 39 THEN '30-39'
	WHEN age BETWEEN 40 AND 49 THEN '40-49'
	WHEN age >= 50 THEN '50+'
	ELSE 'Unknown'
END AS age_group,
AVG(total_claim_amount) as average
FROM insurance_claims
GROUP BY age_group
ORDER BY average;
---Policyholders where total_claim_amount > 3x their months_as_customer * 1000
SELECT months_as_customer,total_claim_amount FROM insurance_claims WHERE total_claim_amount > (3 *months_as_customer*1000);
--States with avg claim > $15k AND fraud_reported = 'Y'
SELECT policy_state,COUNT(policy_state) as counts
FROM insurance_claims 
WHERE fraud_reported = 'Y' and (SELECT AVG(total_claim_amount) FROM insurance_claims) > 15000
GROUP BY policy_state;
--Running 3-month total claims per policy number
SELECT policy_number,policy_bind_date,
sum(total_claim_amount) OVER(PARTITION BY policy_number ORDER BY policy_bind_date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) as totals FROM insurance_claims; 
-- Find policies where vehicle  appears more than 10 times total:
SELECT policy_number,auto_make,incident_severity FROM insurance_claims i1 WHERE
 (SELECT count(policy_number) FROM insurance_claims i2 WHERE i1.auto_make = i2.auto_make) > 10;
--Show top 3 policies per vehicle  by incident severity 
SELECT policy_number,incident_severity,auto_make FROM 
(SELECT policy_number,incident_severity,auto_make,rank() OVER(PARTITION by auto_make ORDER BY incident_severity DESC) as ranks 
FROM insurance_claims) as t WHERE ranks <=3;
--Cumulative count of incidents per severity level over time
SELECT incident_severity,count(*) OVER(PARTITION BY incident_severity ORDER BY incident_date) as counts FROM insurance_claims ORDER BY counts DESC LIMIT 5;
--claims in the month of december 
select policy_number,sum(total_claim_amount) as totals FROM insurance_claims where strftime('%m',date(incident_date))  = '01' GROUP BY policy_number order by totals desc;
--Calculate the claims if the incident year and the make year are same
SELECT incident_date,auto_year,policy_number,total_claim_amount FROM insurance_claims WHERE strftime('%Y',date(incident_date)) = auto_year;
---the top 5 vehicle makes with the highest average total claim amount for major severity incidents.
SELECT incident_severity,auto_make,ROUND(average,2) FROM (SELECT incident_severity,auto_make,AVG(total_claim_amount) 
OVER(PARTITION BY auto_make ORDER BY total_claim_amount DESC) as average
 FROM insurance_claims) as t WHERE incident_severity = 'Major Damage'  LIMIT 5;

