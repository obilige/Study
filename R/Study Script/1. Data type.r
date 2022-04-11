배열
1) 같은 형식끼리 묶어준다.
2) 크기가 정해져있다.
3) 삽입, 삭제가 매우 불편하다. 사실상 거의 불가능하다.
4) 성능에서 엄청난 차이가 난다. 그래서 배열 사용 가능하면 배열로


스칼라(0차원)
- 숫자, 문자열, Boolean, Factor, 결측치(Na, NaN, Null, inf)

벡터(1차원)
- 기본 데이터 타입. 파이썬의 리스트와 같은 개념.

매트릭스(2차원)
- 행렬형태. 배열이다. 성능 좋지만 쓰기 불편

DataFrame(2차원)
- 행렬형태지만 배열이 아니다. 쓰기 편하지만 성능상 불리

Array(3차원)
- 배열인 것

list(3차원 이상)
- 배열이 아닌 것


========================================================

is.type(name) -> 데이터타입이 맞는지 아닌지 확인하는 함수
as.type(name) -> 데이터타입을 type로 바꿔주는 함수


Vector
*refer
: 범주형 데이터
: 문자 vs 숫자(단순히 형태가 아니라 의미에 집중. 숫자로서의 가치가 있느냐 없느냐가 중요한 기준)
: 문자 -> 명목(순서 X, 색깔, 종류), 서열(순서 O, 금은동, 1등, 2등, 3등, 소프트웨어 버전, 차량 연식)
: 숫자 -> 이산형(갯수, 온도), 연속형(키, 몸무게, 용량, 가격). 이산형은 정수형, 연속형은 실수형이며 소수점
: 범주형 변수 -> 숫자에서 문자로(나이를 20대, 30대 같은 연령대로)

Matrix
: 행과 열로 구성된 2차원 배열
: 동일한 데이터 타입만 저장 가능
: matrix(), rbind(), cbind()
: 함수값을 입력하고 싶을 땐, apply(data_name, Margin, Function)

DataFrame
: DB의 Table과 유사
: R에서 가장 많이 사용되는 구조
: Column, Field 단위로 서로 다른 데이터타입 사용 가능
: data.frame(), read.csv(), read.delim()
: 접근방법 = view(), table[행, 열]
                    ex) table[1, 1]
                        table[1:3, 2:4]
                        table$Column
: rbind(), cbind()로 두 데이터프레임 결합 가능
: 데이터프레임은 벡터가 열로 모여있는 것이며, 열끼린 같은 형식이어야한다.
: 매트릭스는 열, 행 모두 같아야하는 점에서 차이가 있다.

Array
: 행, 열, 면의 3차원 배열 형태의 객체 생성
: array()

List
: 사용하기 어렵다. 받은 자료가 리스트형인 경우가 있어 이를 쓰기 편하게 바꾸는걸 중심으로 공부
: key와 value 한쌍
: python dict와 유사
: list()
: 함수 적용할 땐 lapply(), sapply()

날짜 데이터 타입
: Sys.Date() / Sys. time()












# 변수 #

goods = "냉장고" (X)
goods.name = "냉장고"
goods.code = "ref-001"
goods.price = 60000

goods.name <- "냉장고"
goods.code <- "ref-001"
goods.price <- 60000

class(goods.name)
# "Character"

#메모리 청소 후
goods.name
#Error : object 'goods.name' not found



#### vector ####

#### c()
v <- c(1,2,3,4,5)
v
c(1:5) #범위연산자
class(c(1:5))

vc <- c(1,2,3,4,"5")
# -> "하나의 데이터 때문에 모두 문자로 바뀐다."

class(v)
# -> 'numeric'
mode(v)
# -> 'numeric'

#### seq()
?seq
seq(from=1, to=10, by=2) #1부터 10까지 2씩 증가하는 벡터 생산해줘
# -> 1 3 5 7 9

#### rep()
?rep
rep(1:3, 3) #1부터 3까지 값을 3번 반복한 벡터 생산해줘
# -> 1 2 3 1 2 3 1 2 3

#### 벡터 접근
v <- c(1:50)
v[5:45] #sql, r은 시작 위치가 1. 따라서 5:45는 5부터 45까지를 의미.

