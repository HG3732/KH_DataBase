--1
select student_no 학번, student_name 이름, to_char(entrance_date, 'yyyy-mm-dd') 입학년도
from tb_student
where department_no = 02
order by 2;

--2
select professor_name, professor_ssn
from tb_professor
where not lengthb(professor_name) = 9
;

--3
select professor_name, (100 - substr(professor_ssn, 1, 2) + substr(sysdate, 1, 2)) 나이
from tb_professor
where substr(professor_ssn, 8, 1) = 1
order by 나이
;

--4
select substr(professor_name, 2, 2) 이름
from tb_professor;

--5 
select student_no, student_name
from tb_student
where (extract(year from entrance_date) - (1900 + substr(student_ssn, 1, 2))) > 19
order by student_ssn desc
;

--6
select to_char(to_date('20201225', 'yyyymmdd'), 'dy')
from dual;

--7
select to_char(to_date('99/10/11', 'yy/mm/dd'), 'yyyymmdd') yy1
        ,to_char(to_date('49/10/11', 'yy/mm/dd'), 'yyyymmdd') yy2
        ,to_char(to_date('99/10/11', 'rr/mm/dd'), 'yyyymmdd') rr1
        ,to_char(to_date('49/10/11', 'rr/mm/dd'), 'yyyymmdd') rr2
from dual;

--8
select student_no, student_name
from tb_student
where student_no not like 'A%'
;

--9
select round(avg(point), 1)
from tb_student
join tb_grade using (student_no)
where student_no = 'A517178'
;

--10
select department_no "학과번호", count(*) "학생수(명)"
from tb_student
group by department_no
order by department_no
;

--11
select count(*) 
from tb_student
where coach_professor_no is null
;

--12
select substr(term_no, 1, 4) "년도", round(avg(point), 1) "년도 별 평점"
from tb_student
join tb_grade using (student_no)
where student_no = 'A112113'
group by substr(term_no, 1, 4)
;

--13
select department_no "학과코드명", count(case when absence_yn in ('Y') then 1 else null end) "휴학생 수"
from tb_student
group by department_no
order by department_no
;

--14
select student_name "동일이름", count(student_name) "동명인 수"
from tb_student
group by student_name
having count(student_name) > 1
order by student_name
;

--15
select substr(term_no, 1, 4) "년도", substr(term_no, 5, 2) "학기", round(avg(point), 1)
from tb_student
join tb_grade using (student_no)
where student_no = 'A112113'
group by rollup(substr(term_no, 1, 4), substr(term_no, 5, 2))
order by substr(term_no, 1, 4)
;
