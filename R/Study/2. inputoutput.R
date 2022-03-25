#### 키보드 입력 ####
# scan() : vector로 입력받는다. 기본값은 숫자만 입력 가능하도록 설정
# edit() : dataframe으로 입력받는다.

?scan()
a <- scan()
a
# 10
b <- scan(what = character())
b
# "홍길동"


df <- data.frame()
df <- edit(df)
df









#### 파일 입력 ####
# read.csv() : 
# read.table() :
# read.xlsx() :
# read.spss() :

?read.table
student <- read.table("../data/student.txt", fileEncoding = "euc-kr")
student

student1 <- read.table("../data/student1.txt", header = T, fileEncoding = "euc-kr")
student1

student2 <- read.table(file.choose(), header = T, sep = ";", fileEncoding = "euc-kr")
student2

#결측치 표시
student3 <- read.table("../data/student3.txt", header = T, na.strings = c("-", "+", "&"), fileEncoding = "euc-kr")
student3
#   번호 이름  키 몸무게
# 1  101 hong 175     NA
# 2  201  lee  NA     85
# 3  301  kim 173     NA
# 4  401 park  NA     79

# 입력한 값이 여러개일 땐 무조건 벡터로 묶어서 보내준다.



?read.xlsx()
# 패키지 설치 필요.
install.packages("rJava")
install.packages("xlsx")

library(rJava)
library(xlsx)

studentx <- read.xlsx(file.choose(), sheetIndex = 1)
studentx <- read.xlsx(file.choose(), sheetName = "데이터")
studentx


install.packages("foreign")
library(foreign)
raw_welfare <- read.spss("../data/Koweps_hpc10_2015_beta1.sav")
raw_welfare









#### 출력 ####
# 변수명
# (식)
# print()
# cat() -> 프린트로 출력하기엔 복잡할 때 쓰는 함수
x <- 10
y <- 20
z <- x+y

print("x + y의 결과는", as.charactre(z), "입니다.") # -> Error!





# 파일 저장
# write.csv()
# write.table()
# write.xlsx()
# rda(r 전용 파일) : save(studentx, file = "../data/stud6.rda")
#                    load(studentx, file = "../data/stud6.rda")

studentx <- read.xlsx("../data/studentexcel.xlsx", sheetName = "emp2")
studentx

write.table(studentx, "../data/stud1.txt")
write.table(studentx, "../data/stud2.txt", row.names = F)
write.table(studentx, "../data/stud2.txt", row.names = F, quote = F)

write.csv(studentx, "../data/stud3.csv", row.names = F, quote = F)

library(rJava)
library(xlsx)
write.xlsx(studentx, "../data/stud4.xlsx", row.names = F, quote = F)