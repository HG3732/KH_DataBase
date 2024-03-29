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

--17
select emp_name
    , trunc(sysdate-hire_date) "근무일수1"
    , abs(trunc(hire_date-sysdate)) "근무일수2"
from employee
;

--18
select *
from employee
where mod(emp_id, 2) = 1
;

--19
select *
from employee
where extract(year from hire_date) < (extract(year from sysdate) - 20)
    or (extract(year from hire_date) = (extract(year from sysdate) - 20) and extract(year from hire_date) < extract(month from sysdate))
    or (extract(year from hire_date) = (extract(year from sysdate) - 20) and extract(year from hire_date) < extract(month from sysdate)
        and (extract(day from hire_date)) < (extract(day from sysdate)))
;

select concat(extract(year from hire_date), extract(year from hire_date))
from dual;

--20
select emp_name, to_char(salary, 'l999,999,999')
from employee
;


select trunc(months_between(to_date(substr(emp_no, 1, 6), 'yymmdd'), sysdate)/12) "만나이"
from employee
where emp_id not in ('214', '200', '201')
;

select *
from employee
;

--21
select emp_name, dept_code, concat(concat(concat(substr(emp_no, 1, 2), '년') , concat(substr(emp_no, 3, 2), '월')) , concat(substr(emp_no, 5, 2), '일')) "생년월일"
    ,trunc((months_between(sysdate, to_date(substr(emp_no, 1, 6), 'rrmmdd')))/12) "만나이"
from employee
where emp_id not in ('214', '200', '201')
;

--22
select emp_id, emp_name, dept_code, 
    case when dept_code = 'D5' then '총무부'
        when dept_code = 'D6' then '기획부'
        when dept_code = 'D9' then '영업부'
        end 부서
from employee
where dept_code in ('D5', 'D6', 'D9')
order by dept_code
;

--23
select emp_name, substr(emp_no, 1, 6) "앞자리", substr(emp_no, 8, 7) "뒷자리", substr(emp_no, 1, 6) + substr(emp_no, 8, 7) "합"
from employee
where emp_id = 201
;

--24
select sum(salary*(1+nvl(bonus,0))*12)
from employee
where dept_code = 'D5'
;

--25
select distinct (select count(*) from employee) "전체 직원수", 
    (select count(*) from employee where substr(hire_date, 1, 2) = 01) "2001년",
    (select count(*) from employee where substr(hire_date, 1, 2) = 02) "2002년",
    (select count(*) from employee where substr(hire_date, 1, 2) = 03) "2003년",
    (select count(*) from employee where substr(hire_date, 1, 2) = 04) "2004년"
from employee
;

select count(*) "전체 직원수"
    , count(decode(substr(hire_date, 1, 2), '01', '01년')) "2001년"
    , count(decode(substr(hire_date, 1, 2), '02', '02년')) "2002년"
    , count(decode(substr(hire_date, 1, 2), '03', '03년')) "2003년"
    , count(decode(substr(hire_date, 1, 2), '04', '04년')) "2004년"
from employee
;
