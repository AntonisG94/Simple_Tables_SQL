/*4. a: Selecting Records from the Table (20%)*/
/*-----------------------Query 1-----------------------*/
SELECT em.last_name,em.first_name,l.name,em.start_date Hire_date
FROM employees em, offices o, location l
WHERE (em.offices_office_id=o.office_id AND o.location_location_id=l.location_id);
/*-----------------------Query 2-----------------------*/
SELECT em.last_name,em.first_name,e.skills,ROUND((w.hours_per_pro/24/30),3) as Experience_Per_Month,ROUND((w.hours_per_pro/24/30/12),6) as Experience_Per_Year
FROM employees em INNER JOIN experience e
ON em.emp_id=e.employees_emp_id
INNER JOIN works_on w
ON w.employees_emp_id=em.emp_id
ORDER BY e.skills,e.hourly_rate DESC;
/*-----------------------Query 3-----------------------*/
SELECT distinct em.emp_id,em.last_name,em.first_name,p.project_name
FROM employees em
INNER JOIN works_on w
ON w.employees_emp_id=em.emp_id
INNER JOIN projects p
ON p.project_id=w.projects_project_id;
/*-----------------------Query 4-----------------------*/
SELECT p.project_id,c.client_id,c.last_name client_last_name,c.first_name client_first_name,c.address,c.phone,c.contact_person,l.name as City
FROM projects p
INNER JOIN clients c
ON p.clients_client_id=c.client_id
INNER JOIN offices o
ON o.office_id=p.offices_office_id
INNER JOIN location l
ON l.location_id=o.location_location_id
WHERE (p.start_date BETWEEN ('01-JAN-1991') AND ('31-JAN-1991'))
ORDER BY l.name;
/*-----------------------Query 5-----------------------*/
SELECT p.project_id,c.last_name clients_last_name,(ROUND(MONTHS_BETWEEN(p.actual_end_date,p.start_date),5)) as time_to_complete_in_months
FROM projects p
INNER JOIN clients c
ON p.clients_client_id=c.client_id
WHERE (ROUND(MONTHS_BETWEEN( p.actual_end_date,p.start_date),5))=(SELECT MAX(ROUND(MONTHS_BETWEEN( actual_end_date,start_date),5))
FROM projects);
/*-----------------------Query 6-----------------------*/
SELECT distinct p.project_id,p.project_name,w.hours_per_pro as Hours_Worked_in_January_For_The_Project
FROM works_on w
INNER JOIN projects p
ON p.project_id=w.projects_project_id
WHERE ((EXTRACT(MONTH FROM p.start_date)=1) AND (EXTRACT(MONTH FROM p.actual_end_date)=1))
ORDER BY Hours_Worked_in_January_For_The_Project DESC;
/*-----------------------Query 7-----------------------*/
SELECT projects_project_id,COUNT(projects_project_id) as employees_number
FROM works_on
GROUP BY projects_project_id
HAVING COUNT(*)=(SELECT MAX(COUNT(projects_project_id))
FROM works_on
GROUP BY projects_project_id);

/*-----------------------Query 8-----------------------*/
SELECT CONCAT(e.hourly_rate*a.hours_worked,'€') as ASSIGNMENT_COST,em.last_name,p.project_name,a.date_worked as DATE_WORKED, a.hours_worked||' Hours' as TIME_SPENT
FROM projects p
INNER JOIN ass_per_day a
ON p.project_id=a.projects_project_id
INNER JOIN employees em
ON a.employees_emp_id=em.emp_id
INNER JOIN experience e
ON e.employees_emp_id=em.emp_id
ORDER BY a.ass_id;

/*-----------------------Query 09-----------------------*/
SELECT a.projects_project_id,SUM(e.hourly_rate*a.hours_worked/(p.actual_end_date-p.start_date)) as project_cost_per_month
FROM projects p
INNER JOIN ass_per_day a
ON p.project_id=a.projects_project_id
INNER JOIN employees em
ON a.employees_emp_id=em.emp_id
INNER JOIN experience e
ON e.employees_emp_id=em.emp_id
GROUP BY a.projects_project_id;

/*-----------------------Query 10-----------------------*/
/*we assume that NULL assignment hours means assignment didnt start yet*/
SELECT em.last_name,em.first_name
FROM employees em
WHERE em.start_date <= ('28-JAN-1991') AND em.emp_id NOT IN (SELECT distinct a.employees_emp_id
FROM ass_per_day a
WHERE a.date_worked!=('28-JAN-1991') AND a.hours_worked IS NOT NULL) AND em.emp_id IN
(SELECT  e.employees_emp_id
FROM experience e
WHERE e.job_title='Programmer' OR e.job_title='Designer');

/*4. b: Inserting, Updating and Deleting Records (10%)*/

/*-----------------------Query 1-----------------------*/
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (NULL,00026,00034);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (NULL,00027,00034);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (NULL,00028,00034);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00055,34,00026,to_date('28-JAN-1991','DD-MON-YYYY'),NULL);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00056,34,00027,to_date('28-JAN-1991','DD-MON-YYYY'),NULL);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00057,34,00028,to_date('28-JAN-1991','DD-MON-YYYY'),NULL);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00058,34,00026,to_date('29-JAN-1991','DD-MON-YYYY'),NULL);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00059,34,00027,to_date('29-JAN-1991','DD-MON-YYYY'),NULL);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00060,34,00028,to_date('29-JAN-1991','DD-MON-YYYY'),NULL);

/*-----------------------Query 2-----------------------*/
INSERT INTO Clients (client_id,last_name,first_name,address,phone,contact_person) VALUES (00300,'Skoumpri','Nina','Alexandras',2107495681,'Markos');
INSERT INTO projects (project_id,project_name,start_date,est_end_date,actual_end_date,est_cost,quoted_cost,actual_cost,offices_office_id,clients_client_id) VALUES (00204,'OrderSys',to_date(sysdate,'DD-MON-YYYY'),to_date(SYSDATE+1,'DD-MON-YYYY'),to_date(SYSDATE+3,'DD-MON-YYYY'),25000,30000,28000,00011,00300);

/*-----------------------Query 3-----------------------*/
UPDATE experience SET hourly_rate=hourly_rate+hourly_rate*20/100;

/*-----------------------Query 4-----------------------*/
UPDATE projects
SET
    actual_end_date=actual_end_date+1,
    actual_cost=actual_cost+(actual_cost/(actual_end_date+1-start_date))
WHERE
    project_id=00029;

/*-----------------------Query 5-----------------------*/
-- Error starting at line : 1 in command -
-- delete from projects where project_id=45
-- Error report -
-- ORA-02292: integrity constraint (GEORGIOPOULOS.WORKS_ON_PROJECTS_FK) violated - child record found
-- Essentially we are not allowed to delete a row of our table not only because we have constraints in
-- terms of project_id but because project_id goes to other tables as the primary key