# length
v[10:(length(v)-5)] #v의 5부터 v 총 갯수에서 5를 뺀 값까지 슬라이싱.
# -> 10 11 12 ... 45
v[10:length(v)-5] # ()로 안묶어주면 전체 값 다 빠짐
# -> 5 6 7 8 9 ... 45

v1 <- c(13, -5, 20:23, 12, -2:3)
v1
# -> 13 -5 20 21 22 23 12 -2 -1  0  1  2  3
v1[1]
# -> 13
v1[c(2:4)] # = v1[2], v1[3], v1[4]
# -> -5 20 21
v1[c(4, 5:8, 7)]
# -> 21 22 23 12 -2 12
v1[-1] # 벡터에서 첫번째 자리 값을 제외하고 전부 가져와줘
# -> -5 20 21 22 23 12 -2 -1  0  1  2  3
v1[c(-1, -5:-7)]
# -> -5 20 21 -2 -1  0  1  2  3
v1[-c(1, 3, 5:7)]
# -> -5 21 -2 -1  0  1  2  3

#### 집합연산
x <- c(1,3,5,7)
y <- c(3,5)

union(x, y); setdiff(x, y); intersect(x,y)
# -> 1 3 5 7
# -> 1 7
# -> 3 5

union(x, y) #합집합 연산 함수
setdiff(x, y) #차집합 연산 함수
intersect(x,y) #교집합 연산 함수

#### 칼럼명 지정
age <- c(30, 35, 40)
names(age) <-  c("임꺽정", "홍길동", "신돌석")
age
# -> 임꺽정 홍길동 신돌석 
#      30     35     40

# 다만, 이게 테이블이 된 건 아니다. 그저, 편의상 데이터에 이름을 지어준 것일 뿐이다.

#### 변수의 데이터 제거
age <- NULL
age
# 사실 이 방식은 데이터를 지우는 건 아니다. 값이 저장된 주소를 바꾸는 것일 뿐. 데이터는 남아있다. 쓸 수 없게 된 것이지만.

#### 벡터 생성 방법
y <- (2:3) # x <- c(2:3)
x <- c(2, 3) # ,로 벡터 생성할 땐 c를 반드시 붙여줘야 한다. : 범위 지정해주면 c 함수 생략 가능하다.
x <- (2, 3)

class(x) #class는 함수가 설계된 형태를 의미
# -> "numeric" 
mode(x)
# -> "numeric"
class(y)
# -> "integer"
mode(y)
# -> "numeric"

# 범위의 경우 증가값이 실수형으로 설계되어 있다. 그래서 범위로 입력된 y의 class값은 정수형으로 나온다.

#### Factor : 그래프 그릴 수 있어. 문자형으로 된 벡터를 그래프로 나타내야할 때 활용
gender <- c("man", "woman", "woman", "man", "man")
gender

is.factor(gender)
# -> FALSE
plot(gender)
# Error!

ngender <- as.factor(gender)
ngender
# -> Levels: man woman
# -> w/ 2 levels "man","woman" : 1 2 2 1 1
# man = 1, woman = 2로 키 설정하고 숫자 값으로 저장한 것

class(ngender)
# -> [1] "factor"
mode(ngender)
# -> [1] "numeric"
plot(ngender)
# 막대그래프 : 질적 그래프에 자주 쓰임. 빈도수를 나타내기 때문.

table(ngender)
# -> ngender
# -> man woman 
# ->  3    2 

?factor
gfactor <- factor(gender, levels=c("man", "woman"), ordered = TRUE)
#factor(문자로 된 벡터 변수명, levels=c(), ordered = TRUE or FALSE)
#levels는 레벨 설정 가능. ordered는 sorted. 즉 정렬 기능을 지님
gfactor
plot(gfactor)


#### 3. Matrix. matrix()
m <- matrix(c(1:5)) #범위이므로 c는 생략 가능하다.
m
# ->
#      [,1]
#[1,]    1
#[2,]    2
#[3,]    3
#[4,]    4
#[5,]    5

