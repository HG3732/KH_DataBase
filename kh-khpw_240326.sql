select *
from employee
-- dept_code = 속성명, d5 = 속성값
where dept_code = 'D5';

select emp_name, emp_id, job_code, hire_date
from employee
-- dept_code = 속성명, d5 = 속성값
where dept_code = 'D5';

select *
from employee
-- dept_code = 속성명, d5 = 속성값
where emp_id = '200';

select emp_name, salary*12, salary*(bonus+1)
from employee;

select emp_name as 이름, salary*12 "연봉(원)", salary*(bonus+1) "총 소득(원)"
from employee
;

select emp_id, salary/10000, '만원' as 원
from employee;

--중복 제거
select distinct job_code
from employee;

select emp_name, salary/10000
from employee
where salary/10000 > 400;

select emp_name, dept_code, salary/10000
from employee
where dept_code = 'D6' and salary/10000 < 400;

select emp_id || emp_name || salary
from employee;

select emp_name || '님의 월급은' || salary || '원 입니다.'
from employee;

select emp_name, salary*12 "연봉(원)", salary*(bonus+1) "총 소득(원)"
from employee
where ent_date is not null
;


select emp_name, emp_no
from employee
where emp_no like '6%'
;

select emp_name, phone
from employee
where phone like '___7%'
;

select emp_name, email
from employee
where email like '__#_%' escape '#'
;

select emp_name
from employee
where emp_name not like '이%'
;

select *
from employee
where manager_id is null and dept_code is null
;

select emp_name, dept_code
from employee
where dept_code in ('D8', 'D6')
;

--비추, 통신요금만 더나간다
select emp_name, salary, salary || '원' as ex1
from employee;

--부서코드가 ‘D9’인 직원의 이름, 부서코드 조회
select emp_name, dept_code
from employee
where dept_code = 'D9'
;

--급여가 4000000보다 많은 직원 이름과 급여 조회
select emp_name, salary
from employee
where salary > 4000000;

--부서코드가 ‘D6’이고 급여를 2000000보다 많이 받는 직원의
--이름, 부서코드, 급여 조회
select emp_name, dept_code, salary
from employee
where dept_code = 'D6' and salary > 2000000
;

--부서코드가 ‘D6’이거나 급여를 2000000보다 많이 받는 직원의
--이름, 부서코드, 급여 조회
select emp_name, dept_code, salary
from employee
where dept_code = 'D6' or salary > 2000000
;

select emp_name, length(emp_name), email, length(email)
from employee
;

select emp_name, lengthb(emp_name), email, lengthb(email)
from employee
;

select phone, instr(phone, '0', -1, 1)
from employee
;

select lpad(email, 18, '#')
from employee
;

select rpad(email, 18, '#')
from employee
;

select emp_name, ltrim(phone, '010'), rtrim(email, '@KH.or.kr')
from employee
;

select trim('Z' from 'ZZKHZZKHZZ')
from dual;

select substr('SHOWMETHEMONEY', 5, 2)
from dual;

select substr('SHOWMETHEMONEY', -10, 2)
from dual;

select lower('Six Times')
from dual;

select upper('Six Times')
from dual;

select concat(sysdate, '전국노래자랑')
from dual;

select '전국' || '노래자랑'
from dual;

select replace('저는 제 아내를 저장하지 못했습니다.', '저장', '구')
from dual;

select abs(-56)
from dual;

select mod(324, 17)
from dual;

select round(52.48257271, 5)
from dual;

select floor(52.48257271)
from dual;

select trunc(52.48257271, 4)
from dual;


select ceil(52.48257271)
from dual;

select sysdate
from dual;

select months_between('18/01/15', '23/05/23')
from dual;

select add_months(sysdate, 500)
from dual;

select next_day(sysdate, '월')
from dual;

select last_day(sysdate)
from dual;

select extract(year from sysdate)
from dual;

select to_char(sysdate, 'yyyymmdd')
from dual;

--시, 분, 초까지 반환
select systimestamp
from dual;

--oracle이 만든 임의의 테이블
select *
from dual;

select sysdate
from employee;

select extract(month from sysdate)
from dual;

select emp_name, hire_date, months_between(sysdate, hire_date)
from employee;

select sysdate, to_char(sysdate, 'yyyy"년"mm"월"dd"일" day am hh"시"mi"분"ss"초" ')
from dual;

select to_date('20240522', 'yyyymmdd') c1
,sysdate c2
, months_between(sysdate, to_date('20240522', 'yyyymmdd')) c3
, extract (day from to_date('20240523', 'yyyymmdd')) c4
from dual;