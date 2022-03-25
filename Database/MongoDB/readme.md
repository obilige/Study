# 1. MongoDB
+ SQL과 차이 : MongoDB는 NoSQL
    * SQL : 정형화된 데이터(정해진 규격이 있는 데이터 형태), 관계형DB
    * NoSQL : Not Only SQL, SQL 말고 다른 것도 사용하자 // Non-Relational Operational Database SQL

+ NoSQL의 장점 :
    * 클라우드 컴퓨터 환경에 적합하다.
    * 유연한 데이터 모델이다.
    * Big-Data 처리에 효과적이다.

+ 데이터를 저장, 관리하는 방식
    * Document DataBase
    * JSON type : [{key:value}]로 

# 2. MongoDB 설치 및 시작
+ 설치
    * 터미널에서 아래 명령어 입력(맥북 기준)
    * brew tap mongodb/brew
    * brew install mongodb-community

+ MongoDB 서버 켜기, 끄기, 접속 명령어
    * brew services start mongodb-community
    * brew services stop mongodb-community
    * localhost:27017

# 3. CLI 기본명령어
+ MongoDB 서버 및 클라이언트 실행 :
    * mongod 서버프로그램 실행 : 터미널에서 ' mongo ' 입력 // 종료는 ' exit '
    * mongod 클라이언트 실행 : 

+ 데이터베이스 생성 : use 데이터베이스명
+ 데이터베이스 확인 : show dbs;
+ 데이터베이스 선택 : use local;
    * use 시 db가 없으면? 만들어진다. use test;
    * use test; 후에 show dbs; 하면 목록에 없는데? 실제로 작업을 하면 만들어진다. (합리적)

+ 컬렉션 생성 : db.createCollection('컬렉션명', '옵션');
    * db.createCollection('이름', {capped:<boolean>, autoIndexId:<boolean>, size:<number>, max:<number>})
        - capped : True(기본값 False)로 설정하면 capped collection이 활성화된다. size 항상 지정해줘야하며 capped collection이란 고정된 크기를 가진 컬렉션 // 메모리가 꽉 찰 때까지 저장할 수 있게 해주는 옵션
        - autoIndexId : True(기본값 False)로 설정하면 _id 필드에 index를 자동으로 생성해 1,2,3,4,5 들어가게 해준다. // _id 필드는 SQL primary key와 비슷한 개념으로 이해하면 된다.
        - size : 해당 컬렉션의 최대 크기를 지정(byte)
        - max : 컬렉션에 추가할 수 있는 최대 도큐먼트(로우) 개수 지정
+ 컬렉션 확인 : show collections;
+ 컬렉션 삭제 : db.컬렉션명.drop();
+ 데이터베이스 삭제 : db.dropDatabase()