m1 <- matrix(c(1:11), nrow=2)
m1 # 짝이 안맞으면 처음값을 마지막 자리에 넣는다.
# ->
#      [,1] [,2] [,3] [,4] [,5] [,6]
#[1,]    1    3    5    7    9   11
#[2,]    2    4    6    8   10    1
m2 <- matrix(c(1:10), nrow=2)
m2
#       [,1] [,2] [,3] [,4] [,5]
# [1,]    1    3    5    7    9
# [2,]    2    4    6    8   10
m3 <- matrix(c(1:10), nrow=2, byrow=TRUE)
m3
#       [,1] [,2] [,3] [,4] [,5]
# [1,]    1    2    3    4    5
# [2,]    6    7    8    9   10



#rbind() : 레코드(ㅡ) 순차적으로, cbind() : 칼럼(|)을 순차적으로
x1 <- c(3, 4, 50:52)
x2 <- c(30, 5, 6:8, 7, 8)
x1
x2

mr <- rbind(x1, x2) #경고값이 뜨는건 짝이 안맞아서다.
mr
mc <- cbind(x1, x2)
mc

#매트릭스 차수 확인
x <- matrix(c(1:9), ncol=3)
x

length(x) #값이 몇개 들어있니?
# -> 9
nrow(x) #행(레코드)이 몇개니?
# -> 3
ncol(x) #열(칼럼)이 몇개니?
# -> 3
dim(x) #몇 x 몇 행렬이니?
# -> 3 3

# colnames : 매트릭스에서 칼럼 이름을 지정해주는 함수, 칼럼 이름만 빼올 때도 쓸 수 있다.
colnames(x) <- c("one", "two", "three")
x
# ->
#       one two three
# [1,]   1   4     7
# [2,]   2   5     8
# [3,]   3   6     9

colnames(x)
# -> "one"   "two"   "three"

# apply : 파이썬 map 함수와 같다. 받은 값들을 함수에 넣어 결과값을 바로 산출해줌.
?apply
apply(x, 1, max)
# -> 7 8 9. 각 행(record)에서 가장 큰 수를 산출한 것.
apply(x, 2, max)
# ->
# one   two three 
#   3     6     9 
apply(x, 1, sum)
# -> 12 15 18
apply(x, 2, sum)
# ->
# one   two three 
#   6    15    24 
#apply(X, MARGIN, FUN, ... , simplify = TRUE)
# X엔 matrix 호출값을 입력한다.
# MARGIN은 1이면 레코드 순으로 함수에 값을 입력. 2면 칼럼 순으로 함수에 값을 입력



#### data frame ####

# data.frame()
no <- c(1,2,3)
name <- c('Hong', 'Lee', 'Kim')
pay <- c(150.25, 250.18, 300.34)

emp <- data.frame(NO=no, NAME=name, PAY=pay)
emp

#read.csv, read.table, read.delim;
getwd() #내가 작업중인 워크디렉토리 위치 알려줘
setwd() #작업 위치, 워크 디렉토리 바꿔줘
# -> "/Users/hoon/Desktop/Data/R/BasicProject"
txtemp <- read.table("/Users/hoon/Desktop/Data/R/Data/emp.txt", fileEncoding = "euc-kr")
#맥이나 리눅스는 utf-8 기반이고, 윈도우는 euc-kr 기반이라 파일 읽을 때 부딪혀서 읽지 못할 수 있음
#이럴 땐 파일 읽을 때 인코딩 값을 바꿔주면 해결된다. 현재 맥을 쓰고 있고 윈도우로부터 파일을 받았으니
#euc-kr로 읽을 수 있도록 인코딩 값을 주면 읽어진다.
txtemp

# 상대경로로 불러보기. 
# 현재위치에서 상위폴더로 나가기 : ..
txtemp <- read.table("../Data/emp.txt", fileEncoding = "euc-kr")
txtemp
# 사번, 이름, 급여는 field명이다. 따라서 지정해줘야 한다. 끝에 header=T 입력해주자.
txtemp <- read.table("../Data/emp.txt", header=T, sep = " ", fileEncoding = "euc-kr")
# sep는 각 데이터값들이 무엇으로 구분되어있는지. 기본값은 " "이니 space로 구분되어있는 파일은 생략해도 됨.
txtemp

csvemp1 <- read.table("../Data/emp.csv", header=T, sep=",", fileEncoding = "euc-kr") 
csvemp1

csvemp <- read.csv("../Data/emp.csv", fileEncoding = "euc-kr")
csvemp

