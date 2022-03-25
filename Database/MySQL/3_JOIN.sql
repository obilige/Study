Join
여러 개의 테이블을 병합하여 하나의 결과를 도출하기 위한 방법
- 종류
    1) Cartesian Product Join(데카르트 곱 조인, CROSS 조인)
    2) Equi Join : 데카르트 조인에서 가져온 모든 내용 중 필요한 것만 추려내는 조인.
        - 공통 필드의 레코드를 가져오는 방법으로 작동.
        - 실무에서 가장 많이 쓰임. INNER JOIN : 중복을 제거하는게 주 기능
    3) OUTER JOIN : INNER JOIN + 공통되지 않은 레코드도 추출, 결합
        - LEFT OUTER JOIN : 왼쪽에 있는 테이블에서 조인하지 않은 값들을 가져옴
        - RIGHT OUTER JOIN : 오른쪽에 있는 테이블에서 조인하지 않은 값들을 가져옴
        - FULL OUTER JOIN : 둘 다. 그런데 MySQL에서 지원하지 않는다.
    4) Non Equi Join : 서로 공통되지 않는 필드의 레코드를 연결해 가져오는 것
    5) SELF JOIN : 자기 자신을 합치는? 이상한 조인. 똑같은 자신을 복제해 그 복제와 조인하는 ;
        - 데이터 설계가 잘못된 경우
        - 말이 안되는 것 같지만 필요할 때가 있음.
        - 같은 테이블이므로 반드시 별명을 지어 구분 시켜야함
    6) 집합연산자 : UNION(값 하나씩만), UNION ALL(값 모두), INTERSECT(교집합) 'MySQL에선 지원 X', EXCEPT(차집합) 'MySQL에선 지원 X'
        - 합집합은 각 테이블에서 먼저 연산해 결과를 도출하고 합함.
        - JOIN은 두 테이블을 먼저 합치고 연산해 결과를 도출.
    7) 다수 테이블 JOIN
        - * Join은 다수 가능. 다만, 4개 이상인 경우엔 설계 의심해봐야. 2개가 가장 일반적. 많으면 3개
        - 비표준문법이 조금 더 쉽습니다. 


CREATE TABLE tblc(id int null, value int null);

INSERT INTO tbla VALUES (1, 10);
INSERT INTO tbla VALUES (2, 20);
INSERT INTO tbla VALUES (3, 30);
INSERT INTO tbla VALUES (5, 50);
INSERT INTO tbla VALUES (7, 70);

INSERT INTO tblb VALUES (1, 10);
INSERT INTO tblb VALUES (2, 20);
INSERT INTO tblb VALUES (4, 40);
INSERT INTO tblb VALUES (5, 50);
INSERT INTO tblb VALUES (8, 80);

INSERT INTO tblc VALUES (1, 10);
INSERT INTO tblc VALUES (2, 20);
INSERT INTO tblc VALUES (7, 70);
INSERT INTO tblc VALUES (8, 80);
INSERT INTO tblc VALUES (9, 90);

 카르트시안 조인으로 tbla, tblb 조인하면 25개의 값이 생김. 5x5
 INNER 조인은 하나의 필드를 기준으로 세우고 그 필드에서 같은 값만 가져오는 것으로 tbla, tblb에서 1, 2, 5 가져옴.
    * 실무에서 95% 정도는 이 내부조인을 씀




===================================================================================




* INNER JOIN(KEY WORD is '공통')
SELECT tbla.id, tbla.value FROM tbla INNER JOIN tblb ON tbla.id = tblb.id; : 메모리에 두 개의 테이블이 올라갑니다. 그 중 서로 공통적인 것만
SELECT a.id, a.value FROM tbla a INNER JOIN tblb b ON a.id = b.id; 별명 붙일 땐 as 붙이기보다 한칸 띄우고 써준다. 에러가 가끔 발생.
SELECT a.id, a.value FROM tbla a, tblb b WHERE a.id = b.id; MySQL 문법. 표준문법은 아니다. 표준문법 쓰는게 좋으나, 코드 너무 복잡할 시엔 이거 사용 괜찮
    * SELECT 뒤에 id를 지정해줘야한다. 왜냐면 메모리에 id로 된 칼럼을 tbla와 tblb 둘 다 올렸기 때문. 
    * column ' ' in field list is ambigous 란 오류 뜨면 어떤 테이블의 칼럼인지 정확히 지정해줘야한다는 의미다.
    * ON : 조인에서 쓰는 조건. 공통, 기준을 세우기 위한 조건
    * 필드가 많고 테이블명이 길면 매번 테이블명 붙여주는게 너무 번거롭다. 그래서 별명을 붙여준다.
    * SELECT a.id, a.value FROM tbla a INNER JOIN tblb b ON a.id = b.id;
    * MySQL 문법 언어에서 조건문 안 넣어주면 다 가져온다. (SELECT a.id, a.value FROM tbla a, tblb b;)


