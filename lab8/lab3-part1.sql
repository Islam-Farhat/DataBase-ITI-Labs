--1
create view passedStuds
as
select St_Fname+' '+St_Lname as Full_name,Course.Crs_Name,Grade
from Student,Course,Stud_Course
where Stud_Course.St_Id=Student.St_Id and 
Course.Crs_Id=Stud_Course.Crs_Id and 
Stud_Course.Grade>50

select * from passedStuds
-------------------------------------------
--2
alter view mgrTopics
with encryption 
as
select distinct i.Ins_Name,t.Top_Name from Instructor i inner join Department d 
on i.Ins_Id=d.Dept_Manager
inner join Ins_Course ic 
on i.Ins_Id=ic.Ins_Id
inner join Course c
on ic.Crs_Id=c.Crs_Id inner join Topic t
on c.Top_Id=t.Top_Id

select * from mgrTopics
-------------------------------------
--3
create view instructorDept
as
select Ins_Name as Full_name,Department.Dept_Name
from Instructor inner join Department
on Instructor.Ins_Id=Department.Dept_Manager and Department.Dept_Name in ('sd','java')

select * from instructorDept

--------------------------------------------------
--4
create view v1
as
select *
from Student
where Student.St_Address in ('alex','cairo')
with check option

select * from v1
------------------------------------------------
--5
create view projectInfo
as
select Project.Pname,count(Employee.SSN) as number_of_employees
from Project,Employee,Works_for
where Employee.SSN=Works_for.ESSn and Project.Pnumber=Works_for.Pno
group by Project.Pname

select * from projectInfo
--------------------------------------
--6
create clustered index myindex
on Department([Manager_hiredate])
--------------------------------------
--7
create unique index i2
on Student(st_age) 
-----------------------------------------
--8
create table Lastt
(
 Lid int,
 Lname varchar(20),
 Xval int
)

create table Dailyt
(
 did int,
 dname varchar(20),
 Yval int
)

merge into Lastt as T
using Dailyt as S 
on T.Lid=S.did

  when Matched then 
  update set T.Xval=S.Yval
  When  Not Matched then
     insert values(S.did,S.dname,S.Yval);
------------------------------------------------------








