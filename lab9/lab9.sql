--1
create Procedure numOfStudent
as
Select d.Dept_Name,count(s.St_Id) studentnum from student s inner join Department d
on s.Dept_Id=d.Dept_Id
group by d.Dept_Name

exec numOfStudent

----------------------------------------------------
--2
create proc getEmployeesNum
as
declare @num int
select @num=count(Employee.SSN)
from Employee,Project,Works_for
where Employee.SSN=Works_for.ESSn and Works_for.Pno=Project.Pnumber and Project.Pname like 'p1'
if @num>=3
begin
select 'The number of employees in the project p1 is 3 or more'
end
else if @num<3
begin
select 'The following employees work for the project p1'
select Fname+' '+Lname
from Employee,Project,Works_for
where Employee.SSN=Works_for.ESSn and Works_for.Pno=Project.Pnumber and Project.Pname like 'p1'
end

getEmployeesNum

------------------------------------------------------
--3
create proc newEmlpoyee @old int ,@new int,@pname nvarchar(10)
as 
update Works_for 
  set ESSn=@new
  from Works_for w inner join  Project p
  on w.Pno=p.Pnumber and p.Pname=@pname
  where w.ESSn=@old 

  newEmlpoyee 1,2,'p1'

---------------------------------------------
--4
create table AuditTbl 
(
 proNum nvarchar(20),
 username nvarchar(100),
 modifieddate date,
 oldBudgat int,
 newBudgat int,
)

create trigger updateBudgate
on Project
after update
as
	if update(Budgate)
		begin
			declare @old int,@new int,@projNum varchar(200)
			select @old=Budgate from deleted
			select @new=Budgate from inserted
			select @projNum=Pnumber from inserted
			insert into AuditTbl
			values(@projNum,suser_name(),getdate(),@old,@new)
		end
update project
set Budgate =3000
where Project.Pnumber=100

select *from AuditTbl

----------------------------------------------------
--5
create trigger preventinsert
on department
instead of insert
as 
select 'that he can’t insert a new record in that table'

insert into Department(Dept_Id)  values (2312)
------------------------------------------------
--6
create trigger t4
on Employee
after insert
as
if(format(GETDATE(),'MMMM')) like 'march'
begin
rollback
select 'You can not insert to this table'
end

insert into Employee(SSN,Fname)
values(1250,'islam')
--------------------------------------------
--7
create table student_audit(
username nvarchar(100),
datest date,
userandkey nvarchar(300)
)

alter trigger t5
on Student
after insert
as
declare @id int = (select st_id from inserted)
insert into student_audit
values(SUSER_NAME(),getdate(),concat(SUSER_NAME() ,' Insert New Row with Key=',@id, 'in table student'))

insert into student (St_Id) values (13324)
------------------------------------------------
--8
create trigger t8
on student
instead of delete
as
declare @id int=(select st_id from deleted)
insert into student_audit
values(SUSER_NAME(),GETDATE(),'try to delete Row with Key='+@id)

-----------------------------------------------------
--9
select * from [HumanResources].[Employee]
for xml raw('Employee')

select * from [HumanResources].[Employee]
for xml raw('Employee'),ELEMENTS

--------------------------------------
--10
select d.Dept_Name,i.Ins_Name,i.Dept_Id 
	from Department d ,Instructor i
	where d.Dept_Id=i.Dept_Id
	for xml auto,elements

	select d.Dept_Name,i.Ins_Name,i.Dept_Id 
	from Department d ,Instructor i
	where d.Dept_Id=i.Dept_Id
	for xml path('ITIData')
---------------------------------------------------
--11
declare @docs xml =
				'<customers>
              <customer FirstName="Bob" Zipcode="91126">
                     <order ID="12221">Laptop</order>
              </customer>
              <customer FirstName="Judy" Zipcode="23235">
                     <order ID="12221">Workstation</order>
              </customer>
              <customer FirstName="Howard" Zipcode="20009">
                     <order ID="3331122">Laptop</order>
              </customer>
              <customer FirstName="Mary" Zipcode="12345">
                     <order ID="555555">Server</order>
              </customer>
           </customers>'

declare @hdocs int

Exec sp_xml_preparedocument @hdocs output, @docs

SELECT * 
FROM OPENXML (@hdocs, '//customer')  --levels  XPATH Code
WITH (FirstName varchar(10) '@FirstName',
	  Zipcode int '@Zipcode', 
	  OrderID int 'order/@ID',
	  orderName varchar(10) 'order'
	  )


Exec sp_xml_removedocument @hdocs

-------------------------------------------
--Bouns
--2
alter TRIGGER StopTableAltering ON DATABASE
FOR ALTER_TABLE
AS
select 'This database does not allow alter tables.'
ROLLBACK 
GO
alter table [dbo].[Department]
ADD ss varchar(255);



































