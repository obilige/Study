# SELECT A, B, C FROM datatable
# datatable에서 필드 A, B, C 가져와주세요!

### 1. Basic Form
SELECT ename, sal, deptno, job FROM emp;
# emp란 데이터테이블에서 ename, sal, deptno, job이란 필드(칼럼) 가져와주세요



### 2. Function
SELECT empno, ename, job, sal FROM emp WHERE sal >= 3000;
# WHERE : 조건을 다는 쿼리어
# emp란 데이터테이블에서 sal이 3000이상인 empno, ename, job, sal 필드 가져와주세요
# AND(교집합) / sal BETWEEN 1500 AND 3000(1500 <= sal <= 3000) / OR(합집합) / IN(3개 이상일 경우)
    # SELECT ename, deptno, job, sal FROM emp WHERE sal <= 2500 AND sal >= 1500;
    # SELECT ename, deptno, job, sal FROM emp WHERE sal BETWEEN 1500 AND 2500;
    # SELECT ename, deptno, job, sal FROM emp WHERE job = 'CLERK' OR job = 'SALESMAN' OR job = 'ANALYST';
    # SELECT ename, deptno, job, sal FROM emp WHERE job IN('CLERK', 'SALESMAN', 'ANALYST');

SELECT ename, deptno, job, sal FROM emp
WHERE sal BETWEEN 1500 AND 2500
ORDER BY sal DESC;
# ORDER BY : 정렬
# emp란 데이터테이블에서 sal이 1500 이상 2500 이하를 내림차순으로 해서 ename, deptno, job, sal 필드 가져와주세요
# DESC(내림차순, 큰 값부터) / ASC(오름차순, 작은 값부터)



### 3. 예제
#1. 1981년에 입사한 사람의 이름, 업무, 입사일자 조회
SELECT ename, job, hiredate FROM emp
                            WHERE hiredate BETWEEN '19810101' and '19811231';
SELECT ename, job, hiredate, FROM emp LIKE 1981%

#2. 사번이 7902, 7788, 7566인 사원의 이름, 업무, 급여, 입사일자 조회
SELECT empno, ename, job, sal, hiredate FROM emp
                                        WHERE empno IN('7902', '7788', '7566');
#3. 
SELECT ename, job, sal, deptno FROM emp
                               WHERE job != 'MANAGER'
                               or job != 'CLERK'
                               or job != 'ANALYST'; 

#4. 업무가 president 또는 salesman이고 급여가 1500인 직원의 이름, 급여, 업무, 부서번호 조회
SELECT ename, sal, job, deptno FROM emp
                               WHERE job IN('PRESIDENT','SALESMAN')
                               AND sal = 1500;
                                #곱, 나눔이 먼저인 것처럼 and or 연산도 and가 항상 먼저. 그래서 괄호로 묶어줘야한다.
                               #WHERE (job = 'president' OR job = 'salesman') AND sal = 1500;

#5. 가장 최근에 입사한 직원의 이름, 부서, 업무, 입사일자 조회
SELECT ename, deptno, job, hiredate FROM emp
                                    ORDER BY hiredate DESC;

#6. 같은 부서내에서 같은 업무를 하는 직원의 급여가 많은 순으로 조회
SELECT ename, deptno, job, sal FROM emp
                               ORDER BY deptno, job, sal DESC; 

#7. 커미션이 급여보다 10%이상 많은 직원의 급여가 많은 순으로 조회
SELECT ename, sal, comm FROM emp
                        WHERE comm >= sal*1.1
                        ORDER BY sal DESC;

#8. 이름에 L자가 2개 있고 30번 부서이거나 직속상사가 7782인 직원의 이름, 부서, 직속상사 조회
SELECT ename, deptno, mgr FROM emp
                          WHERE ename LIKE '%l%l%' and deptno = '30'
                          or mgr = 7782;