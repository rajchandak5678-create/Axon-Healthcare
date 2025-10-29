use healthcare_db;
select * from doctors;
select * from patients;
select * from results;
select * from treatments;
select * from visits;

# 1.Total Doctors
select concat(round(count(`Doctor ID`)/1000,1),"K") as Total_Doctors from doctors;

# 2.Total Patients
select concat(round(count(`Patient ID`)/1000,1),"K") as Total_Patient from patients;

# 3.Total Visits
select concat(round(count(`Visit ID`)/1000,1),"K") as Total_Visits from visits;

# 4.Average Age of Patients
select (round(avg(Age))) as Average_Age
from patients;

# 5.Top 5 Diagnosed Conditions
select diagnosis from visits;
select Diagnosis, count(*) as Total_Cases
from Visits
group by Diagnosis
order by Total_Cases desc
limit 5;

# 6.Follow-Up Rate
select count(`Follow Up Required`) as Followups_Required,
concat(round(100 * count(`Follow Up Required`) / (select count(`Follow Up Required`) from Visits),2),"%") 
as FollowUp_Percentage
from Visits
where `Follow Up Required` = 'Yes';

# 7.Treatment Cost per Visit
select 
concat("$ ", round(avg(`Treatment Cost`),2)) as Avg_Treatment_Cost
from treatments;

# 8.Total Lab Tests Conducted
select concat(round(count('Lab Result ID')/1000)," K") as Total_Lab_tests_conducted
from results;

# 9.Percentage of Abnormal Lab Results
select concat(round(sum(case when `Test Result` = "Abnormal" then 1 else 0 end)*100.0 / count(*),2),"%")
as Abnormal_Percentage 
from Results;

# 10.Doctor Workload (Avg. Patients Per Doctor)
select avg(Patient_Count) as Avg_Patients_per_Doctor
from
(select `Doctor ID`, count(distinct `Patient ID`) as Patient_Count
from Visits
group by `Doctor ID`) 
as Doctor_Workload;

# 11.Total Revenue 
select concat("$ ", round(sum(`Treatment Cost` + `Cost`)/1000000, 2)," M") as Total_Revenue
from treatments;
