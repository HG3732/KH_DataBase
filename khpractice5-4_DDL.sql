--1
create table TB_CATEGORY (name varchar2(10), use_yn char(1) default 'Y');

--2
create table TB_CLASS_TYPE (no varchar2(5) primary key, name varchar2(10));

--3
alter table tb_category
add constraint name_pk primary key(name);

--4
alter table tb_category
modify name not null;

--5
alter table tb_class_type
modify no varchar2(10);

alter table tb_category
modify name varchar2(20);

alter table tb_class_type
modify name varchar2(20);

--6
alter table tb_class_type
rename column no to class_type_no;

alter table tb_category
rename column name to category_name;

--7
alter table tb_class_type
rename column class_type_no to PK_class_type_no;

alter table tb_category
rename column category_name to PK_category_name;

--8
insert into tb_category values('공학', 'Y');
insert into tb_category values('자연과학', 'Y');
insert into tb_category values('의학', 'Y');
insert into tb_category values('예체능', 'Y');
insert into tb_category values('인문사회', 'Y');
commit;

--9
alter table tb_department
add foreign key (category) references tb_category(PK_category_name);

alter table tb_department
rename column category to FK_daprtment_category;

--10
create view VW_학생일반정보
as select student_no, student_name, student_address from tb_student;

--11
create view VW_지도면담
as 
select department_name, student_name, professor_name
from tb_student s
join tb_professor p on coach_professor_no = professor_no
join tb_department d on s.department_no = d.department_no
order by department_name
;

--12
create view VW_학과별학생수
as
select department_name, count(student_no) "student_count"
from tb_student s
join tb_department d using(department_no)
group by department_name
;

--13
update VW_학생일반정보
set student_name = '김효겸'
where student_no = 'A213046'
;

--14
create view VW_학생일반정보_read_only
as select student_no, student_name, student_address from tb_student
with read only;

--14.1
CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "CHOON"."VW_학생일반정보" ("STUDENT_NO", "STUDENT_NAME", "STUDENT_ADDRESS") AS 
  select student_no, student_name, student_address from tb_student
  with read only;

--15
select class_no "과목번호", class_name "과목이름", "누적수강생수(명)"
from(
select class_no, class_name, count(student_no) "누적수강생수(명)", rank() over(order by count(student_no) desc) as "순위"
from tb_class c 
join tb_grade g using (class_no)
where substr(term_no, 1, 4) < 2008
    and substr(term_no, 1, 4) > 2004
group by class_no, class_name
order by 순위)
where 순위 < 4
;
