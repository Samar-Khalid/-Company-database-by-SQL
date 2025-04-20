CREATE DATABASE Company;

CREATE TABLE DEPARTMENT (
  dname        varchar(25) not null,
  dnumber      int not null,
  mgrssn      char(9) not null, 
  mgrstartdate date,
  CONSTRAINT pk_Department primary key (dnumber),
  CONSTRAINT uk_dname UNIQUE (dname) 
);

CREATE TABLE EMPLOYEE (
  fname    varchar(15) not null, 
  minit    varchar(1),
  lname    varchar(15) not null,
  ssn     char(9), 
  bdate    date,
  address  varchar(50),
  sex      char,
  salary   decimal(10,2),
  superssn char(9),
  dno      int,
  CONSTRAINT pk_employee primary key (ssn),
  CONSTRAINT fk_employee_department foreign key (dno) references DEPARTMENT(dnumber)
);

CREATE TABLE DEPENDENT (
  essn           char(9),
  dependent_name varchar(15),
  sex            char,
  bdate          date,
  relationship   varchar(8),
  CONSTRAINT pk_essn_dependent_name primary key (essn,dependent_name),
  CONSTRAINT fk_dependent_employee foreign key (essn) references EMPLOYEE(ssn)
);

CREATE TABLE DEPT_LOCATIONS (
  dnumber   int,
  dlocation varchar(15), 
  CONSTRAINT pk_dept_locations primary key (dnumber,dlocation),
  CONSTRAINT fk_deptlocations_department foreign key (dnumber) references DEPARTMENT(dnumber)
);


CREATE TABLE PROJECT (
  pname      varchar(25) not null,
  pnumber    int,
  plocation  varchar(15),
  dnum       int not null,
  CONSTRAINT ok_project primary key (pnumber),
  CONSTRAINT uc_pnumber unique (pname),
  CONSTRAINT fk_project_department foreign key (dnum) references DEPARTMENT(dnumber)
);

CREATE TABLE WORKS_ON (
  essn   char(9),
  pno    int,
  hours  decimal(4,1),
  CONSTRAINT pk_worksOn primary key (essn,pno),
  CONSTRAINT fk_workson_employee foreign key (essn) references EMPLOYEE(ssn),
  CONSTRAINT fk_workson_project foreign key (pno) references PROJECT(pnumber)
);



INSERT INTO DEPARTMENT VALUES ('Research','5','333445555','1978-05-22');
INSERT INTO DEPARTMENT VALUES ('Administration','4','987654321','1985-01-01');
INSERT INTO DEPARTMENT VALUES ('Headquarters','1','888665555','1971-06-19');
INSERT INTO DEPARTMENT VALUES ('Software','6','111111100','1999-05-15');
INSERT INTO DEPARTMENT VALUES ('Hardware','7','444444400','1998-05-15');
INSERT INTO DEPARTMENT VALUES ('Sales','8','555555500','1997-01-01');

INSERT INTO EMPLOYEE VALUES ('Ahmed','B','Amr','666666600','1968-04-17','8794 Garfield, Chicago, IL','M','96000.00',NULL,'8' );
INSERT INTO EMPLOYEE VALUES ('Karim','C','Ahmed','333333300','1970-10-23','6677 Mills Ave, Sacramento, CA','M','79000.00',NULL,'6'); 
INSERT INTO EMPLOYEE VALUES ('Ramy','E','Gamal','888665555','1927-11-10','450 Stone, Houston, TX','M','55000.00',NULL,'1'); 
INSERT INTO EMPLOYEE VALUES ('Munir','D','Amr','444444400','1950-10-09','4333 Pillsbury, Milwaukee, WI','M','89000.00',NULL,'7'); 
INSERT INTO EMPLOYEE VALUES ('Sama','E','Khaled','222222200','1958-01-16','134 Pelham, Milwaukee, WI','M','92000.00',NULL,'7'); 
INSERT INTO EMPLOYEE VALUES ('Mohamed','D','Ali','111111100','1966-10-10','123 Peachtree, Atlanta, GA','M','85000.00',NULL,'6'); 
 

INSERT INTO DEPENDENT VALUES ('333445555','Aleya','F','1976-04-05','Daughter'); 
INSERT INTO DEPENDENT VALUES ('333445555','Ahmed','M','1973-10-25','Son'); 
INSERT INTO DEPENDENT VALUES ('333445555','Noha','F','1948-05-03','Spouse'); 
INSERT INTO DEPENDENT VALUES ('987654321','Adham','M','1932-02-29','Spouse'); 
INSERT INTO DEPENDENT VALUES ('123456789','Amr','M','1978-01-01','Son'); 
  

INSERT INTO DEPT_LOCATIONS VALUES ('1','Shebin'); 
INSERT INTO DEPT_LOCATIONS VALUES ('4','Menouf'); 
INSERT INTO DEPT_LOCATIONS VALUES ('5','Sadat city'); 
INSERT INTO DEPT_LOCATIONS VALUES ('5','Alx'); 
INSERT INTO DEPT_LOCATIONS VALUES ('5','Giza'); 
 

INSERT INTO PROJECT VALUES ('ProductX','1','Shebin','5'); 
INSERT INTO PROJECT VALUES ('ProductY','2','Sadat city','5'); 
INSERT INTO PROJECT VALUES ('ProductZ','3','Houston','5'); 
INSERT INTO PROJECT VALUES ('Computerization','10','Sadat city','4'); 
INSERT INTO PROJECT VALUES ('Reorganization','20','Menouf','1'); 
 

