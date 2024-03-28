-- 02 KH실습과제
--1
select *
from job
;

--2
select job_name
from job
;

--3
select *
from department
;

--4
select emp_name, email, phone, hire_date
from employee
;

--5
select hire_date, emp_name, salary
from employee
;

--6
select emp_name, salary*12 "연봉", salary*(1+nvl(bonus,0))*12 "총수령액", salary*(1+nvl(bonus,0))*12-(salary*12*0.03) "실수령액"
from employee
;

--7
select emp_name, salary, hire_date, phone
from employee
where sal_level = 'S1'
;

--8
select emp_name, salary, salary*(1+nvl(bonus,0))*12-(salary*12*0.03) "실수령액", hire_date
from employee
where salary*(1+nvl(bonus,0))*12-(salary*12*0.03) > 50000000
;

--9
select *
from employee
where salary > 4000000 and job_code = 'J2'
;

--10
select emp_name, dept_code, hire_date
from employee
where dept_code in ('D9' , 'D5') and hire_date < to_date('20020101', 'yyyymmdd')
;

--11
select *
from employee
where hire_date between to_date('19900101', 'yyyymmdd') and to_date('20010101', 'yyyymmdd')
;

--12
select emp_name
from employee
where emp_name like '%연'
;

--13
select emp_name, phone
from employee
where phone not like '010%'
;

--14
select *
from employee
where email like '____#_%' escape '#' 
    and dept_code in ('D9', 'D6') 
    and hire_date between to_date('19900101', 'yyyymmdd') and to_date('20001201', 'yyyymmdd')
    and salary >= 2700000
;

--15
select emp_name, substr(emp_no, 1, 2) "생년", substr(emp_no, 3, 2) "생월", substr(emp_no, 5, 2) "생일"
from employee
;

--16
select emp_name, rpad(substr(emp_no, 1 , 7), 14 ,'*') 
from employee
;

--17 TODO
select emp_name, (months_between(sysdate, hire_date)) * 30
from employee
;


