#AGGREGATE FUNCTION
#avg(), sum(), min(), max(), count()

SELECT job, avg(sal), max(sal), min(sal), sum(sal) FROM emp WHERE job = 'SALESMAN';
#1. 불러올 전체 테이블(FROM) 2. 어떤 조건이 있는지, 필요한 데이터 뽑는 조건(WHERE, GROUP BY) 필요한 필드, 함수 설정
#count()는 null은 세지 않습니다. 그래서 null을 셀 것인지 안 셀 것인지 잘 봐야함.
#null이 포함된 count(comm)은 count(*)와 값이 다르다.


#OTHERS
#convert() : 형태변환해주는 함수. SELECT convert(150, CHAR) 숫자 150을 문자로
#case :
SELECT ename, job, comm,
CASE WHEN job = 'salesman' THEN '커미션 있음'
ELSE '커미션 없음'
END as '커미션 여부' 
FROM emp;
# -- 업무가 세일즈맨이면 '커미션 있음'으로 출력하고 그 외 업무는 '커미션 없음'이라고 출력

#직원들에게 줘야할 총급여(월급+커미션)을 구하시오. 
SELECT empno, ename, job, sal, comm, sal+comm as total FROM emp;
# null은 0이 아니라 값이 없는 것.그래서 연산이 안됩니다.
# null값을 0으로 바꿔줘야합니다.

#COALESCE(바꿀 필드, 바꿀 값) : null이라면 0으로 바꿔줘라.
SELECT empno, ename, job, sal, comm, (sal+coalesce(comm, 0)) AS total FROM emp;




1. 오늘부터 12월 25일까지 몇일이 남았는가?
SELECT DATEDIFF('2021-12-25', NOW());
2. 현재까지 근무한 직원들의 근무일수를 몇주 몇일로 조회.(단, 근무일수가 많은 사람 순으로 조회)
SELECT ename, DATEDIFF(NOW(), hiredate) as workdays FROM emp ORDER BY workdays DESC;
3. 10번 부서 직원들 중 현재까지의 근무월수를 계산해서 조회
SELECT ename, TIMESTAMPDIFF(month, hiredate, NOW()) as workmonth FROM emp WHERE deptno = 10;
4. 20번 부서 직원들 중 입사일자로부터 13개월이 지난 후의 날짜를 조회
SELECT empno, ename, DATE_ADD(hiredate, interval 13 month) as aft13 FROM emp;
5. 모든 직원에 대해 입사한 달의 근무일수를 조회
SELECT empno, ename, DATEDIFF(LAST_DAY(hiredate), hiredate) as stwork FROM emp;
6. 현재 급여에 15%가 증가된 급여를 계산하여 사번,이름, 급여, 증가된 급여를 조회(단, 급여는 반올림하여 적용한다.)
SELECT empno, ename, sal, ROUND(sal*1.15) as incsal FROM emp;
7. 이름, 입사일, 입사일로부터 현재까지의 월수, 급여,급여 총계를 조회
SELECT ename, hiredate, TIMESTAMPDIFF(month, hiredate, NOW()) as workmonth, sal, TIMESTAMPDIFF(month, hiredate, NOW()) * sal as sum_sal FROM emp;
8. 업무가 analyst이면 급여를 10%증가시키고 clerk이면 15%, manager이면 20%증가 시켜서 이름, 업무, 급여, 증가된 급여를 조회
SELECT ename, job, sal, CASE WHEN job='analyst' THEN sal*1.10 WHEN job='clerk' THEN sal*1.15 WHEN job='manager' THEN sal * 1.2 END as inc_sal FROM emp; 
9. 이름의 첫글자가 k보다 크고 y보다 작은 직원의 이름, 부서, 업무를 조회하시오.
SELECT ename, deptno, job FROM emp WHERE MID(ename, 1, 1) BETWEEN 'k' and 'y';
SELECT ename, deptno, job FROM emp WHERE MID(ename, 1, 1) > 'k' and MID(ename, 1, 1) < 'y';