csvemp2 <- read.csv("../Data/emp.csv", col.name=c("사번", "이름", "급여"), fileEncoding = "euc-kr")
csvemp2
#  사번   이름 급여
#1  101 홍길동  150
#2  102 이순신  450
#3  103 강감찬  500
#4  104 유관순  350
#5  105 김유신  400

csvemp5 <- read.csv("../Data/emp2.csv", header=FALSE, fileEncoding = "euc-kr")
csvemp5
#  V1     V2  V3
#1 101 홍길동 150
#2 102 이순신 450
#3 103 강감찬 500
#4 104 유관순 350
#5 105 김유신 400

csvemp6 <- read.csv("../Data/emp2.csv", header=FALSE, col.name=c("사번", "이름", "급여"), fileEncoding = "euc-kr")
csvemp6
#  사번   이름 급여
#1  101 홍길동  150
#2  102 이순신  450
#3  103 강감찬  500
#4  104 유관순  350
#5  105 김유신  400
?read.csv

aws <- read.delim("../Data/AWS_sample.txt", sep="#", fileEncoding="euc-kr")
aws
#header가 True인 것 빼곤 read.table과 차이 없다.
#그런데 aws양이 많아 200개만.....
#이 때 View() 함수 쓰면 확인 가능하다.
View(aws)
aws[1, 1]
x1 <- aws[1:3, 2:4]
x1
#[레코드, 필드]

x2 <- aws[9:11, 2:4]
x2

#두 필드를 합치는 방법 : rbind와 cbind
cbind(x1, x2)
#              TM   TA Wind            TM   TA Wind
# 1 2016-07-01 00 24.2  2.3 2016-07-01 08 24.4  2.1
# 2 2016-07-01 01 24.3  2.3 2016-07-01 09 25.0  2.2
# 3 2016-07-01 02 23.7  3.8 2016-07-01 10 25.4  2.4

rbind(x1, x2)
#               TM   TA Wind
# 1  2016-07-01 00 24.2  2.3
# 2  2016-07-01 01 24.3  2.3
# 3  2016-07-01 02 23.7  3.8
# 9  2016-07-01 08 24.4  2.1
# 10 2016-07-01 09 25.0  2.2
# 11 2016-07-01 10 25.4  2.4

aws[, 1]
# 1번열에 모든 데이터 뽑아내겠다.

c1 <- aws$AWS_ID
c1
class(c1)
mode(c1)
#vector형으로 이루어져있다.
#즉, 데이터프레임은 vector가 모여 이뤄져있다.
#열들은 같은 형식의 값이어야 한다.
#매트릭스는 행, 열 모두 같아야하는데, 데이터프레임은 열만 같으면 된다.

#구조확인. str()
str(aws)
# 'data.frame':	5886 obs. of  5 variables:
#   $ AWS_ID: int  108 108 108 108 108 108 108 108 108 108 ...
# $ TM    : chr  "2016-07-01 00" "2016-07-01 01" "2016-07-01 02" "2016-07-01 03" ...
# $ TA    : num  24.2 24.3 23.7 23.3 23.5 23.5 23.7 24 24.4 25 ...
# $ Wind  : num  2.3 2.3 3.8 3 2.1 2.7 2.1 0.3 2.1 2.2 ...
# $ X.    : chr  "=" "=" "=" "=" ...

#기본통계량
summary(aws)
# AWS_ID           TM                  TA            Wind            X.           
# Min.   :108.0   Length:5886        Min.   : 1.7   Min.   :0.000   Length:5886       
# 1st Qu.:108.0   Class :character   1st Qu.:19.5   1st Qu.:1.100   Class :character  
# Median :125.5   Mode  :character   Median :23.6   Median :1.800   Mode  :character  
# Mean   :125.5                      Mean   :23.3   Mean   :1.993                     
# 3rd Qu.:143.0                      3rd Qu.:27.5   3rd Qu.:2.700                     
# Max.   :143.0                      Max.   :37.5   Max.   :7.800                     


# apply() : 많이 사용하니 꼭 외워둡시다.
df <- data.frame(x = c(1:5), y = seq(2, 10, 2), z=c('a', 'b', 'c', 'd', 'e'))
df
apply(df[,c(1, 2)], 1, sum)
# [1]  3  6  9 12 15

