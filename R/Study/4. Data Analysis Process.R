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


---------------------------------------------------

  
#데이터 탐색
  
#변수명 바꾸기
df_raw <- data.frame(var1 = c(1,2,3), var2 = c(2,3,2))
df_raw

#칼럼명 바꾸기
df_raw1 <- df_raw
names(df_raw1) <- c("v1", "v2")
df_raw1
#   v1 v2
# 1  1  2
# 2  2  3
# 3  3  2

library(dplyr)
df_raw2 <- df_raw
df_raw2 <- rename(df_raw2, v1 = var1, v2 = var2)
df_raw2
#   v1 v2
# 1  1  2
# 2  2  3
# 3  3  2





### 2. 결측치 처리
dataset1 <- read.csv("../data/dataset.csv", header = T)
dataset1

str(dataset1)
# 'data.frame':	300 obs. of  7 variables:
head(dataset1)
# resident : 1 ~ 5까지의 값을 갖는 명목변수로 거주지를 나타낸다.
# gender : 1 ~ 2까지의 값을 갖는 명목변수로 남/녀를 나타냄
# job : 1 ~ 3까지의 값을 갖는 명목변수. 직업을 나타냄
# age : 양적변수(비율) : 2 ~ 69
# position : 1 ~ 5까지의 값을 갖는 명목변수. 직위를 나타냄
# price : 양적변수(비율) : 2.1 ~ 7.9
# survey : 만족도 조사 : 1 ~ 5까지 명목변수

#결측치 확인
summary(dataset1)
y <- dataset1$price
plot(y)
summary(y)
#     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
# -457.200    4.425    5.400    8.752    6.300  675.000       30 

#결측치 제거
#1. na.rm
sum(y)
# NA
sum(y, na.rm=T)
# 2362.9
# 원본에 결측치 지워진 것 아님. 합을 구하기 위해 잠시 뺀 것
mean(y, na.rm=T)
#2. na.omit
price2 <- na.omit(dataset1$price)
summary(price2)

#결측치를 다른 값으로 대체
#is.xx or as.xx
price3 <- ifelse(is.na(dataset1$price), 0, dataset1$price)
summary(price3)
mean(price3)
#평균값이 달라졌다. 결측치가 0으로 들어왔기 때문

#결측치 대체를 평균으로
price4 <- ifelse(is.na(dataset1$price), round(mean(dataset1$price, na.rm = T), 2), dataset1$price)
summary(price4)
round(mean(price4), 2)
#결측치가 있으면 평균 못구해. 그러니 na.rm을 평균에 써서 값이 계산되도록

### 3. 이상치 처리
# 양적 변수 vs 질적 변수의 구별

# 질적변수 : 막대그래프, 원그래프 
table(dataset1$gender)
barplot(table(dataset1$gender))

# 양적변수 : 산술평균, 조화평균, 중앙값 -> 히스토그램, 상자도표, 시계열도표, 산포도
summary(dataset1$price)
length(dataset1$price)

plot(dataset1$price) #산포도, scatter
boxplot(dataset1$price) #상자표, boxplot

# 이상치 처리
dataset2 <- subset(dataset1, price >= 2 & price <= 8)
length(dataset2$price)
dataset2

plot(dataset2$price)
boxplot(dataset2$price)

# 막대그래프, 히스토그램의 차이 : 떨어지고 붙어있고, 변수가 2개 이상, 변수가 하나


# Feature Engineering
View(dataset2)

# 가독성을 위해 지역 1, 서울 / 2, 인천 / 3, 대전 / 4, 대구 / 5, 시구군
dataset5 <- dataset2 %>% mutate(resident_word = if_else(resident == 1, "서울", if_else(resident == 2, "인천", if_else(resident == 3, "대전", ifelse(resident == 4, "대구", "시구군"))))) %>%
  select(resident2, gender, job, age, position, price, survey)
head(dataset5)

dataset2$resident2[dataset2$resident == 1] <- "1. 서울특별시"
dataset2$resident2[dataset2$resident == 2] <- "2. 인천광역시"
dataset2$resident2[dataset2$resident == 3] <- "3. 대전광역시"
dataset2$resident2[dataset2$resident == 4] <- "4. 대구광역시"
dataset2$resident2[dataset2$resident == 5] <- "5. 시구군"
head(dataset2)


#Binning : 척도변경(양적 -> 질적)
#나이 변수를 청년층(30세 이하), 중년층(31~55), 장년층(56~)으로
dataset4 <- dataset2 %>% mutate(age_grade = if_else(age <= 30, "청년층", if_else(age <= 55, "중년층", "장년층")))
head(dataset4)

dataset2$resident2[dataset2$age <= 30] <- "청년층"
dataset2$resident2[dataset2$age >= 31 & dataset2$age <= 55] <- "중년층"
dataset2$resident2[dataset2$age >= 56] <- "장년층"
head(dataset2)


#Dummy : 척도변경(질적 -> 양적)
#기계, 통계 분석을 위해 활용하는 경우가 대부분
user_data <- read.csv("../data/user_data.csv", header = T, fileEncoding = "euc-kr")
user_data
table(user_data$house_type)
#1. 단독주택 / 2. 다가구주택 / 3. 아파트 / 4. 오피스텔
#1과 2는 0으로, 3과 4는 1로

