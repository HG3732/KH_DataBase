--1
select student_name, student_address 
from tb_student
order by student_name
;

--2
select student_name, student_ssn
from tb_student
where absence_yn = 'Y'
order by student_ssn desc
;

--3
select student_name, student_no, student_address
from tb_student
where student_no not like 'A%'
        and (student_address like '경기도%'
            or student_address like '강원도%')
;

--4
select professor_name, professor_ssn
from tb_professor
join tb_department using(department_no)
where department_no = '005'
order by professor_ssn
;

--5
select student_no, point 
from tb_student
join tb_grade using (student_no)
where term_no = '200402'
    and class_no = 'C3118100'
order by point desc, student_no
;

--6
select student_no, student_name, department_name
from tb_student
join tb_department using (department_no)
order by student_name asc
;

--7
select class_name, department_name
from tb_department
join tb_class using (department_no)
;

--8 TODO - row 갯수 불일치
select class_name, professor_name
from tb_class
join tb_professor using (department_no)
;

--9
select class_name, professor_name
from tb_class
join tb_professor using (department_no)
join tb_department using (department_no)
where category in ('인문사회')
;

--10
select student_no, student_name, round(avg(point), 1) 
from tb_student
join tb_department using (department_no)
join tb_grade using (student_no)
where department_name = '음악학과'
group by student_no, student_name
order by student_no
;
 

select * from tb_student;
select * from tb_professor;
select * from tb_department;
select * from tb_grade;
select * from tb_class;
