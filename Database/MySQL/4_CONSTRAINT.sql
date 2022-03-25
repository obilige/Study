데이터 무결성 : 실체, 영역, 참조를 지켜야한다.
* 엔지니어나 개발자의 영역. 그러나, 작은 회사에선 데이터 분석가가 해야할 수도 있다. 그러니까 일단 알아둡시다.
* 분석이란 업무는 한정지을 수 없다. 요즘엔 파이썬, R 뿐 아니라 DB나 관련 플랫폼 hadoop에 대한 지식도 요구하는 경우 있다.

WHAT? 무엇을 지켜야하나?
    - 실체(Entity) 무결성 : 테이블 내 중복된 데이터 방지. 막아!
        * 똑같으면 구별할 수 없어. 관리가 매우 어려워져.
    - 영역(Domain) 무결성 : 범위 정해놓고 범위 외에 값을 막아주는 것
        * 도시 : 서울, 부산, 대구, 광주, 인천만 들어오게 만들 수 있다.
    - 참조(Reference) 무결성

HOW? 어떻게 지켜야하나? 제약(Constraint)
    - 실체 무결성 : Primary Key, Unique
    - 영역 무결성 : Check
    - 참조 무결성 : Foreign Key

    - COLUMN : 필드 속성을 알아야 필드에 맞는 무결성 지킴용 무기(제약, Constraint)를 지어줄 수 있다.
        * NN(NOT NULL) 속성 : 빈 값이 없어야하는 속성. Primary Key 쓸 땐  NOT NULL 속성 있어야 하기에 NN 속성을 지니게 된다.
        * ND(NO DUPLICATE) 속성 : 중복 X 속성. Primary Key가 대표적. Unique 사용해도 ND 속성을 지니게 된다.
        * NC(NO CHANGE) 속성 : 변경할 수 없는 속성. FOREIGN KEY 사용하면 변경이 불가능하게 된다.

    1) Primary Key
        * NN 속성과 ND 속성을 지니게 된다(중복 X, 빈 값 X). 하나의 테이블에 단 하나만 지정 가능.
        * 여러개의 필드를 묶어서 사용할 수 있다. (이름/나이/주소/혈액형/업무 이렇게 칼럼이 구성될 경우 하나로 Primary Key 불가. 그럴 땐 세개의 칼럼에 묶어서)
        * 예제 )
        CREATE TABLE tblexam(id int, name varchar(10));
        INSERT INTO tblexam(id) VALUES(1);
        INSERT INTO tblexam(name) VALUES('jeong');
        INSERT INTO tblexam(id) VALUES(1);
        '지금 테이블은 어떤 무기(제약, Constraint)도 없다. 중복, NULL 값 다 그냥 들어가. 이걸 막아야 한다.'
        DELETE FROM tblexam;

        * 기존 테이블에서 생성
        ALTER TABLE tblexam ADD CONSTRAINT pk_id PRIMARY KEY(id);
        NN 확인!
        INSERT INTO tblexam(name) VALUES('jeong');
        -> ERROR 1364 (HY000): Field 'id' doesnt have a default value
        ND 확인!
        INSERT INTO tblexam(id) VALUES(1);
        -> Query OK, 1 row affected (0.001 sec)
        INSERT INTO tblexam(id) VALUES(1);
        -> ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
        * 삭제
        ALTER TABLE tblexam DROP PRIMARY KEY(id);

        * 테이블 생성할 때 CONSTRAINT 먹이기
        권장 X) CREATE TABLE tbl_exam(id int PRIMARY KEY, name varchar(10));
        CREATE TABLE tbl_exam(id int, name varchar(10),
                              CONSTRAINT pk_id PRIMARY KEY(id));
        아래 코드를 권장하는 이유는 두 개의 필드 묶어서 PRIMARY KEY 주고 싶을 때 가능하기 때문. 위에껀 불가능




    2) Unique
        * PRIMARY KEY 이외 중복된 값이 들어가선 안되는 필드가 있을 경우
        * 다만, Null 값은 막을 수 없다.
        CREATE TABLE tblexam(id int PRIMARY KEY, name varchar(10) UNIQUE, phone varchar(20) UNIQUE, jumin varchar(29)); (X)
        CREATE TABLE tblexam(
            id int,
            name varchar(10),
            phone varchar(20),
            jumin varchar(29),
            CONSTRAINT pk_id PRIMARY KEY(id),
            CONSTRAINT uk_phone UNIQUE(phone),
            CONSTRAINT uk_jumin UNIQUE(jumin)
        );

        INSERT INTO tblexam(id, name, phone, jumin) VALUES(1, 'JEONG', '010-4810-8756', '900313-1119714');
        INSERT INTO tblexam(id, name, phone, jumin) VALUES(2, 'LEE', '010-2361-6980', '900313-1119714');
        # -> ERROR 1062 (23000): Duplicate entry '900313-1119714' for key 'uk_jumin'
        INSERT INTO tblexam(id, name, phone) VALUES(2, 'LEE', '010-2361-6980'); #Phone이라는 필드엔 NULL값이 들어간다.
        INSERT INTO tblexam(id, name, phone) VALUES(3, 'HWANG', '010-7777-9812'); #제품마다 다르다. MySQL에선 NULL값 중복 못막는다.


        * 에러없이 값 입력 자체를 막는 방법(제약 아님, 테이블 내 자체적 특성 부여에 가까움)
        NN : default #디폴트값을 준다. 따라서 절대 null값이 들어올 수 없게 된다.
        ND : auto_increment - 자동증발(1, 2, 3, 4 ...) ND+NN : 사용조건 = 정수형(int) / 안전장치로 Constraint 걸어둬야한다. 이건 표준 SQL 아니다.

        DROP TABLE tblexam;
        CREATE TABLE tblexam(
            id int auto_increment,
            name varchar(10) null,
            age int default 0,
            addr varchar(50) default '서울시 강남구',
            CONSTRAINT uk_id UNIQUE(id)
            );

            INSERT INTO tblexam(name) values ('JEONG');
            INSERT INTO tblexam(name, age) values('HWANG', '32');





    3) CHECK 지정한 값만 들어갈 수 있게 만드는 외부 제약
        CREATE TABLE tblexam(
            id int,
            name varchar(10) not null,
            gender char(1),
            age int,
            CONSTRAINT pk_id PRIMARY KEY(id),
            CONSTRAINT ck_gender CHECK(gender = 'M' OR gender = 'F'),
            CONSTRAINT ck_age CHECK(age >= 1 AND age <= 100)
            );

            DESC tblexam;
            INSERT INTO tblexam(id, name, gender, age) VALUES(1, 'HONG', 'A', 20);
            -> ERROR 4025 (23000): CONSTRAINT `ck_gender` failed for `testdb`.`tblexam`
            INSERT INTO tblexam(id, name, gender, age) VALUES(1, 'HONG', 'M', 20);
            INSERT INTO tblexam(id, name, gender, age) VALUES(2, 'KIM', 'F', 200);
            -> ERROR 4025 (23000): CONSTRAINT `ck_age` failed for `testdb`.`tblexam`
            INSERT INTO tblexam(id, name, gender, age) VALUES(2, 'KIM', 'F', 30);
            # varchar = 가변길이(글자길이에 맞춰 메모리 크기를 맞춰). char = 고정길이(처음부터 글자크기에 맞는 메모리를 맞춤)
    




    4) Foreign Key
        * 참조 무결성 : 연결된 다른 테이블에서 데이터가 옳은 데이터인지 아닌지 판단하는 것.
                        ex) emp 테이블 내 부서코드 50이 올바른 데이터인지 판단할 때 dept 테이블을 참조하는 것.
                            emp는 참조하는 테이블. dept는 참조받는 테이블.
                            emp는 자식테이블, dept는 부모테이블. # 참조키는 자식테이블에 달아줘야한다.

            CREATE TABLE tbldept(
                deptno int,
                dname varchar(10)
            );
            INSERT INTO tbldept(deptno, dname) VALUES(10, 'SALES');
            INSERT INTO tbldept(deptno, dname) VALUES(20, 'RESEARCH');

            CREATE TABLE tblemp(
                empno int,
                ename varchar(10),
                hiredate datetime,
                deptno int
            );
            INSERT INTO tblemp(empno, ename, hiredate, deptno) VALUES(1, 'HONG', now(), 50);
            UPDATE tblemp SET empno=1, ename='HONG', hiredate=now(), deptno=20 WHERE empno = 1
            # 이때 50은 PRIMARY, UNIQUE, CHECK 그 무엇으로도 막을 수 없다. 테이블 스스로 판단할 수 없기 때문.
            # 부모 테이블한테 물어보러 가야해. 'Foreign Key' 달아줘야해.
            # 참조할 때 부모테이블 필드엔 최소 프라이머리 키가 달려있어야한다. 그래야 믿고 참조할 수 있다.
            ALTER TABLE tbldept ADD CONSTRAINT pk_deptno PRIMARY KEY(deptno);
            ALTER TABLE tblemp ADD CONSTRAINT fk_deptno_deptno FOREIGN KEY(deptno) REFERENCES tbldept(deptno);
            INSERT INTO tblemp(empno, ename, hiredate, deptno) VALUES(2, 'JEONG', now(), 50);
            -> ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`testdb`.`tblemp`, CONSTRAINT `fk_deptno_deptno` FOREIGN KEY (`deptno`) REFERENCES `tbldept` (`deptno`))

            * NC 속성 : 현재 사례의 deptno는 참조가 된 상태. 그래서 부모 테이블의 참조 필드는 변경, 삭제되어선 안된다. 변경되면 자식 필드는 잘못된 값이 입력되게 될 가능성 생기는 것.
            -- NC 속성 테스트
            UPDATE tbldept SET deptno = 100 WHERE deptno = 20;
            -> ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`testdb`.`tblemp`, CONSTRAINT `fk_deptno_deptno` FOREIGN KEY (`deptno`) REFERENCES `tbldept` (`deptno`))
            UPDATE tbldept SET deptno = 100 WHERE deptno = 10;
               -> Query OK, 1 row affected (0.002 sec)
                  Rows matched: 1  Changed: 1  Warnings: 0
            # deptno 10번은 아직 참조가 안된 상태. 따라서 변경이 가능하다. 즉, Foreign Key 사용되어 부모 테이블로 만든 필드의 '값'만 NC속성을 가지게 된다.