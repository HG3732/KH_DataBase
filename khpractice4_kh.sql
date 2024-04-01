--1
select emp_name, emp_no, d.dept_title, j.job_name
from employee e
    join department d on e.dept_code = d.dept_id
    join job j on e.job_code = j.job_code
where substr(emp_no, 1, 2) between 70 and 79
    and substr(emp_no, 8, 1) = 2
    and substr(emp_name, 1, 1) = '전'
;


--2 TODO
select emp_id , emp_name
    , case when (substr(emp_no, 1, 2)) < (substr(sysdate, 1, 2)) then (substr(sysdate, 1, 2) -substr(emp_no, 1, 2))
        when (substr(emp_no, 1, 2)) > (substr(sysdate, 1, 2)) then 100 - substr(emp_no, 1, 2) + (substr(sysdate, 1, 2))
    end as 나이
    ,d.dept_title, j.job_name
from employee e
    left join department d on e.dept_code = d.dept_id
    left join job j on e.job_code = j.job_code 
    where (substr(e.emp_no, 1, 2) in (select max(substr(emp_no, 1, 2)) from employee e1))
;

--3
select emp_id, emp_name, j.job_name
    from employee e
        left join job j on e.job_code = j.job_code
    where emp_name like '%형%'
    ;

--4
select emp_name, j.job_name, dept_code, d.dept_title
    from employee e
    left join department d on e.dept_code = d.dept_id
    left join job j on e.job_code = j.job_code
    where dept_code in ('D5', 'D6')
    order by dept_code desc
    ;

--5
select emp_name, bonus, d.dept_title, l.local_name
    from employee e
    left join department d on e.dept_code = d.dept_id
    left join job j on e.job_code = j.job_code
    left join location l on d.location_id = l.local_code
    where bonus is not null
    order by e.emp_id
;

--6
select emp_name, j.job_name, d.dept_title, l.local_name
    from employee e
    left join department d on e.dept_code = d.dept_id
    left join job j on e.job_code = j.job_code
    left join location l on d.location_id = l.local_code
    where dept_code is not null
    order by e.job_code
;

--7
select emp_name, d.dept_title, l.local_name, national_name
    from employee e
    left join department d on e.dept_code = d.dept_id
    left join job j on e.job_code = j.job_code
    left join location l on d.location_id = l.local_code
    left join national n using (national_code)
    where national_name in ('한국', '일본')
;

--8
select e1.emp_name, dept_code, e2.emp_name
from employee e1
join employee e2 using (dept_code)
where not e1.emp_name = e2.emp_name
order by e1.emp_name
;

--9
select emp_name, j.job_name, e.salary 급여
from employee e
join job j on e.job_code = j.job_code
where e.job_code in ('J4', 'J7')
    and NVL(bonus, 0) = 0
;

--10
select emp_id, emp_name, dept_title, job_name, hire_date, 순위
    from (select emp_id, emp_name, d.dept_title, j.job_name, hire_date,
        rank() over(order by salary*(1+nvl(bonus, 0))*12 desc) as 순위
        from employee e
        join department d on e.dept_code = d.dept_id
        join job j on e.job_code = j.job_code
        order by 순위)
        where 순위 between 1 and 5
;

--11.1
select d.dept_title, sum(salary) 부서별총합
    from employee e
    join department d on e.dept_code = d.dept_id
    group by dept_title
    having sum(salary) > (select sum(salary) from employee)*0.2
    order by 부서별총합 desc
    ;
    
--11.2
select dept_title, 부서별총합
from (select d.dept_title, sum(salary) 부서별총합
    from employee e
    join department d on e.dept_code = d.dept_id
    group by dept_title)
    where 부서별총합 > (select sum(salary) from employee)*0.2
    order by 부서별총합 desc
    ;

--11.3
with sum_sal as (select d.dept_title, sum(salary) 부서별총합
    from employee e
    join department d on e.dept_code = d.dept_id
    group by dept_title)
select dept_title , 부서별총합
from sum_sal
where 부서별총합 > (select sum(salary) from employee)*0.2
order by 부서별총합 desc
    ;
    
--12
select d.dept_title, sum(salary)
from employee e
left join department d on e.dept_code = d.dept_id
group by d.dept_title
;

--13.1 TODO
with calc_sal as (select avg(salary) 평균
from employee)
select 평균
from calc_sal

union

select sum(salary)
from employee;


--13.2
with calc_sal as (select avg(salary) 평균, sum(salary) 합
from employee)
select 합, 평균
from calc_sal;