user_data$house_type2[user_data$house_type == "1" | user_data$house_type == "2"] <- 0
user_data$house_type2[user_data$house_type == "3" | user_data$house_type == "4"] <- 1
head(user_data)
table(user_data$house_type2)



#기계는 학습할 때 .. 가중치를 둔다.
#1등 ~ 5등. 5등에 더 높은 점수를 주는 경우 존재.
#이럴 때, 10000, 01000, 00100, 00010, 00001과 같이 0과 1로 표기한다. 그러면 가중치 X



## 데이터 구조 변경(wide type, long type)
#reshape, reshape2, tidyr
#그래프 그릴 때 필요. long 형태에서만 먹히는 그래프 함수, wide 형태에서만 먹히는 그래프 함수 있어.

install.packages("reshape2")
library(reshape2)

#melt = wide -> long
#cast, dcast = long -> wide

?data()
data()  
# 통계분석에 맞는 데이터 얻는 거 너무 힘들어. 어떻게 구성해야할지 모르겠을 땐 이 데이터들을 살펴봅시다.

str(airquality)
head(airquality)
#   Ozone Solar.R Wind Temp Month Day
# 1    41     190  7.4   67     5   1
# 2    36     118  8.0   72     5   2
# 3    12     149 12.6   74     5   3
# 4    18     313 11.5   62     5   4
# 5    NA      NA 14.3   56     5   5
# 6    28      NA 14.9   66     5   6
# -> Wide형 데이터구조

# Long형으로 바꿔봅시다.
me <- melt(airquality, id.vars = c("Month", "Day"))
#     Month Day variable value
# 1       5   1    Ozone    41
# 2       5   2    Ozone    36
# 3       5   3    Ozone    12
# 4       5   4    Ozone    18
# 5       5   5    Ozone    NA

#variable과 value 칼럼명을 바꿔줄 수 있음.
me1 <- melt(airquality, id.vars = c("Month", "Day"),
            variable.name = "climate_var", value.name = "climate_val")
me1
#     Month Day climate_var climate_val
# 1       5   1       Ozone          41
# 2       5   2       Ozone          36
# 3       5   3       Ozone          12
# 4       5   4       Ozone          18
# 5       5   5       Ozone          NA


# wide형으로 바꿔봅시다.
?dcast
dc1 <- dcast(me1, Month+Day ~ climate_var, value.var="climate_val")
dc1
#formula : ~      종속변수와 독립변수를 구분해주는 역할도 한다. 나중에 요긴하게 쓰임



data <- read.csv("../data/data.csv")
data

dc2 <- dcast(data, Customer_ID ~ Date, mean, value.var = "Buy")
dc2
dc3 <- melt(dc2, id.vars = "Customer_ID",
            variable.name = "Date", value.name = "Buy")
dc3
#날짜별로 몇개를 구매했는지 알 수 있다.

dc4 <- subset(dc3, Buy = NaN)
dc4


pay_data <- read.csv("../data/pay_data.csv", fileEncoding = "euc-kr")
head(pay_data)
pay_data1 <- dcast(pay_data, user_id ~ product_type)
head(pay_data1)
pay_data3 <- dcast(pay_data, user_id + pay_method + price ~ product_type)
head(pay_data3)
pay_data2 <- melt(pay_data1, id.vars = "user_id",
                  variable.name = "pay_method", value.name = "price")
pay_data2














#### example
## 극단적 선택의 비율은 어느 연령대가 가장 높은가? (사망원인 통계)

# 1. 데이터 확보 : kosis.kr ...
# 2. 데이터 형태 가공(전처리 시작)
# 3. 유의미한 데이터 목록 정하기
# 4. 나이와 사망률, 성별과 사망률의 상관관계, 인과관계 파악해보기
# 5. 관계가 있다면 그 관계의 원인은 무엇인가?





library(stringr)

sk_original <- read.csv("../data/sk.csv", fileEncoding = "euc-kr")
sk_original
sk_subset <- subset(sk[-1, -1:-2])
View(sk_subset)
str(sk_subset)

names(sk_subset) <- c("age", "total", "man", "wom", "total_prop", "man_prop", "wom_prop")
for(i in c("age", "total", "man", "wom", "total_prop", "man_prop", "wom_prop"){
  as.integer(sk_subset$i)
})
sk_subset
str(sk_subset)
sk_subset$total_prop <- ifelse(is.na(sk$total_prop), 0, sk$total_prop)
sk_subset$man_prop <- ifelse(is.na(sk$man_prop), 0, sk$man_prop)
sk_subset$wom_prop <- ifelse(is.na(sk$wom_prop), 0, sk$wom_prop)






?as.integer()
mode(sk_subset$total) <- "integer"
mode(sk_subset$man) <- "integer"
mode(sk_subset$wom) <- "integer"
mode(sk_subset$total_prop) <- "integer"
mode(sk_subset$man_prop) <- "integer"
mode(sk_subset$wom_prop) <- "integer"
str(sk_subset)


boxplot(sk_subset$total_prop)
summary(sk_subset$total_prop)
sk <- sk_subset