# subset() : 데이터의 일부만 추출
x1 <- subset(df, x>=3)
x1
#   x  y z
# 3 3  6 c
# 4 4  8 d
# 5 5 10 e
x2 <- subset(df, x>=2 & y<=6)
x2
#   x y z
# 2 2 4 b
# 3 3 6 c

#merge(data1, data2, by.x = 기준 column, by.y = 기준 column) : 병합(INNER JOIN과 같은 기능)
height <- data.frame(id=c(1, 2), h=c(180, 175))
weight <- data.frame(id=c(1, 2), w=c(80, 75))

user <- merge(height, weight, by.x = "id", by.y = "id")
user
# id   h  w
# 1  1 180 80
# 2  2 175 75








#### array ####

v <- c(1:12)
v

?array()
arr <- array(v, c(4, 2, 3))
# array(데이터, 행, 열, 면 숫자 입력)
#, , 1

#       [,1] [,2]
# [1,]    1    5
# [2,]    2    6
# [3,]    3    7
# [4,]    4    8

# , , 2

#       [,1] [,2]
# [1,]    9    1
# [2,]   10    2
# [3,]   11    3
# [4,]   12    4

# , , 3

#       [,1] [,2]
# [1,]    5    9
# [2,]    6   10
# [3,]    7   11
# [4,]    8   12

# 접근
# 첫번째 면만 가져와
arr[, , 1]
# 1사면에 6 값을 가져와
arr[2,2,1]
arr[, , 1][2,2]


x1 <- 1
x2 <- data.frame(var1=c(1,2,3), var2=c('a','b', 'c'))
x2
#   var1 var2
# 1    1    a
# 2    2    b
# 3    3    c
x3 <- matrix(c(1:12), ncol=2)
x3
#       [,1] [,2]
# [1,]    1    7
# [2,]    2    8
# [3,]    3    9
# [4,]    4   10
# [5,]    5   11
# [6,]    6   12
x4 <- array(1:20, dim=c(2,5,2))
x4
# , , 1

#       [,1] [,2] [,3] [,4] [,5]
# [1,]    1    3    5    7    9
# [2,]    2    4    6    8   10

# , , 2

#       [,1] [,2] [,3] [,4] [,5]
# [1,]   11   13   15   17   19
# [2,]   12   14   16   18   20

## 형태가 각기 다른 x1,x2,x3,x4를 묶어서 저장?
x5 <- list(c1=x1, c2=x2, c3=x3, c4=x4)
x5
# 묶인 채로 사용하는건 너무 어려워. 그래서 한번 풀어서 사용해준다. 접근하는 방법은 $로
# c1만 가져오자.
x5$c1
x5$c3
x5$c4[,,1]
#       [,1] [,2] [,3] [,4] [,5]
# [1,]    1    3    5    7    9
# [2,]    2    4    6    8   10

list1 <- list(c("lee", "kim"), "이순신", 95)
list1
list1[1]
list1[[1]]
list1[[1]][1]
list1[[1]][2]

list2 <- list("이순신", "lee", 95)
un <- unlist(list2)
un
class(un)




a <- list(c(1:5))
a
b <- list(c(6:10))
b
c <- c(a,b)
c
#여기서 최대값을 구하고 싶다. apply(c, ?, max)?? -> error!
#여기선 apply 쓸 수 없다.

# apply() : laaply(),sapply()
# lapply는 3차원 이상의 데이터만 입력을 받습니다.
# lapply는 리턴값이 리스트형. 다시 풀어줘야 한다.
# sapply는 lapply와 같으나, 리턴값이 리스트가 아닌 벡터형. 조금 더 편하게 사용 가능
?lapply()
x <- lapply(c, max)
x
#   [[1]]
# [1] 5

#    [[2]]
# [1] 10
unx <- unlist(x)
unx

?sapply()
x <- sapply(c, max)
x








#### 날짜 데이터 타입 ####
# 함수가 데이터 타입에만 적용되는 것들이 있어. 그럴 땐 바꿔줘야 한다.

a <- '21/10/11'
class(a)
b <- as.Date(a)
b
class(b)
c <- as.Date(a, "%y/%m/%d")
c
class(c)