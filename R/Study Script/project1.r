project

install.packages("corrplot")

library(stringr)
library(dplyr)
library(corrplot)

sk_original <- read.csv("../data/sk.csv", fileEncoding = "euc-kr") #맥북이라 윈도우 형식인 'euc-kr' 먹여줬습니다.
sk_original
sk_subset <- subset(sk_original[-1, -1:-2])
sk_subset
str(sk_subset)
# 'data.frame':	19 obs. of  7 variables:
#  $ 연령.5세.별        : chr  "1 - 4세" "5 - 9세" "10 - 14세" "15 - 19세" ...
#  $ 사망자수..명.      : chr  "0" "2" "49" "266" ...
#  $ 사망자수..명..1    : chr  "0" "0" "23" "141" ...
#  $ 사망자수..명..2    : chr  "0" "2" "26" "125" ...
#  $ 사망률..십만명당.  : chr  "-" "0.1" "2.1" "10.4" ...
#  $ 사망률..십만명당..1: chr  "-" "-" "1.9" "10.6" ...
#  $ 사망률..십만명당..2: chr  "-" "0.2" "2.3" "10.2" ...
# -> column 이름 바꾸기 // chr을 int로 // -(NaN)은 0으로

# 1. 칼럼 이름 바꾸기
names(sk_subset) <- c("age", "total", "man", "wom", "total_prop", "man_prop", "wom_prop")
sk_subset
#          age total  man wom total_prop man_prop wom_prop
# 2    1 - 4세     0    0   0          -        -        -
# 3    5 - 9세     2    0   2        0.1        -      0.2
# 4  10 - 14세    49   23  26        2.1      1.9      2.3
# 5  15 - 19세   266  141 125       10.4     10.6     10.2
# 6  20 - 24세   640  339 301       19.6     19.8     19.3

# 2.결측치 0으로 대체하기
sk_subset$total_prop <- ifelse(sk_subset$total_prop == "-", 0, sk_subset$total_prop)
sk_subset$man_prop <- ifelse(sk_subset$man_prop == "-", 0, sk_subset$man_prop)
sk_subset$wom_prop <- ifelse(sk_subset$wom_prop == "-", 0, sk_subset$wom_prop)
sk_subset

# 3. 자료형 integer로 바꾸기
#for(i in c("age", "total", "man", "wom", "total_prop", "man_prop", "wom_prop")){
#  as.integer(sk_subset$i)
#}
# -> 뭘 잘못한거지? 왜 안되는거야...

mode(sk_subset$total) <- "integer"
mode(sk_subset$man) <- "integer"
mode(sk_subset$wom) <- "integer"
mode(sk_subset$total_prop) <- "integer"
mode(sk_subset$man_prop) <- "integer"
mode(sk_subset$wom_prop) <- "integer"

sk_subset
str(sk_subset)
sk <- sk_subset


# 4. 나이 범위를 대표값, 정수형으로 바꾸기
for(i in c(1:2)){
  sk$age_int[i] <- str_extract(sk$age[i], "\\d{1}")
}
for(i in c(3:19)){
  sk$age_int[i] <- str_extract(sk$age[i], "\\d{2}")
}
sk
#          age total  man wom total_prop man_prop wom_prop age_int
# 2    1 - 4세     0    0   0          0        0        0       1
# 3    5 - 9세     2    0   2          0        0        0       5
# 4  10 - 14세    49   23  26          2        1        2      10
# 5  15 - 19세   266  141 125         10       10       10      15
# 6  20 - 24세   640  339 301         19       19       19      20
# 7  25 - 29세   831  510 321         23       27       19      25
# 8  30 - 34세   809  517 292         25       31       19      30

#5. 원하는 분석 형태로 가공
# 극단적 선택의 비율이 높다? 동일 인구수 대비 극단적 선택을 많이 하는 나이, 성별 찾기
# -> 총 인구수 비율의 평균보다 크면 동일 인구수 대비 극단적 선택을 많이 하는 것으로 볼 수 있다.

# 1. mean
summary(sk$total_prop)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.00   21.00   29.00   28.74   32.50   65.00

# 2. 총 인구의 10만명당 자살인구 수가 많은 레코드만 나오도록. 내림차순으로
sk_edit <- sk %>% filter(man_prop >= mean(total_prop) | wom_prop >= mean(total_prop)) %>%
  select(age, age_int, total_prop, man_prop, wom_prop) %>%
  arrange(desc(total_prop, man_prop, wom_prop))
sk_edit
#          age age_int total_prop man_prop wom_prop
# 1  85 - 89세      85         65      129       38
# 2  80 - 84세      80         62      110       33
# 3   90세이상      90         57      141       34
# 4  75 - 79세      75         44       76       21
# 5  70 - 74세      70         34       55       15
# 6  55 - 59세      55         31       49       13
# 7  45 - 49세      45         30       42       16
# 8  65 - 69세      65         30       46       16
# 9  50 - 54세      50         29       41       16
# 10 60 - 64세      60         29       43       16
# 11 35 - 39세      35         28       36       19
# 12 40 - 44세      40         28       38       17
# 13 30 - 34세      30         25       31       19

sk_corr <- sk_edit %>% select(age_int, total_prop, man_prop, wom_prop)
str(sk_corr)
sk_corr
corrplot(sk_corr)

#for(i in c("age_int", "total_prop", "man_prop", "wom_prop")){
#  as.numeric(sk_corr$i)}
# -> 왜 안되는거야........

mode(sk_corr$age_int) <- "numeric"
mode(sk_corr$total_prop) <- "numeric"
mode(sk_corr$man_prop) <- "numeric"
mode(sk_corr$wom_prop) <- "numeric"

str(sk_corr)
corrplot(sk_corr)
cor <- cor(sk_corr)
cor
#              age_int total_prop  man_prop  wom_prop
# age_int    1.0000000  0.8488394 0.8743505 0.6834711
# total_prop 0.8488394  1.0000000 0.9674460 0.9396016
# man_prop   0.8743505  0.9674460 1.0000000 0.9269153
# wom_prop   0.6834711  0.9396016 0.9269153 1.0000000

?lm()


install.packages("jsonlite")
library(jsonlite)