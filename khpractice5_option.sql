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

--8
select class_name, professor_name
from tb_class
join tb_class_professor using (class_no)
join tb_professor using (professor_no)
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

--11
select department_name "학과이름", student_name "학생이름",  professor_name "지도교수이름"
from tb_student
join tb_department using (department_no)
join tb_professor on coach_professor_no = professor_no
where student_no in ('A313047')
;

--12
select distinct student_name, term_no
from tb_student
join tb_grade using (student_no)
join tb_class using (class_no)
where class_name = '인간관계론'
    and term_no like '2007%'                                                                                                                                                                                      
;

--13
select class_name, department_name
from tb_class
join tb_department using (department_no)
left join tb_class_professor using (class_no)
where category in ('예체능')
    and professor_no is null
;

--14
select student_name "학생이름", nvl(professor_name, '지도교수 미지정') "지도교수"
from tb_student
join tb_department using (department_no)
left join tb_professor on coach_professor_no = professor_no 
where department_name in ('서반아어학과')
;

--15
select student_no, student_name, department_name, 평점
from (select student_no, student_name, department_name, avg(point) "평점"
    from tb_student
    join tb_grade using (student_no)
    join tb_department using (department_no)
    where absence_yn in ('N')
        group by student_no, student_name, department_name)
        where 평점 >= 4
    order by student_no
;

--16
select class_no, class_name, round(avg(point), 8)
from tb_department
join tb_class using (department_no)
join tb_grade using (class_no)
where department_name in ('환경조경학과')
    and class_type in ('전공선택')
    group by class_no, class_name
order by 1
;

--17
select student_name, student_address
from tb_student
where department_no =
    (select department_no
    from tb_student
    where student_name in ('최경희'))
;

--18.1 subQuery
select student_no, student_name
from (
    select student_no, student_name, avg(point) "평점"
    from tb_department
    join tb_student using (department_no)
    join tb_grade using (student_no)
    where department_name in ('국어국문학과')
        group by student_no, student_name
        having avg(point) = (select max(avg(point))
                                from tb_department
                                join tb_student using (department_no)
                                join tb_grade using (student_no)
                                where department_name in ('국어국문학과')
                                    group by student_no))
;

--18.2 rank()
select student_no, student_name
from (
    select student_no, student_name, avg(point) "평점", rank() over(order by avg(point) desc) as 순위
    from tb_department
    join tb_student using (department_no)
    join tb_grade using (student_no)
    where department_name in ('국어국문학과')
        group by student_no, student_name
        order by avg(point) desc)
        where 순위 = '1'
        ;
        
--18.3 rownum
select student_no, student_name
from (
    select student_no, student_name, avg(point) "평점"
    from tb_department
    join tb_student using (department_no)
    join tb_grade using (student_no)
    where department_name in ('국어국문학과')
        group by student_no, student_name
        order by avg(point) desc)
    where rownum = 1
        ;


--19
select department_name "계열 학과명", round(avg(point), 1) "전공평점"
from tb_department
join tb_class using (department_no)
join tb_grade using (class_no)
where category = 
        (select category
        from tb_department
        where department_name in ('환경조경학과'))
group by department_name
order by department_name
;
