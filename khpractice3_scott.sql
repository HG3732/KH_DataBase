select *
from emp;

select *
from salgrade;

--1
select e.*, s.grade
from emp e
   join salgrade s on (sal between s.losal and s.hisal)
   order by s.grade
 ;
 
 --2
 select e.*, s.grade
from emp e
   join salgrade s on (sal between s.losal and s.hisal)
   order by s.grade desc
 ;
 
 --3
 select s.grade, (avg(sal*12 + nvl(comm, 0)))
 from emp e
 join salgrade s on (sal between s.losal and s.hisal)
 where deptno in ('20', '30')
 group by s.grade
 order by 1 desc
 ;

--4 
select deptno, trunc(avg(sal*12 + nvl(comm, 0)))
from emp e
join salgrade s on (sal between s.losal and s.hisal)
where deptno in ('20', '30')
group by deptno
order by 1
;

--5
select e1.empno, e1.ename, e1.job, e1.mgr, e2.ename "MANAGER"
from emp e1
left join emp e2 on e1.mgr = e2.empno
order by 1
;

--6
select  e1.empno, e1.ename, e1.job, e1.mgr
    , (select e2.ename 
        from emp e2
        where e1.mgr = e2.empno) "MANAGER"
from emp e1
;

--7
select * 
from emp e1
where e1.sal > (select e2.sal from emp e2 where ename = 'MARTIN')
    and (e1.deptno = (select e3.deptno from emp e3 where ename = 'ALLEN') 
    or e1.deptno = '20')
;

--8
select e1.ename, e2.ename MANAGER
from emp e1
    join dept d on e1.deptno = d.deptno 
    join emp e2 on e1.mgr = e2.empno
    where e1.deptno = '20'
;

--9
select grade, ename
from emp e join salgrade s on e.sal between s.losal and s.hisal
where e.sal in (select min(sal) as minsal
    from emp e1
    join salgrade s on e1.sal between s.losal and s.hisal
    group by s.grade)
;

--10
select s.grade, min(sal) MIN_SAL, max(sal) MAX_SAL, round(avg(sal), 2) AVG_SAL
from emp e
    join salgrade s on e.sal between s.losal and s.hisal
    group by s.grade
;

--11
select grade, e.ename
from emp e
join salgrade s on e.sal between s.losal and s.hisal
where 
    e.sal between (select avg(sal)*0.9 from emp e1 join salgrade s1 on sal between losal and hisal where s.grade = s1.grade)
    and (select avg(sal)*1.1 from emp e2 join salgrade s2 on sal between losal and hisal where s.grade = s2.grade)
;

--12
select empno, ename, sal, decode(deptno, '10', sal*1.02 , '20' , sal*1.05 , '30', sal * 1.03, '40', sal*1.07) as salsubsidy
from emp
order by sal - salsubsidy;