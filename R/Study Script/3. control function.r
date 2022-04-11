#### 3. 조건문 ####

# 난수
?runif
x <- runif(1)
x
#0과 1 사이의 난수를 만들어주는 함수
if(x > 0.9){
  print(x)
}

#x가 0.5보다 작으면 1-x를 출력하고 그렇지 않으면 x를 출력
if(x > 0.5){
  print(1-x)
}else{
  print(x)
}


#ifelse
ifelse(x < 0.5, 1-x, x)

#다중조건문
avg <- scan()

if(avg > 90){
 print("당신의 학점은 A학점입니다.")
}else if(avg > 80){
  print("당신의 학점은 B학점입니다.")
}else if(avg > 70){
  print("당신의 학점은 C학점입니다.")
}else if(avg > 60){
  print("당신의 학점은 D학점입니다.")
}else{
  print("당신의 학점은 F학점입니다.")
}



### which() : 값의 위치를 찾아 알려주는 함수
# Vector에서 사용
x <- c(2:10)
which(x == 3)
# 2
x[which(x == 3)]
# 3

# Matrix에서 사용
m <- matrix(1:12, 3, 4)
m
?which
#which(x, arr.ind = FALSE, useNames = TRUE) / arr.ind는 2차원부터 의미를 지닌다.
which(m%%3 == 0)
# 3 6 9 12 -> 3의 배수를 그대로 가져왔다. 위치를 가져오지 않았다.
# arr.ind를 TRUE로 해주면?
which(m%%3 == 0, arr.ind = TRUE)
#      row col
# [1,]   3   1
# [2,]   3   2
# [3,]   3   3
# [4,]   3   4
# -> 3행 1열, 2열, 3열, 4열에 그 값이 있단 의미. 실제 matrix m에서 3 6 9 12의 위치.

# DataFrame에서 사용 (가장 유용함)
no <- c(1:5)
name <- c("관우", "장비", "조운", "황충", "마초")
score<- c(98, 99, 97, 92, 99)
d <- data.frame(학번=no, 이름=name, 점수=score)
d
#이름이 장비인 사람을 검색
which(d$이름 == "장비")
d[which(d$이름 == "장비"), ]
d[2, ]
#   학번 이름 점수
# 2    2 장비   99

# which.max / which.min
# 가장 높은 점수를 가진 학생 검색하기
which.max(d$점수)
d[which.max(d$점수), ]
# 가장 낮은 점수를 가진 학생 검색하기
which.min(d$점수)
d[which.min(d$점수), ]


# any(), all()
# any는 or 연산자. all은 and 연산자
# TRUE or FALSE로 리턴
x <- runif(5)
x

# x값들 중에 0.8 이상인 값이 있는가?
any(x>=0.8)
# x값들 모두 0.7 이하인가?
all(x<=0.7)









#### 반복문 ####
# 1부터 10까지 합계
sum <- 0
for(i in seq(1, 10)){
  sum <- sum + i
}
print(sum)


sum <- 0
for(i in c(1:10))  sum <- sum + i
print(sum)










#### 함수 만들기 ####
# 인자 없는 함수
test1 <- function(){
  x <- 10
  y <- 20
  print(x * y)
  return(x * y)
}
test1()
v <- test1()
v
# -> 200

# 인자 있는 함수
test2 <- function(x, y){
  a <- x
  b <- y
  
  return(a-b)
}
test2(200, 50)
# -> 150
test2(y=50, x=200)
# -> 150 인수를 직접 지정해서 값을 넣어줄 수 있다.
v2 <- test2(200, 50)
v2


# 가변인수 : ...
test3 <- function(...){
  print(list(...))
  for(i in list(...)){
    print(i)
  }
}
test3(10)
test3(10, 20)
test3(10, 20, "a")


# R에선 만들어 쓰기보단 이미 만들어진 함수 찾아서 쓰는 것이 효율적! 그 능력을 가지도록 노력해야함.










#### 문자열 표현식 ####
# 정규 표현식 
install.packages("stringr")
library(stringr)

str1 <- "홍길동32이순신45임꺽정35이괄30신사임당27"
str_extract(str1, "\\d{2}")
# 32
unlist(str_extract_all(str1, "\\d{2}"))
# "32" "45" "35" "30" "27"
unlist(str_extract_all(str1, "[가-힣]+"))
# "홍길동"   "이순신"   "임꺽정"   "이괄"     "신사임당"

str2 <- "hongkd105lessad102you25TOM400강감찬231"
str_extract_all(str2, "\\D+")
str_extract_all(str2, "[가-힣a-zA-Z]+")
# [[1]]
# [1] "hongkd" "lessad" "you"    "TOM"    "강감찬"

str3 <- "hongkd105,lessad102,you25,TOM400,강감찬231"
str_split(str3, ",")



length(str2)
# 1
str_length(str2)
# 35
str_locate(str2, "강감찬")
#      start end
# [1,]    30  32
str_c(str2, "유비55")
# "hongkd105lessad102you25TOM400강감찬231유비55"
str2
# "hongkd105lessad102you25TOM400강감찬231"
# 원본에 저장은 안됨. 지정해줘야한다. 그리고 이런 함수를 썼을 땐 일일이 확인해주는 자세 필요하다.

