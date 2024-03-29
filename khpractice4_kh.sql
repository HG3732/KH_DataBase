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