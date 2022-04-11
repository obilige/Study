#### 2. 카이제곱분석 ####

# 실습 1. 
str(mtcars)
head(mtcars)

# 주제 : 자동차의 실린더 수와 변속기의 관계가 있는지 알고 싶습니다.
# 실린더 수, 변속기 모두 명목변수다. 실린더 수는 숫자이지만 연속된 값은 아니다. 1개, 2개로 셀 수 있기 때문

table(mtcars$cyl, mtcars$am)

# 테이블의 가독성 확보(전처리)

mtcars$tm <- ifelse(mtcars$am==0, "auto", "manual")
result <- table(mtcars$cyl, mtcars$tm)
result
#   auto manual
# 4    3      8
# 6    4      3
# 8   12      2

barplot(result, ylim = c(0, 20), legend = rownames(result))
mylegend <- paste(rownames(result), "cyl")
# paste는 rownames 뒤에 글자 덧붙일 때 사용한다.
barplot(result, ylim = c(0, 20), legend = mylegend, beside=T)

# barplot 실행 시 Error in plot.new() : figure margins too large 뜨면?
par("mar")
par(mar=c(1, 1, 1, 1))
barplot(result, ylim = c(0, 20), legend = mylegend, beside=T, horiz = T, col = c("tan1", "coral2", "firebrick2"))

# result 아래에 합계 추가하고 싶다면?
addmargins(result)
#     auto manual Sum
# 4      3      8  11
# 6      4      3   7
# 8     12      2  14
# Sum   19     13  32

# 카이제곱 검정
chisq.test(result)
# p-value = 0.01265로 관계가 있는 것으로 결론 내면 된다.
# 단, Warning Message로 정확하지 않다고 뜨면 데이터 수를 체크해봐야 한다.
# 데이터 수가 부족하다. 3, 4 ... 20%를 넘는다. 이 땐, Fisher`s exact test를 써야한다.`
fisher.test(result)
# p-value = 0.009105으로 관계가 있는 것으로 결론.






# 실습 2.

df <- read.csv("../data/anova_two_way.csv", fileEncoding = "euc-kr")
df

#주제 : ad_layer(시군구)는 multichild(다가구 지원 정책 여부)가 관계가 있는가? 

result <- table(df$ad_layer, df$multichild)
result

barplot(result, legend = rownames(result), col = c("tan1", "coral2", "firebrick2"))
# 그래프 가독성 떨어지니 변경
result1 <- table(df$multichild, df$ad_layer)
result1

barplot(result1, legend = rownames(result1), col = c("tan1", "coral2", "firebrick2"))

chisq.test(result)
# No! 데이터 수 작아
fisher.test(result)
# 0.7로 귀무가설. 관계 없음으로 결론




# 실습 3.
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss("../data/koweps_hpc10_2015_beta1.sav", to.data.frame = T)
welfare <- rename(raw_welfare, sex=h10_g3, birth=h10_g4, marriage=h10_g10,
                  religion=h10_g11, income=p1002_8aq1, code_job=h10_eco9,
                  code_region=h10_reg7)
head(welfare)
welfare <- welfare[, c("sex", "birth", "marriage", "religion", "income",
                       "code_job", "code_region")]
head(welfare)

#성별과 종교는 서로 연관성이 있는가?
result <- table(welfare$sex, welfare$religion)
chisq.test(result)
#겁나게 관계 있음



# 실습 4. Cochran-Amitage trend test = 명목변수가 서열변수(trend) - 등급, 서열이 원인변수인 경우를 의미.
# prop.trend.test
library(moonBook)
str(acs)

# 주제 : 흡연 여부와 고혈압의 유무가 서로 연관이 있는가?
result <- table(acs$HBP, acs$smoking)
result
#    Ex-smoker Never Smoker
# No         81    99    176
# Yes       123   233    145

#비흡연자, 흡연 끊은 사람, 흡연자로 순서 구분할 수 있다. 서열변수!
#순서 바꿔봅시다.

acs$smoking <- factor(acs$smoking, levels = c("Never", "Ex-smoker", "Smoker"))
result <- table(acs$HBP, acs$smoking)
result

barplot(result, legend = rownames(result), col = c("tan2", "firebrick2"))

chisq.test(result) # 담배와 고혈압은 관계가 있다.
?prop.trend.test()
# x : 사건이 발생한 횟수(고혈압 발생한 사람의 수)
# yes인 사람
result[2, ]
# y : 시도한 횟수(담배 피는 사람의 수)
colSums(result)

prop.trend.test(result[2,], colSums(result))
# -> p-value는 0.05 이하. 순서, 등급으로서 의미가 있다. 단, 이 것이 상관관계 혹은 인과관계를 의미하진 않는다. 오류에 빠지지 않도록 유의할 것. 담배를 피면 고혈압이 생긴다란 결론 X

mosaicplot(result, col = c("skyblue3", "grey74", "coral2"))
#행과 열 바꾸기
mosaicplot(t(result), col = c("skyblue3", "grey74", "coral2"), xlab = "Smoking", ylab = "HyperTension")
#색상명 확인은 어떻게?
colors()
demo("colors")

mytable(smoking ~ age, data=acs)
# 담배를 피우는 사람들은 나이가 어리고 담배를 피우지 않는 사람들은 나이가 많다.
# 담배와 고혈압의 관계에서 실제 원인은 나이 때문이었다.
# 두 변수만으로 결론을 내리면 이런 오류에 빠질 가능성이 높다.