예제)
직원의 사번, 이름, 업무, 부서번호, 부서명 조회
SELECT a.empno, a.ename, a.job, a.deptno, b.dname FROM emp a INNER JOIN dept b ON a.deptno = b.deptno;
    - 구별해줘야하는 필드는 두 테이블에 같이 있는 값만 해주면 됩니다.
    - 별명 지정해주면 별명으로만 써야합니다. 파이썬 import as와 같은 성질
    - SELECT empno, ename, job, a.deptno, dname FROM emp a INNER JOIN dept b ON a.deptno = b.deptno;

예제)
세일즈맨의 업무를 수행하는 직원의 사번, 이름, 업무, 부서번호, 부서명 조회
SELECT empno, ename, job, a.deptno, dname FROM emp a INNER JOIN dept b ON a.deptno = b.deptno WHERE job = 'salesman'; # 테이블 두개 조인한 다음 세일즈맨 먹여줄지
SELECT empno, ename, jon, a.deptno, dname FROM emp a INNER JOIN dept b ON a.deptno = b.deptno AND job = 'SALESMAN'; # 조인과 같은 단계에서 세일즈맨 먹여줄지



* OUTER JOIN(LEFT OUTER JOIN. RIGHT OUTER JOIN, FULL OUTER JOIN)
SELECT tbla.id, tbla.value FROM tbla LEFT OUTER JOIN tblb ON tbla.id = tblb.id; 'tbla에서 공통되지 않은 id 값의 레코드도 가져온다.'
SELECT tbla.id, tbla.value FROM tbla RIGHT OUTER JOIN tblb ON tbla.id = tblb.id; 'tblb에서 공통되지 않은 id 값의 레코드도 가져온다'
    -> NULL값이 나오는 이유는 SELECT를 tala의 id와 value로 했기 때문.
SELECT tblb.id, tblb.value FROM tbla RIGHT OUTER JOIN tblb ON tbla.id = tblb.id;

예제)
직원들의 이름, 급여, 부서명, 근무지를 조회하시오. 단, 부서명과 근무지는 모두 작성하시오.
SELECT ename, sal, dname, loc FROM dept a LEFT OUTER JOIN emp b ON a.deptno = b.deptno;


* NON EQUI JOIN
SELECT empno, ename, job, sal, grade FROM emp INNER JOIN salgrade ON emp.sal BETWEEN salgrade.LOSAL and salgrade.HISAL;



* SELF JOIN
예제)
직원의 사번, 이름, 업무, 관리자, 관리자의 이름을 조회
SELECT a.empno, a.ename, a.job, a.mgr, b.ename mgr_ename FROM emp a INNER JOIN emp b ON a.mgr = b.empno;
SELECT a.empno, a.ename, a.job, a.mgr, b.ename mgr_ename FROM emp a LEFT OUTER JOIN emp b ON a.mgr = b.empno;


* 집합연산
SELECT deptno FROM emp UNION ALL SELECT deptno FROM dept;
SELECT deptno FROM emp UNION SELECT deptno FROM dept;


* 3개 테이블 JOIN
SELECT tbla.id, tbla.value FROM tbla
INNER JOIN tblb ON tbla.id = tblb.id
INNER JOIN tblc ON tblb.id = tblc.id;

비표준 : SELECT tbla.id, tbla.value FROM tbla, tblb, tblc WHERE tbla.id = tblb.id AND tblb.id = tblc.id;