SubQuery :
(1) 다른 쿼리문에 포함된 query문
(2) 서브쿼리는 반드시 괄호로 묶어서.
(3) 서브쿼리는 가능하면 연산자 오른쪽에 위치해야한다.
(4) 서브쿼리는 ORDER BY 사용불가.
(5) 반복적으로 조건 하에 결과물을 산출해야할 때 매우 유용.
(6) 연산자 = 단일행연산자(기본연산자), 다중행연산자(IN, ANY, ALL, EXISTS)
    - 기본연산자는 대응되는 값이 1:1
    - 다중행연산자 : IN은 =+or! ANY는 >, < >=, <= + or로 쓸 수 있음. ALL은 and+>, <, >=, <=
(7) 다중열 비교 (field1, field2) > (SELECT field1, field2) 동시에 두 값을 비교해야할 때. and는 안된다. 즉, 다수의 값을 비교하는데 그 구성이 완전히 똑같아야 하는 경우 사용
(8) 상관서브쿼리
    - 본문이 먼저 실행되고 서브쿼리가 이 후에 실행되며 서브쿼리의 결과값이 다시 본문 쿼리로 가서 마무리되는 명령어
    - 성능이 매우 떨어진다.
    - 그러나 특수한 경우엔 상관서브쿼리를 사용해야한다.
    - 서브쿼리만 실행했을 때 실행되면 일반서브쿼리! 상관서브쿼리는 본문 없이 실행되지 않는다.
--------------------------------------------------------------------------
scott보다 더 많은 급여를 받는 직원의 이름, 업무, 급여 조회
SELECT sal FROM emp WHERE ename = 'SCOTT'
SELECT ename, job, sal FROM emp WHERE sal > 3000
이 거 너무 불편해. 노가다. 한번에 처리할 수 있어야 해! 그리고 값이 변하기 때문에 매번 확인해야해.
서브쿼리문을 쓰면 값이 변하는 것에 관계없이 한번 설정한 코드로 스캇보다 더 많이 급여 받는 직원들 다 알 수 있다.

SELECT ename, job, sal FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename = 'SCOTT');

예제) 사번이 7521인 사원과 직무가 같고, 사번이 7934인 사원보다 임금이 많은 사원의 사번, 이름, 직무, 임금 조회하기
SELECT job FROM emp WHERE empno = 7521 #서브쿼리조건 먼저 정확히 정의하고
SELECT sal FROM emp WHERE empno = 7934
SELECT empno, ename, job, sal FROM emp WHERE job = (SELECT job FROM emp WHERE empno = 7521) AND sal > (SELECT sal FROM emp WHERE empno = 7934);
# 이후에 기본문에 서브쿼리를 적용해줍니다.

예제) 가장 최근에 입사한 직원의 이름, 부서, 업무, 입사일자
SELECT max(hiredate) FROM emp
SELECT ename, deptno, job, hiredate FROM emp WHERE hiredate = (SELECT max(hiredate) FROM emp);

업무별 최소급여를 받는 직원의 사번, 이름, 부서코드 조회
SELECT DISTINCT job FROM emp # 업무가 무엇이 있는지 파악부터
SELECT job, min(sal) FROM emp GROUP BY job;
SELECT empno, ename, deptno FROM emp WHERE sal IN(800, 3000, 2450,1250, 5000);
SELECT empno, ename, deptno, sal FROM emp WHERE sal IN (SELECT min(sal) FROM emp GROUP BY job);
# =은 안된다. sal = 은 값마다 계속 먹여줘야하기 때문. = 하려면 =800, =3000, =2450 ... 해야함

업무별 최소급여보다 많이 받는 직원의 사번, 이름 부서코드 조회
SELECT job, min(sal) FROM emp GROUP BY job;
SELECT empno, ename, deptno, sal FROM emp WHERE sal > ANY (SELECT min(sal) FROM emp GROUP BY job);

업무별 최대급여보다 많이 받는 직원의 사번, 이름, 부서코드 조회
SELECT max(sal) FROM emp GROUP BY job;
SELECT empno, ename, deptno, sal FROM emp WHERE sal > 800 and sal > 5000;
SELECT empno, ename, deptno, sal FROM emp WHERE sal > ALL (SELECT max(sal) FROM emp GROUP BY job);

