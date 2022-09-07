DROP TABLE ass_per_day CASCADE CONSTRAINTS;

DROP TABLE clients CASCADE CONSTRAINTS;

DROP TABLE employees CASCADE CONSTRAINTS;

DROP TABLE experience CASCADE CONSTRAINTS;

DROP TABLE location CASCADE CONSTRAINTS;

DROP TABLE offices CASCADE CONSTRAINTS;

DROP TABLE projects CASCADE CONSTRAINTS;

DROP TABLE works_on CASCADE CONSTRAINTS;

CREATE TABLE ass_per_day (
    ass_id              NUMBER(5) NOT NULL,
    projects_project_id NUMBER(5) NOT NULL,
    employees_emp_id    NUMBER(5) NOT NULL,
    date_worked         DATE NOT NULL,
    hours_worked        NUMBER(2)
);

ALTER TABLE ass_per_day
    ADD CONSTRAINT ass_per_day_pk PRIMARY KEY ( date_worked,
                                                employees_emp_id,
                                                ass_id,
                                                projects_project_id );

CREATE TABLE clients (
    client_id      NUMBER(5) NOT NULL,
    last_name      VARCHAR2(15) NOT NULL,
    first_name     VARCHAR2(15) NOT NULL,
    address        VARCHAR2(15) NOT NULL,
    phone          NUMBER(10) NOT NULL,
    contact_person VARCHAR2(15) NOT NULL
);

ALTER TABLE clients ADD CONSTRAINT clients_pk PRIMARY KEY ( client_id );

CREATE TABLE employees (
    emp_id            NUMBER(5) NOT NULL,
    last_name         VARCHAR2(15) NOT NULL,
    first_name        VARCHAR2(15) NOT NULL,
    address           VARCHAR2(15) NOT NULL,
    start_date        DATE NOT NULL,
    offices_office_id NUMBER(5) NOT NULL
);

ALTER TABLE employees ADD CONSTRAINT employees_pk PRIMARY KEY ( emp_id );

CREATE TABLE experience (
    hourly_rate      NUMBER(20) NOT NULL,
    job_title        VARCHAR2(15) NOT NULL,
    qualification    VARCHAR2(15) NOT NULL,
    skills           VARCHAR2(15) NOT NULL,
    employees_emp_id NUMBER(5) NOT NULL
);

ALTER TABLE experience ADD CONSTRAINT experience_pk PRIMARY KEY ( skills,
                                                                  employees_emp_id );

CREATE TABLE location (
    location_id NUMBER(5) NOT NULL,
    name        VARCHAR2(15) NOT NULL
);

ALTER TABLE location ADD CONSTRAINT location_pk PRIMARY KEY ( location_id );

CREATE TABLE offices (
    office_id            NUMBER(5) NOT NULL,
    phone                NUMBER(10) NOT NULL,
    location_location_id NUMBER(5) NOT NULL
);

ALTER TABLE offices ADD CONSTRAINT offices_pk PRIMARY KEY ( office_id );

CREATE TABLE projects (
    project_id        NUMBER(5) NOT NULL,
    project_name      VARCHAR2(10) NOT NULL,
    start_date        DATE NOT NULL,
    est_end_date      DATE NOT NULL,
    actual_end_date   DATE NOT NULL,
    est_cost          NUMBER(15) NOT NULL,
    quoted_cost       NUMBER(15) NOT NULL,
    actual_cost       NUMBER(15) NOT NULL,
    offices_office_id NUMBER(5) NOT NULL,
    clients_client_id NUMBER(5) NOT NULL
);

ALTER TABLE projects ADD CONSTRAINT projects_pk PRIMARY KEY ( project_id );

CREATE TABLE works_on (
    hours_per_pro       NUMBER(3),
    employees_emp_id    NUMBER(5) NOT NULL,
    projects_project_id NUMBER(5) NOT NULL
);

ALTER TABLE works_on ADD CONSTRAINT works_on_pk PRIMARY KEY ( employees_emp_id,
                                                              projects_project_id );

ALTER TABLE ass_per_day
    ADD CONSTRAINT ass_per_day_employees_fk FOREIGN KEY ( employees_emp_id )
        REFERENCES employees ( emp_id );

ALTER TABLE ass_per_day
    ADD CONSTRAINT ass_per_day_projects_fk FOREIGN KEY ( projects_project_id )
        REFERENCES projects ( project_id );

ALTER TABLE employees
    ADD CONSTRAINT employees_offices_fk FOREIGN KEY ( offices_office_id )
        REFERENCES offices ( office_id );

