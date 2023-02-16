--1
declare c1 Cursor
for select salary
	from Employee
for update
declare @sal int
open c1
fetch c1 into @sal
while @@fetch_status=0
	begin
		if @sal>=3000
			update Employee
				set Salary=@sal*1.2
			where current of c1
		else
			update Employee
				set Salary=@sal*1.1
			where current of c1
		fetch c1 into @sal
	end
close c1
deallocate c1
------------------------------------------------------
--2

declare c2 Cursor
for select d.Dept_Name,i.Ins_Name from Department d inner join Instructor i 
on d.Dept_Manager=i.Ins_Id
for read only
declare @deptName varchar(20),@mgrName varchar(20)
open c2
fetch c2 into @deptName,@mgrName
while @@fetch_status=0
	begin
	    select @deptName,@mgrName
		fetch c2 into @deptName,@mgrName
	end
close c2
deallocate c2
-------------------------------------------
--3
declare c3 cursor
for select s.St_Fname from student s
where s.St_Fname is not null
for read only
declare @name varchar(10),@allnames varchar(300)
open c3
fetch c3 into @name
while @@fetch_status=0
	begin
	    set @allnames=concat(@allnames,',',@name)
		fetch c3 into @name
	end
	select @allnames
close c3
deallocate c3
-----------------------------------------------
--4
  --Backup

-----------------------------------------------
--5
--Export data to Excel

-------------------------------------------------
--6
--Generate  Script

--------------------------------------------
--7
drop 

CREATE SEQUENCE MySequence
START WITH 1
INCREMENT BY 1
NO CYCLE
drop SEQUENCE MySequence
create TABLE person1
(ID int,
FullName nvarchar(100) NOT NULL);

create TABLE person2
(ID int,
FullName nvarchar(100) NOT NULL);

drop table person2 
INSERT into person1
VALUES (NEXT VALUE FOR MySequence, 'islam')

INSERT into person2
VALUES (NEXT VALUE FOR MySequence, 'moo')


select * from person1
select * from person2





