MILLER 씨 급여와 보너스를 1500, 300으로 변경
SELECT sal, comm FROM emp WHERE ename = 'MILLER';
UPDATE emp SET sal=1500, comm=300 WHERE ename="MILLER"; #1300, NULL로 다시 바꿔주기


급여와 커미션이 30번 부서에 있는 직원들의 급여와 커미션이 다른 부서 직원에 대해 사번, 이름, 부서번호, 급여, 커미션 조회
SELECT deptno, sal, comm FROM emp WHERE deptno = 30;
SELECT sal, comm FROM emp WHERE sal IN (SELECT sal FROM emp WHERE deptno = 30) AND comm IN (SELECT comm FROM emp WHERE deptno = 30);

SELECT empno, ename, deptno, sal, comm FROM emp
WHERE sal IN (SELECT sal FROM emp WHERE deptno = 30)
AND
comm IN (SELECT comm FROM emp WHERE deptno = 30);

이게 문제가 되는 이유는 인터프리터 언어라 병렬 처리가 안되기 때문이다. 즉, 임금과 보너스를 동시에 비교할 수 없어 생기는 문제다. 
MILLER는 임금도 같은 사람이 있고, 보너스도 같은 사람이 있다. 다만 한명과 같지 않다.
완전히 똑같은 임금, 보너스 체계를 갖은 사람을 찾으려면 동시에 비교해야한다.
이 문제를 해결해주는 것이 다중렬비교방식이다.

SELECT empno, ename, deptno, sal, comm FROM emp
WHERE (sal, comm) IN (SELECT sal, comm FROM emp WHERE deptno = 30);

UPDATE emp SET sal=1300, comm=NULL WHERE ename="MILLER";

적어도 한명으로부터 보고를 받을 수 있는 직원의 사번, 이름, 업무, 부서 조회하기
SELECT empno, ename, job, deptno FROM emp e1 WHERE EXISTS(SELECT * FROM emp e2 WHERE e1.empno = e2.mgr);
구분하기 위해 e1, e2라고 테이블에 별명을 붙여준 것.

SELECT empno, ename, job, deptno FROM emp WHERE empno IN (SELECT DISTINCT mgr FROM emp);
#같은 값이 나오지만 DISTINCT 를 붙여주는게 성능상 훨씬 좋을 것. 비교할거면 같은 값이 있는 것은 줄여주는게 좋다. DISTINCT 하면 중복값은 지워진다.




1. Blake와 같은 부서에 있는 모든 직원의 사번, 이름, 입사일자 조회
SELECT empno, ename, hiredate, deptno FROM emp WHERE deptno = (SELECT deptno FROM EMP WHERE ename = 'Blake');
2. SELECT empno, ename, deptno, sal, comm FROM emp WHERE(sal,comm) IN (SELECT sal, comm FROM emp WHERE deptno=30);
SELECT empno, ename, deptno, sal, comm FROM emp WHERE(sal,COALESCE(comm, 0)) IN (SELECT sal, COALESCE(comm,0) FROM emp WHERE deptno=30);
3. 평균 급여 이상을 받는 직원들의  사번, 이름을 조회. 단, 급여가 많은 순으로 정렬
SELECT empno, ename FROM emp WHERE sal > ANY(SELECT avg(sal) FROM emp) ORDER BY sal DESC;
4. 이름에 T자가 들어가는 직원이 근무하는 부서에서 근무하는 직원의 사번,이름, 급여 조회
SELECT empno, ename, sal, deptno FROM emp WHERE deptno IN (SELECT DISTINCT deptno FROM emp WHERE ename LIKE '%T%');
5. 부서의 위치가 dallas인 모든 직원에 대해 사번, 이름, 급여, 업무조회
DESC dept;
SELECT * FROM dept;
SELECT empno, ename, sal, job FROM emp WHERE deptno = (SELECT DISTINCT deptno FROM dept WHERE loc = 'dallas');
6. 급여가 30번 부서의 최저급여보다 높은 직원의 사번, 이름, 급여 조회
SELECT empno, ename, sal FROM emp WHERE sal > (SELECT min(sal) FROM emp WHERE deptno = 30);