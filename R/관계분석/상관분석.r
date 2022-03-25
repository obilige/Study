#### 1. 선형관계분석 ####

### 실습 1. 담배값 인상 전 매출액과 담배값 인상 후 매출액에 관계가 있는가?
# x는 담배값 인상 전 매출액, y는 담배값 인상 후 매출액
x <- c(70, 72, 62, 64, 71, 76, 0, 65, 75, 72)
y <- c(70, 74, 65, 68, 72, 74, 61, 66, 76, 75)


cor(x, y, method = "pearson")
cor(x, y, method = "spearman")
cor(x, y, method = "kendal")
?cor.test()
cor.test(x, y, alternative = "two.sided", method = "pearson")
plot(x, y)


### 실습 2. 노령인구와 인구증가율엔 상관관계가 있을까?
data <- read.csv("../data/cor.csv", fileEncoding = "euc-kr")
data

#pop_growth : 인구성장률
#eldery_rate : 65세 이상 노인 인구 비율
#finance : 재정자립도
#cultural_center : 인구 10만명당 문화기반 시설수

#wanna get info : 인구 증가율과 노령인구 비율간의 상관관계가 있는가?
plot(data$pop_growth, data$elderly_rate)
cor(data$pop_growth, data$elderly_rate)
# -> -0.41 아주 약간의 음의 관계를 지니고 있음
x <- cbind(data$pop_growth, data$birth_rate, data$elderly_rate, data$finance, data$cultural_center)
cor(x)



### 실습 3.
install.packages("UsingR")
library(UsingR)
str(galton)
# 부모의 키와 자식의 키에 상관관계가 있을까?
# 이 데이터는 회귀분석에서 사용된 샘플

with(galton, cor(child, parent))
plot(galton$parent, galton$child) # -> plot(reason, result)
plot(child ~ parent, data = galton)

cor.test(galton$parent, galton$child)

plot(jitter(child, 5) ~ jitter(parent, 5), data = galton)     
# jitter 중첩된 데이터들을 보여주는 .. plot은 소수점은 생략되어있기에 차이를 완벽하게 보긴 어렵다.
# 앞에서 배운 sunflowerplot(df)도 중첩된 데이터 보여주는..
sunflowerplot(galton)


### 실습 4. 상관관계 시각화
install.packages("SwissAir")
library(SwissAir)

str(AirQual)
table(is.na(AirQual))

Ox <- AirQual[ , c("ad.O3", "lu.O3", "sz.O3")] + 
  AirQual[ , c("ad.NOx", "lu.NOx", "sz.NOx")] -
  AirQual[ , c("ad.NO", "lu.NO", "sz.NO")]

names(Ox) <- c("ad", "lu", "sz")
str(Ox)

#그래프 확인
plot(lu ~ sz, data = Ox)
# 중복된 데이터가 너무 많아 그래프로 확인 어려워. 이럴 때 쓰는 그래프 있음

install.packages("hexbin")
library(hexbin)
plot(hexbin(Ox$lu, Ox$sz, xbin=200))

smoothScatter(Ox$lu.O3, Ox$sz.O3)

install.packages("IDPmisc")
library(IDPmisc)

iplot(Ox$lu.O3, Ox$sz.O3)