ALTER TABLE experience
    ADD CONSTRAINT experience_employees_fk FOREIGN KEY ( employees_emp_id )
        REFERENCES employees ( emp_id );

ALTER TABLE offices
    ADD CONSTRAINT offices_location_fk FOREIGN KEY ( location_location_id )
        REFERENCES location ( location_id );

ALTER TABLE projects
    ADD CONSTRAINT projects_clients_fk FOREIGN KEY ( clients_client_id )
        REFERENCES clients ( client_id );

ALTER TABLE projects
    ADD CONSTRAINT projects_offices_fk FOREIGN KEY ( offices_office_id )
        REFERENCES offices ( office_id );

ALTER TABLE works_on
    ADD CONSTRAINT works_on_employees_fk FOREIGN KEY ( employees_emp_id )
        REFERENCES employees ( emp_id );

ALTER TABLE works_on
    ADD CONSTRAINT works_on_projects_fk FOREIGN KEY ( projects_project_id )
        REFERENCES projects ( project_id );


INSERT INTO location (location_id,name) VALUES (00001,'Trikala');
INSERT INTO location (location_id,name) VALUES (00002,'Xalkida');
INSERT INTO location (location_id,name) VALUES (00003,'Patra');
INSERT INTO location (location_id,name) VALUES (00004,'Larisa');
INSERT INTO location (location_id,name) VALUES (00005,'Rhodes');

INSERT INTO Clients (client_id,last_name,first_name,address,phone,contact_person) VALUES (00006,'Georgiopoulos','Antonis','Tinou',2107494921,'Giannis');
INSERT INTO Clients (client_id,last_name,first_name,address,phone,contact_person) VALUES (00007,'Gkekas','Athanasios','Mykonou',2107494922,'Giorgos');
INSERT INTO Clients (client_id,last_name,first_name,address,phone,contact_person) VALUES (00008,'Gialelis','Panagiotis','Naxou',2107494923,'Iwanna');
INSERT INTO Clients (client_id,last_name,first_name,address,phone,contact_person) VALUES (00009,'Papatziki','Stavroula','Krhths',2107494924,'Aggelos');
INSERT INTO Clients (client_id,last_name,first_name,address,phone,contact_person) VALUES (00010,'Stalias','Aggelos','Parou',2107494925,'Giota');

INSERT INTO Offices (office_id,phone,location_location_id) VALUES (00011,2107494901,00001);
INSERT INTO Offices (office_id,phone,location_location_id) VALUES (00012,2107494902,00002);
INSERT INTO Offices (office_id,phone,location_location_id) VALUES (00013,2107494903,00003);
INSERT INTO Offices (office_id,phone,location_location_id) VALUES (00014,2107494904,00004);
INSERT INTO Offices (office_id,phone,location_location_id) VALUES (00015,2107494905,00005);

INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00016,'Antentokoumpo','Giannis','Sepoliwn',to_date('01-JAN-1991','DD-MON-YYYY'),00011);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00017,'Spanoulis','Vasilis','Kifisia',to_date('02-JAN-1991','DD-MON-YYYY'),00012);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00018,'Diamantidis','Dimitris','Lada',to_date('03-JAN-1991','DD-MON-YYYY'),00013);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00019,'Mpourousis','Giannis','Kenou',to_date('04-JAN-1991','DD-MON-YYYY'),00014);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00020,'Sloukas','Kostas','Venizelou',to_date('05-JAN-1991','DD-MON-YYYY'),00015);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00021,'Zisis','Nikos','Troias',to_date('01-JAN-1991','DD-MON-YYYY'),00011);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00022,'Papaloukas','Thodwris','Lerou',to_date('02-JAN-1991','DD-MON-YYYY'),00012);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00023,'Giannakis','Panagiotis','Karpathou',to_date('03-JAN-1991','DD-MON-YYYY'),00013);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00024,'Gkalis','Nikos','Pylou',to_date('04-JAN-1991','DD-MON-YYYY'),00014);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00025,'Fasoulas','Panagiotis','Syntagmatos',to_date('05-JAN-1991','DD-MON-YYYY'),00015);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00026,'First','Programmer','Wrehxam',to_date('01-JAN-1991','DD-MON-YYYY'),00011);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00027,'Second','Programmer','Wrehxam1',to_date('01-JAN-1991','DD-MON-YYYY'),00011);
INSERT INTO employees (emp_id,last_name,first_name,address,start_date,offices_office_id) VALUES (00028,'First','Designer','Wrehxam2',to_date('01-JAN-1991','DD-MON-YYYY'),00011);