INSERT INTO WORKS_ON VALUES ('123456789','1','32.5'); 
INSERT INTO WORKS_ON VALUES ('123456789','2','7.5'); 
INSERT INTO WORKS_ON VALUES ('666884444','3','40.0'); 
INSERT INTO WORKS_ON VALUES ('453453453','1','20.0'); 
INSERT INTO WORKS_ON VALUES ('453453453','2','20.0'); 
INSERT INTO WORKS_ON VALUES ('333445555','2','10.0'); 
INSERT INTO WORKS_ON VALUES ('333445555','3','10.0'); 
INSERT INTO WORKS_ON VALUES ('333445555','10','10.0'); 
 


 -- Wroking on Company_SD Database
-------------------------------------

-- 1.Display all the employees Data.
SELECT * FROM EMPLOYEE;
-------------------------------------------------------------------------------------

-- 2.Display the employee First name, last name, Salary and Department number.
SELECT Fname,Lname,Salary,Dno FROM EMPLOYEE; 
-------------------------------------------------------------------------------------

-- 3.Display all the projects names, locations and the department which is responsible about it.
SELECT Pname,PNumber,Plocation,Dnum  FROM PROJECT;
-------------------------------------------------------------------------------------

-- 4.Display the employees Id, name who earns more than 1000 LE monthly.
SELECT ssn,  Fname ,salary FROM EMPLOYEE
WHERE Salary>=1000;
----------------------------------------------------------------------------

-- 5.Display the employees Id, name who earns more than 10000 LE annually.
SELECT ssn,  Fname ,salary FROM EMPLOYEE
WHERE Salary*12 >=10000;
----------------------------------------------------------------------------

-- 6.Display the names and salaries of the female employees 
SELECT  Fname, Salary FROM EMPLOYEE
WHERE sex LIKE 'F'; 
----------------------------------------------------------------------------

-- 7.Display each department id, name which managed by a manager with id equals 968574.
SELECT DNUMBER, DNAME FROM DEPARTMENT 
WHERE MGRSSN = 968574
----------------------------------------------------------------------------

--9.Dispaly the ids, names and locations of  the pojects which controled with department 10.
SELECT Pnumber,Pname,Plocation
FROM Project
WHERE Dnum=10
-------------------------------------------------------------------------------------

--10.Display the full data about all the dependence associated with the name of the employee they depend on him/her
SELECT d.*,e.Fname as [employee name]
FROM Dependent d,Employee e
where e.SSN=d.ESSN
--------------------------------------------------------------------------------------

--11.Display the Id, name and location of the projects in Cairo or Alex city.
SELECT Pnumber,Pname,Plocation
FROM PROJECT
WHERE plocation in('Alex','Cairo')
------------------------------------------------------------------------------------------

--12.Display the Projects full data of the projects with a name starts with "a" letter.
SELECT *
FROM Project p
WHERE p.Pname LIKE 'a%'
------------------------------------------------------------------------------------------

--13.display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT *
FROM Employee e
WHERE e.Dno=30 AND Salary BETWEEN 1000 AND 2000
------------------------------------------------------------------------------------------

--14.Retrieve the names of all employees in department 10 who works more than or equal 10 hours per week on "AL Rabwah" project.
SELECT e.Fname
FROM Employee e, Project p,WORKS_ON w
WHERE e.SSN=w.ESSn AND p.Pnumber=w.Pno AND e.Dno=10 AND w.Hours>= 10 AND p.Pname='AL Rabwah'
------------------------------------------------------------------------------------------

--15.Find the names of the employees who directly supervised with Samar Khaled
SELECT e.Fname
FROM Employee e , Employee s
WHERE s.Superssn =e.SSN AND s.Fname='Samar' AND s.Lname='Khaled'
------------------------------------------------------------------------------------------

--16.Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name
SELECT e.Fname , p.Pname
FROM Employee e , Project p,WORKS_ON w
WHERE e.SSN=w.essn and p.Pnumber=w.Pno
ORDER BY p.Pname 
---------------------------------------------------------------------------------------------

/*17.For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name 
,address and birthdate.*/
SELECT p.Pname,d.Dname,e.Lname as [Manger Lname],e.Address as [Manger Address],e.Bdate as [Manger Bdate]
FROM Project p ,Department as d , Employee e
WHERE p.Dnum=d.dnumber AND d.MGRSSN=e.SSN AND p.plocation='Cairo'
------------------------------------------------------------------------------------------

--18.Display All Data of the mangers
SELECT e.*
FROM Employee e ,Department as d
WHERE e.SSN=d.MGRSSN
------------------------------------------------------------------------------------------

--19.Display All Employees data and the data of their dependents even if they have no dependents
SELECT e.*,d.*
FROM Employee e LEFT OUTER JOIN Department d
ON e.SSN=d.mgrssn
------------------------------------------------------------------------------------------

--20.Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
INSERT INTO Employee 
VALUES('Abdelmoneim','D','Salah',105602,'1995-08-28','Helwan','M',3000,112233,4)
------------------------------------------------------------------------------------------

/*21.Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, 
but don’t enter any value for salary or manager number to him.*/
INSERT INTO Employee (Fname,Lname,SSN,Bdate,Address,Sex,Dno)
VALUES('Abdelrhamn','Adnan',105602,'1995-07-20','Giza','M',4)
------------------------------------------------------------------------------------------

--22.Upgrade your salary by 20 % of its last value.
UPDATE Employee
SET Salary=Salary+.2*Salary
WHERE SSN=102672
------------------------------------------------------------------------------------------