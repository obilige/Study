## DB & SQL?
+ Database
    - 데이터, 데이터테이블 저장
    - 여러 사람이 함께 사용할 목적으로 체계화하여 통합, 관리하는 데이터 집합체
+ SQL & NoSQL
    - 1. SQL : Structured Query Language
        * 구조화된 방법으로 데이터를 보관, 저장하고 조회하는 명령어
        * 관계형 데이터베이스를 관리하기 위해 개발된 특수한 프로그래밍언어
    - 2. NoSQL : Non-Relational Operational Database Structured Query Language
        * 비구조화된 데이터도 보관, 관리, 조회하는 명령어
        * 구조화해서 데이터를 보관, 관리하지 않아도 되서 더 유연하단 장점
        * 무작위로 데이터가 생성되는 클라우드 환경에서 빅데이터 처리에 더 유리하다.

## MariaDB, MySQL  접속하기
+ SQL server 구동
    - mysql.server start : 서버 구동
    - mysql.server stop : 서버 멈춤
    - mysql.server status : 서버 상태 확인
+ SQL에 접속
    - sudo mysql -u root -p
    - -u 뒤엔 SQL에 접속하기 위한 서버주소 입력, -p 뒤엔 비밀번호 입력
    - 사용자 컴퓨터 내 SQL에 접속할 땐 -u root로 접속
+ 데이터베이스 접근
    - 1. SHOW databases;
        * 접속한 SQL 내 데이터베이스 목록을 볼 수 있는 쿼리어
        * 쿼리어는 명령어 끝에 ;를 입력. 쿼리어 끝을 표기
    - 2. USE db;
        * 여러 데이터베이스 중 접근할 데이터베이스 선택하는 쿼리어
        * db는 임의로 입력한 데이터베이스 이름. SHOW databases; 명령어로 확인한 데이터베이스 중 하나를 db 대신 씀
        * 예) obilige란 db에 접근하려면? -> USE obilige;
    - 3. SHOW tables;
        * 접근한 DB 내 데이터테이블 목록을 볼 수 있는 쿼리어
    - 4. USE tablename;
        * 여러 데이터테이블 중 접근할 데이터테이블 선택하는 쿼리어
        * tablename은 임의로 입력한 데이터테이블 이름. SHOW tables; 명령어로 확인한 데이터베이스 중 하나를 tablename 대신 씀
        * 예) obilige란 데이터테이블에 접근하려면? -> USE obilige;
    - 5. DESC tablename;
        * 데이터테이블가 어떻게 구성되어있는지 보여주는 쿼리어
        * field, data type, Null, Key, Default, Extra

## Language
+ DML, DDL, DCL
    - 1. DML : Data Manipulation Language
        * SELECT : 데이터테이블 내 데이터 값을 조회하거나 검색하기 위한 명령어
        * INSERT, UPDATE, DELETE : 데이터테이블 내 데이터 값들에 변형을 주기 위한 명령어(데이터 삽입, 수정, 삭제)
    - 2. DDL : Data Definition Language
        * CREATE, ALTER, DROP, RENAME, TRUNCATE
        * 테이블과 같은 데이터 구조를 정의하는데 사용되는 명령어들로 (생성, 변경, 삭제, 이름변경) 데이터 구조와 관련된 명령어
    - 3. DCL : Data Control Language
        * GRANT, REVOKE
        * 데이터베이스에 접근하고 객체들을 사용하도록 권한을 주고 회수하는 명령어