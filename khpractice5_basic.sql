-- Basic SELECT
--1.
select department_name, category
from tb_department
;

--2.
select department_name || '의 정원은' || capacity || '명 입니다'
from tb_department
;

--3.
select *
from tb_student
where department_no = '001' and student_ssn like '______-2%' and absence_yn = 'Y'
;

--4.
select student_name
from tb_student
where to_number(substr(student_no, 2, 6)) between 513078 and 513120
order by student_no desc;

--5
select department_name, category
from tb_department
where capacity between 20 and 30
;

--6
select professor_name
from tb_professor
where department_no is null
;

--7
select *
from tb_student
where department_no is null
;

--8
select class_no
from tb_class
where preattending_class_no is not null
;

--9
select distinct category
from tb_department
order by 1
;

--10
select student_no, student_name, student_ssn
from tb_student
where substr(entrance_date, 1, 2) = 02
    and student_address like '%전주%'
    and absence_yn = 'N'
    order by student_name
;

select * from tb_student;