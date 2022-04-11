#### 기술통계, Describe ####
모수 : 전체 / 통계량(표본) : 통계에 사용할 일부


IV. Data PreProcessing
1. 순서
    데이터 탐색 -> 결측치 처리(Neccessary) -> 이상치 처리(Option) -> Feature Engineering
    * 이상치 -> 평균과 너무 멀어져 있는 값
    * Feature -> 칼럼, 필드 중 분석에 필요한 것들 골라내는
2. 데이터 탐색
    변수확인 -> 변수 유형(범주형, 연속형, 문자형, 숫자형, ...) -> 변수의 통계량(평균, 사분위, 분산, 표준편차) -> 변수와 관계, 평균 차이 검증(분석에서도 활용)
3. 결측치 처리
    다른 값으로 대체 가능? : 평균, 최빈값, 중간값 등
    삭제 : 가장 마지막 결정할 내용
    예측 : 빈 값을 예측(선형 회귀분석, 로지스틱 회귀분석)
4. 이상치 처리
    이상치 범위 결정
    이상치 유무 확인(탐색)
    * 시각적인 확인 : boxplot, 산포도, 산점도(scatterplot)
    * 산포도 : 두 변수간의 관계를 파악하는데 용이
    * 통계적 확인 : 표준편차(잔차), leverage, Cook`s D
    이상치 처리
    * 다른 값으로 대체
    * 리샘플링(표본을 다시 뽑는다.) sample(x, y) x 범위에서 y만큼 뽑는다.
    * 삭제
5. Feature Engineering
    Scaling. 표준화, 정규화 ex)단위변경
    Benning. 범주화. 연속형 변수(나이)를 범주형 변수(연령대)로 카테고리화하는 것
    Dummy. 범주형 변수를 연속형 변수로 바꿔주는 것. 예) 성별을 1, 2로 바꿔주는 것
    Transform. 기존에 존재하는 변수의 성질을 이용해 다른 변수를 만드는 방법 예) 파생변수를 만드는 것
    ...
    분석을 위해 해야하는 모든 활동들을 Feature Engineering이며, 위 방법은 많이 쓰는 것 추려서 요약한 것입니다.


V. dplyr
select(), filter(), arrange(), mutate(), summarize(), groupby(), left_join(), bind_rows()
#SQL 명령어와 비슷한 것들 많아.
데이터 %>% : 데이터 전체를 불러온다. 맨 앞에 쓰는 것이 특징. %>%은 일의 순서를 나타내고, 함수쓸 때마다 입력해주면 된다.
select() : 열 추출 -> 데이터[, 열 추출조건], sql의 select와 같은 기능
filter() : 행 추출 -> subset(), 데이터[행 추출조건, ]. sql의 where와 유사한 기능을 가진다.
arrange() : 정렬
mutate() : 열 추가
summarize() : 통계량 산출
groupby() : 집단별로 나누기
left_join() : 데이터 합치기(열)
bind_rows() : 데이터 합치기(행)










#### 기술통계량 ####
### table()

aws <- read.delim("../data/aws_sample.txt", sep = "#", fileEncoding = "euc-kr")
head(aws)
tail(aws)
str(aws)
# 'data.frame':	5886 obs. of  5 variables:
#  $ AWS_ID: int  108 108 108 108 108 108 108 108 108 108 ...
#  $ TM    : chr  "2016-07-01 00" "2016-07-01 01" "2016-07-01 02" "2016-07-01 03" ...
#  $ TA    : num  24.2 24.3 23.7 23.3 23.5 23.5 23.7 24 24.4 25 ...
#  $ Wind  : num  2.3 2.3 3.8 3 2.1 2.7 2.1 0.3 2.1 2.2 ...
#  $ X.    : chr  "=" "=" "=" "=" ...

# 값의 갯수는 5886개 필드는 5개
# 필드의 자료 형태는 int, chr, num, num, chr


summary(aws)
#   AWS_ID           TM                  TA            Wind            X.           
# Min.   :108.0   Length:5886        Min.   : 1.7   Min.   :0.000   Length:5886       
# 1st Qu.:108.0   Class :character   1st Qu.:19.5   1st Qu.:1.100   Class :character  
# Median :125.5   Mode  :character   Median :23.6   Median :1.800   Mode  :character  
# Mean   :125.5                      Mean   :23.3   Mean   :1.993                     
# 3rd Qu.:143.0                      3rd Qu.:27.5   3rd Qu.:2.700                     
# Max.   :143.0                      Max.   :37.5   Max.   :7.800                     

# ID는 108, 125.5, 143 3개? 혹은 108, 143이 같은 비율로 형성되어있을 수도 있다.
# TA는 

table(aws$AWS_ID) #앞으로 엄청 많이 쓸 것
# 108  143 
# 2943 2943 

table(aws$AWS_ID, aws$X.)

table(aws[, c("AWS_ID", "X.")])

aws[2500:3100, "X."] = "!"
aws[2500:3100, "X."]
table(aws[, c("AWS_ID", "X.")])
# AWS_ID    !    =
#    108  444 2499
#    143  157 2786

#값들의 빈도 비율도 알 수 있다.
prop.table(table(aws$AWS_ID))
# 108 143 
# 0.5 0.5
prop.table(table(aws$AWS_ID)) * 100 #백분율로 표현가능
# 108 143 
#  50  50 




#mean(), median(), var(), sd(), max(), min(), quantile(), summary() ...
# 모수, 표본추출, 통계량 .. 통계량으로 전체인 모수 판단하려면 여러 표본 추출 필요. 그리고 확률 개념이 적용된다.
# range(vector) : 벡터를 대상으로 범위를 구하는 함수
# order(vec) : 정렬
# rank(vec) :
# table(vec) :
# str()
# sample(x, y) : x 범위에서 y만큼 샘플 데이터를 생성하는 함수
# unique() : 





#### 데이터처리를 위한 도구 ####
### plyr(예전에 많이 사용)
### dplyr

install.packages(dplyr)
# - tibble : dataframe 유용하게 쓰게 해주는 기능
library(dplyr)

# filter()
exam <- read.csv("../data/csv_exam.csv", fileEncoding = "euc-kr")
exam

#1반 학생들을 불러오세요.
subset(exam, exam$class == 1)
exam[exam$class == 1, ]
filter(exam, exam$class == 1)
#   id class math english science
# 1  1     1   50      98      50
# 2  2     1   60      97      60
# 3  3     1   45      86      78
# 4  4     1   30      98      58

exam %>% filter(class == 1)
#   id class math english science
# 1  1     1   50      98      50
# 2  2     1   60      97      60
# 3  3     1   45      86      78
# 4  4     1   30      98      58

exam[exam$class == 2 & exam$english >= 80, ]
exam %>% filter(class == 2 & english >= 80)
#   id class math english science
# 5  5     2   25      80      65
# 6  6     2   50      89      98
# 7  7     2   80      90      45

#1반, 3반, 5반에 해당하는 학생
exam %>% filter(class == 1 | class == 3 | class == 5)
exam %>% filter(class %in% c(1, 3, 5))
#    id class math english science
# 1   1     1   50      98      50
# 2   2     1   60      97      60
# 3   3     1   45      86      78
# 4   4     1   30      98      58
# 5   9     3   20      98      15
# 6  10     3   50      98      45
# 7  11     3   65      65      65
# 8  12     3   45      85      32
# 9  17     5   65      68      98
# 10 18     5   80      78      90
# 11 19     5   89      68      87
# 12 20     5   78      83      58

#select()
exam[, 3]
exam %>% select(math)

#반, 수학, 영어 점수 추출
exam %>% select(class, math, english)

#수학 칼럼을 제외한 나머지 다 가져오세요.
exam %>% select(-math)
#    id class english science
# 1   1     1      98      50
# 2   2     1      97      60
# 3   3     1      86      78
# 4   4     1      98      58
# 5   5     2      80      65

#1반 학생들의 수학 점수만 2명 추출
# SELECT math FROM exam WHERE class = 1 limit 2;
exam %>% filter(class == 1) %>%
  select(class, math) %>%
  head(2)
#   class math
# 1     1   50
# 2     1   60




# arrange() : order()
?arrange()
exam %>% arrange(math)
#    id class math english science
# 1   9     3   20      98      15
# 2   5     2   25      80      65
# 3   4     1   30      98      58
# 4   3     1   45      86      78
# 5  12     3   45      85      32
# ascending 오름차순이 디폴트값
exam %>% arrange(desc(math))
#    id class math english science
# 1   8     2   90      78      25
# 2  19     5   89      68      87
# 3   7     2   80      90      45
# 4  18     5   80      78      90
# 5  20     5   78      83      58

# 2차 정렬도 가능
# 반 정렬하고, 수학 점수로 정렬
exam %>% arrange(class, math)
#    id class math english science
# 1   4     1   30      98      58
# 2   3     1   45      86      78
# 3   1     1   50      98      50
# 4   2     1   60      97      60
# 5   5     2   25      80      65




# mutate()
exam$sum <- exam$math + exam$english + exam$science
exam
exam$avg <- (exam$math + exam$english + exam$science) / 3
exam

exam <- exam[, -c(6, 7)]
exam
exam %>% mutate(sum = math+english+science, avg=sum/3)
#    id class math english science sum      avg
# 1   1     1   50      98      50 198 66.00000
# 2   2     1   60      97      60 217 72.33333
# 3   3     1   45      86      78 209 69.66667
# 4   4     1   30      98      58 186 62.00000
# 5   5     2   25      80      65 170 56.66667
exam
# 원본에 저장되어있는지 확인.
# 원본에 저장해야하면 exam <- exam %>% mutate(sum = math+english+science, avg=sum/3) 해주기!
# 그게 아니면 이름 지정해줘야


# summarize()
?summarize()
exam %>% summarize(mean_math = mean(math))




# group_by() : 분석 단계에서 많이 사용하는 함수
exam %>% group_by(class) %>%
  summarize(mean_math = mean(math), sum_math = sum(math), median_math = median(math), count = n())
# A tibble: 5 × 5
#   class mean_math sum_math median_math count
#    <int>     <dbl>    <int>       <dbl> <int>
# 1     1      46.2      185        47.5     4
# 2     2      61.2      245        65       4
# 3     3      45        180        47.5     4
# 4     4      56.8      227        53       4
# 5     5      78        312        79       4

# left_join() & bind_rows()
test1 <- data.frame(id = c(1,2,3,4,5), midterm = c(60, 70, 80, 90, 85))
test2 <- data.frame(id = c(1,2,3,4,5), midterm = c(70, 83, 65, 95, 80))
left_join(test1, test2, by = 'id')
#   id midterm.x midterm.y
# 1  1        60        70
# 2  2        70        83
# 3  3        80        65
# 4  4        90        95
# 5  5        85        80
bind_rows(test1, test2)
#    id midterm
# 1   1      60
# 2   2      70
# 3   3      80
# 4   4      90
# 5   5      85
# 6   1      70
# 7   2      83
# 8   3      65
# 9   4      95
# 10  5      80