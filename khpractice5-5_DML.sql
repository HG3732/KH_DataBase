--1
insert into tb_class_type
values (01, '전공필수');
insert into tb_class_type
values (02, '전공선택');
insert into tb_class_type
values (03, '교양필수');
insert into tb_class_type
values (04, '교양선택');
insert into tb_class_type
values (05, '논문지도');

--2.1
create table TB_학생일반정보 ("학번" varchar2(10), "학생이름" varchar2(40), "주소" varchar2(200));
insert All into TB_학생일반정보
values(학번, 학생이름, 주소)
select student_no "학번", student_name "학생이름", student_address "주소"
    from tb_student
    ;

--2.2 subQuery
create table TB_학생일반정보
as (select student_no, student_name, student_address
    from tb_student);

--3.1
create table TB_국어국문학과 ("학번" varchar2(10), "학생이름" varchar2(40), "출생년도" number(4), "교수이름" varchar2(40));
insert All into TB_국어국문학과
values(학번, 학생이름, 출생년도, 교수이름)
select student_no "학번", student_name "학생이름", to_char(to_date(substr(student_ssn, 1, 2), 'rr'), 'yyyy') "출생년도", professor_name "교수이름"
    from tb_student s
    join tb_professor p on s.coach_professor_no = p.professor_no
    where s.department_no in (select d.department_no
                            from tb_department d
                            where d.department_name = '국어국문학과')
;

--3.2
create table TB_국어국문학과
as (select student_no "학번", student_name "학생이름", to_char(to_date(substr(student_ssn, 1, 2), 'rr'), 'yyyy') "출생년도", professor_name "교수이름"
    from tb_student s
    join tb_professor p on s.coach_professor_no = p.professor_no
    where s.department_no in (select d.department_no
                            from tb_department d
                            where d.department_name = '국어국문학과'))
;

--4
update tb_department d1
set capacity = round(1.1*(select capacity
                from tb_department d2
                where d1.department_no = d2.department_no ), 0)
;

--5
update (select * from tb_학생일반정보 where student_no in ('A413042'))
set student_address = '서울시 종로구 숭인동 181-21'
;

--6
update tb_student s1
set student_ssn = (select substr(student_ssn,1,6) from tb_student s2
                    where s1.student_no = s2.student_no)
;

--7
update (select point
    from tb_student s
    join tb_grade g using (student_no)
    where student_name in ('김명훈')
        and s.department_no = (select d.department_no 
                                from tb_department d
                                where department_name in ('의학과'))
        and g.class_no = (select c.class_no
                            from tb_class c
                            where class_name in ('피부생리학'))
        and term_no in ('200501'))
set point
    = 3.5
;

--8
delete tb_grade
where student_no in (select student_no
                    from tb_student
                    where absence_yn in 'Y')
;