INSERT INTO projects (project_id,project_name,start_date,est_end_date,actual_end_date,est_cost,quoted_cost,actual_cost,offices_office_id,clients_client_id) VALUES (00029,'Kallinikos',to_date('01-JAN-1991','DD-MON-YYYY'),to_date('03-JAN-1991','DD-MON-YYYY'),to_date('02-JAN-1991','DD-MON-YYYY'),330,300,350,00011,00006);
INSERT INTO projects (project_id,project_name,start_date,est_end_date,actual_end_date,est_cost,quoted_cost,actual_cost,offices_office_id,clients_client_id) VALUES (00030,'Medusa',to_date('02-JAN-1991','DD-MON-YYYY'),to_date('04-JAN-1991','DD-MON-YYYY'),to_date('03-JAN-1991','DD-MON-YYYY'),330,300,350,00012,00007);
INSERT INTO projects (project_id,project_name,start_date,est_end_date,actual_end_date,est_cost,quoted_cost,actual_cost,offices_office_id,clients_client_id) VALUES (00031,'Zeus',to_date('03-JAN-1991','DD-MON-YYYY'),to_date('05-JAN-1991','DD-MON-YYYY'),to_date('04-JAN-1991','DD-MON-YYYY'),330,300,350,00013,00008);
INSERT INTO projects (project_id,project_name,start_date,est_end_date,actual_end_date,est_cost,quoted_cost,actual_cost,offices_office_id,clients_client_id) VALUES (00032,'Hermes',to_date('04-JAN-1991','DD-MON-YYYY'),to_date('06-JAN-1991','DD-MON-YYYY'),to_date('05-JAN-1991','DD-MON-YYYY'),330,300,350,00014,00009) ;
INSERT INTO projects (project_id,project_name,start_date,est_end_date,actual_end_date,est_cost,quoted_cost,actual_cost,offices_office_id,clients_client_id) VALUES (00033,'Hercules',to_date('05-JAN-1991','DD-MON-YYYY'),to_date('07-JAN-1991','DD-MON-YYYY'),to_date('06-JAN-1991','DD-MON-YYYY'),330,300,350,00015,00010);
INSERT INTO projects (project_id,project_name,start_date,est_end_date,actual_end_date,est_cost,quoted_cost,actual_cost,offices_office_id,clients_client_id) VALUES (00034,'WrexhamPro',to_date('28-JAN-1991','DD-MON-YYYY'),to_date('30-JAN-1991','DD-MON-YYYY'),to_date('29-JAN-1991','DD-MON-YYYY'),1200,1000,1080,00011,00006);

INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00035,00029,00016,to_date('01-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00036,00029,00016,to_date('02-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00037,00029,00021,to_date('01-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00038,00029,00021,to_date('02-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00039,00030,00017,to_date('02-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00040,00030,00017,to_date('03-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00041,00030,00022,to_date('02-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00042,00030,00022,to_date('03-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00043,00031,00018,to_date('03-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00044,00031,00018,to_date('04-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00045,00031,00023,to_date('03-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00046,00031,00023,to_date('04-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00047,00032,00019,to_date('04-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00048,00032,00019,to_date('05-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00049,00032,00024,to_date('04-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00050,00032,00024,to_date('05-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00051,00033,00020,to_date('05-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00052,00033,00020,to_date('06-JAN-91'),03);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00053,00033,00025,to_date('05-JAN-91'),02);
INSERT INTO ass_per_day (ass_id,projects_project_id,employees_emp_id,date_worked,hours_worked) VALUES (00054,00033,00025,to_date('06-JAN-91'),03);



INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (45,'manager','university ','commanding',00016);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (25,'worker','high_school ','hard-working',00021);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (45,'manager','university ','commanding',00017);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (25,'worker','high_school ','hard-working',00022);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (45,'manager','university ','commanding',00018);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (25,'worker','high_school ','hard-working',00023);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (45,'manager','university ','commanding',00019);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (25,'worker','high_school ','hard-working',00024);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (45,'manager','university ','commanding',00020);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (25,'worker','high_school ','hard-working',00025);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (100,'Programmer','university ','coding',00026);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (100,'Programmer','university ','coding',00027);
INSERT INTO experience (hourly_rate,job_title,qualification,skills,employees_emp_id) VALUES (70,'Designer','university ','design',00028);

INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00016,00029);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00021,00029);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00017,00030);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00022,00030);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00018,00031);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00023,00031);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00019,00032);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00024,00032);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00020,00033);
INSERT INTO works_on (hours_per_pro,employees_emp_id,projects_project_id) VALUES (005,00025,00033);
