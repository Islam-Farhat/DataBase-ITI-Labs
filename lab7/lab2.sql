--1
create function getMonthName(@yourdate date)
returns varchar(10)
  begin
		 declare @x varchar(10)
		 SELECT @x= DATENAME(month,@yourdate)
		 return @x
  end

 select dbo.getMonthName(getdate())
 -------------------------------------------------
 --2

 alter function getValuesBetweenNums(@fNum int,@lNum int)
 returns @t table( num int)
 as
 begin
	 if(@fNum <= @lNum)
	 begin
			WHILE @fNum <= @lNum-1
			BEGIN
			set @fNum+=1;
			   insert into @t values(@fNum)
			END;
	 end

	 else
		 begin
		 WHILE @lNum <= @fNum-1
				BEGIN
				set @lNum+=1;
				   insert into @t values(@lNum)
				END;
		 end
		return
 end 

 select * from getValuesBetweenNums(20,30)
 -------------------------------------------
 --3
 create function getFullname(@st_id int)
returns table
	as
	return
	(
	 select St_Fname+' '+St_Lname as Full_name,Dept_Name
	 from Student,Department
	 where St_Id=@st_id and Student.Dept_Id=Department.Dept_Id 
	)

	select * from getFullname(10)

 --create function deptNameAndFullNameStudent(@stNo int)
 --returns table 
 --as
	-- return (
	-- select s.St_Id,St_Fname+' '+St_Lname,d.Dept_Name from Student s inner join Department d
	-- on d.Dept_Id=s.Dept_Id 
	-- where s.St_Id=@stNo
	-- )

--4

create function checkName(@stid int)
returns varchar(100)
  begin
  declare @fname varchar(20),@lname varchar(20),@message varchar(50)
  select @fname=s.St_Fname,@lname=s.St_Lname from Student s where s.St_Id=@stid

		 if(@fname is null and @lname is null)
		 set @message='First name & last name are null'

		 else if(@fname is null)
		  set @message='First name is null'

		  else if(@lname is null)
		  set @message='Last name is null'

		  else
		  set @message='First name & last name are not null'

          return @message
        end
select dbo.checkName(4)
--------------------------------------------
--5
create function getManagerInfo(@id int)
returns table
as
return(
select Dept_Name,Ins_Name,Manager_hiredate
from Department,Instructor
where Department.Dept_Manager=Instructor.Ins_Id and Ins_Id=@id
)

select * from getManagerInfo(2)
-----------------------------------------------------
--6
create function GetStudentsName(@format varchar(50))
returns @t table
			(
			 sname varchar(50)
			)
as
	begin
		if @format like 'first name'
			insert into @t
			select isnull(st_fname,'first name is not recorded') from Student
		else if @format like 'last name'
			insert into @t
			select isnull(st_Lname,'last name is not recorded') from Student
		else if @format like 'full name'
			insert into @t 
			select isnull(st_fname,'name is not recorded')+' '+isnull(st_lname,' ') from Student
		return 
	end

select * from GetStudentsName('full name')

-------------------------------------------------
--7
select SUBSTRING(st_fname,1,LEN(st_fname)-1) FROM Student;

------------------------------------------------
--8
delete from Stud_Course 
from Stud_Course sc inner join Student s 
on sc.St_Id=s.St_Id inner join Department d
on s.Dept_Id=d.Dept_Id 
where d.Dept_Name='SD'

create schema hr 
alter schema hr transfer dbo.student

