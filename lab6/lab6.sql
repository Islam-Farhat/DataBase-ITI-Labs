create rule rule1 as @xvar in ('NY', 'DS', 'KW')
create default def1 as 'NY'
sp_addtype newDataType ,'nchar(2)'

sp_bindrule rule1 , newDataType
sp_bindefault def1 , newDataType

create table Department(
DeptNo int primary key,
DeptName nvarchar(10),
Location newDataType
)

insert into Department (DeptNo,DeptName) values(1,'Markiting')
insert into Department values(2,'Markiting','KW')
select * from Department
-----------------------------------------
create table Employee(
EmpNo int primary key,
Emp_Fname nvarchar(10) not null,
Emp_Lname nvarchar(10) not null,
Salary float,
DeptNo int FOREIGN KEY REFERENCES Department(DeptNo)

constraint constrain1 unique (Salary)
)
create rule rule2 as @xvar >6000
sp_bindrule rule2 , 'Employee.Salary'

insert into Employee values(11111,'SA','Mooo',7000,2)
----------------------------------------
------Testing Referential Integrity---

insert into Employee values(10102 ,'ADBALLH','Mooo',7100,2)
insert into Work_On values(11111,1,'clerk',getdate())

update Employee set EmpNo=22222 
where EmpNo=10102

delete Employee where EmpNo = 10102

----Table modification------
ALTER TABLE Employee
ADD Phone varchar(15);

ALTER TABLE Employee
drop column Phone;
----------------------------------------------
--2
create schema Company 
alter schema Company transfer HumanResource.project

create schema HumanResource 

alter schema HumanResource transfer Employee
--------------------------------------------
--3
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='Employee'

-------------------------------------
--4
create synonym Emp for [HumanResource ].[Employee]

Select * from Employee  --XXX
Select * from [HumanResource].Employee
Select * from Emp
Select * from [HumanResource].Emp  --XXX
------------------------------------------
--5
update [Company].[Project]
set Budget=Budget+.1*budget
from [Company].[Project] p
inner join [dbo].[Work_On] w
on w.Emp_No=10102


----------------------------------
--6

update [Company].[Department]
set DeptName='Sales'
from [Company].[Department] d
inner join [HumanResource ].[Employee] e on d.DeptNo=e.DeptNo
where e.Emp_Fname='James'

-----------------------------------
--7

update [dbo].[Work_On] 
set Enter_Date = '12.12.2007'
from [dbo].[Work_On] w inner join [HumanResource ].[Employee] e
on w.Emp_No=e.EmpNo
inner join [Company].[Department] d
on e.DeptNo=d.DeptNo 
where d.DeptName='Sales'

------------------------------------
--8
delete [dbo].[Work_On] 
from [dbo].[Work_On] w inner join [HumanResource ].[Employee] e
on w.Emp_No=e.EmpNo
inner join [Company].[Department] d
on e.DeptNo=d.DeptNo 
where d.Location='KW'
-----------------------------------












