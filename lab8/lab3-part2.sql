--1
create view v_clerk
as 
select w.EmpNo,w.ProjectNo,w.Enter_Date from Works_On w
where w.Job='Clerk'

select * from v_clerk

-----------------------------------------
--2
create view v_without_budget
as 
select p.ProjectName,p.ProjectNo  from [Company].[Project] p
where Budget is null

select * from v_without_budget
--------------------------------------
--3
create view v_count
as 
select p.ProjectName,count(*) as CountJobs from [Company].[Project] p inner join [dbo].[Works_On] w
on p.ProjectNo=w.ProjectNo
group by p.ProjectName

select * from v_count

-------------------------------------
--4
create view v_project_p2
as
select * from v_clerk where ProjectNo='p2'

select * from v_project_p2
----------------------------------------
--5
alter view v_without_budget
as 
select p.ProjectName,p.ProjectNo  from [Company].[Project] p
where p.ProjectNo ='p1'or p.ProjectNo ='p2'

select * from v_without_budget

--------------------------------
--6
drop view v_count
drop view v_clerk

-----------------------------------
--7
create view showemp
as 
select * from [Human_Resource].[Employee] e
where e.DeptNo='d2'
select * from showemp
-------------------------------
--8
create view containJ
as
select * from showemp 
where EmpLname like '%J%'

select * from containJ
---------------------------------------
--9
create view v_dept
as 
select d.DeptName,d.DeptNo from [Company].[Department] d

select * from v_dept
---------------------------------------------
--10
insert into v_dept values('‘Development’','d4')

---------------------------------------------
--11
create view v_2006_check
as 
select e.EmpNo,p.ProjectNo from [Human_Resource].[Employee] e
inner join [dbo].[Works_On] w
 on e.EmpNo=w.EmpNo inner join [Company].[Project] p
 on w.ProjectNo=p.ProjectNo
 where w.Enter_Date between '2006-01-01' and '2006-12-31'


select * from v_2006_check
