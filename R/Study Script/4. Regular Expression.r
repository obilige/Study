#### 문자열 표현식 ####
# 정규 표현식 : 파이썬, SQL, R, JAVA 등 모든 언어에서 공통적으로 사용 가능
# 파이썬에선 import re
# R에선 install.packages("stringr") -> library(stringr)

str1 <- "홍길동32이순신45임꺽정35이괄30신사임당27"
?type.convert

# II. Regular Expression
1. 반복 : *
  앞의 문자를 0번 이상 반복
  ab* = a, ab, abb, abbb, abbbb ...
  *은 앞의 문자 b를 0번 이상 반복한 문자를 찾아준다.
  lo*l = ll, lol, lool, loool ...

2. 반복 : +
  앞의 문자를 1번 이상 반복
  ab+ = ab, abb, abbb, abbbb

3. 반복 : ?
  앞의 문자를 0회 혹은 1회 반복
  ab? = a, ab

4. 반복 : {m}
  앞의 문자를 m회 반복
  ab{3} = abbb

5. 반복 : {m, n}
  앞의 문자를 m회부터 n회까지 반복
  a{2, 3}bc = aabc, aaabc


1. 매칭 : .
  줄바꿈 문자를 제외한 모든 문자와 일치
  a.b = \n을 제외한 모든 문자가 a     b 사이에 들어올 수 있다.
      = abb, aac, adb, aob ...

2. 매칭 : ^
  문자열의 시작이 반드시 지정된 값으로 시작하는 값을 찾아준다.
  ^abc : abc... , abcsadqfqf

3. 매칭 : $
  문자열의 마지막이 반드시 지정된 값으로 끝나는 값을 찾아준다.
  $a : sndjlafla, qwusa ...

4. 매칭 : [] *가장 많이 쓰는 정규표현식 중 하나
  문자 집합 중 한 문자와 매치
  [abc]xyz : axyz, bxyz, cxyz
  [a-z]xyz : axyz, bxyz, cxyz, dxyz, exyz ... 아스킷코드로 범위
  a[.]b : a.b만 나온다. 모든문자를 표현하는 .이 아니다. 이외엔 []안에 정규표현식 자유롭게 결합해 쓸 수 있다.
  [a^bc]hello : ahello, chello
  [a-zA-Z0-9]hello : 특수문자 제외한 모든 문자, 숫자 + hello
  [가-힣]+ : 한글 시작부터 끝까지 1회 이상


1. 특수문자 : \d
  모든 숫자와 매치
  ab\d\dc : ab99c, ab00c, ab12c, ab43c ...
  ab[0-9][0-9]c

2. 특수문자 : \D
  모든 숫자를 제외한 문자와 매치

3. 특수문자 : \s
  공백문자와 매치

4. 특수문자 : \S
  공백문자를 제외한 모든 문자와 매치

5. 특수문자 : \w
  모든 숫자, 모든 문자와 매치

6. 특수문자 : \W
  모든 숫자, 모든 문자를 제외한 문자들과 매치



#실습
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
