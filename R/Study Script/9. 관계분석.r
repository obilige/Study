#### 관계분석 summary ####
# t-test와 anova가 집단의 평균, 분산을 이용해 집단과 집단간의 차이를 비교한 것이라면
# 관계분석은 집단 내 데이터 값들의 관계를 비교, 분석해 파악하는 것이라 이해하면 된다.

# 척도 : 연속변수 -> 연속변수(t-test, anova는 명목변수 -> 연속변수) or 질적변수 -> 질적변수

# 상관분석(correlation Test)
# - 연속변수 -> 연속변수
# - 1:1로 서로 동등한 입장에서 관계를 분석
# - 상관계수 -1~0(음의 상관관계), 0(선형관계 X), 0~1(양의 상관관계)
# - 예) 상관계수 +1에 가까운 경우는? 광고비와 매출 = 광고비가 증가하면 매출이 오를까?
# - 예) 상관계수 -1에 가까운 경우는? 운동량과 체중 = 운동 많이하면 체중은 줄어든다.
# - 조심해야할 것 : 1. 이 관계가 인과관계는 아니다. 예) 아이스크림 판매량 늘어날수록 바닷가에서 사고 많이 일어나.
# - 조심해야할 것 : 2. 상관분석 = 선형관계. 따라서, 상관계수가 0이라도 특정 패턴을 보이는 경우 존재. (그래프로 꼭 확인해볼 것)
# - 측정방식 : 모수적인 방식(피어슨의 상관계수) // 비모수적인 방식(스피어만의 상관계수 or 켄달의 tau)
# - 수학적인 관계를 판단
# - 회귀분석 전에 관계여부를 파악하기 위한 단계
# - 선형함수

# 회귀분석 : 인과관계 파악하고 인과관계 기반으로 예측까지 하는 것이 이 회귀분석의 목표이자 방향
# - 연속변수 -> 연속변수
# - 인과관계(여러 개의 독립(원인)변수와 하나의 종속(결과)변수)
# - 독립변수의 갯수에 따라 분석방법이 나뉜다.
#   - 독립변수가 하나 : 단일 회귀 분석(실무에서 쓰지 않는다.)
#   - 독립변수가 두개 이상 : 다중 회귀 분석
#   - 계산은 잔차제곱의 합이 가장 작게 되는 직선을 구하는 것
# - 분포에 따라
#   - 정규분포 : 선형회귀분석    lm() *주가, 성적 외엔 크게 쓸 일 없어
#   - 이항분포 : 로지스틱회귀분석 glm() *일반적으로 많이 쓴다. 머신러닝 메인개념
#   - 똑같은 데이터로 분석 둘 다 가능. 연속적으로 파악(다음 성적은 몇점?)해야할 땐 선형회귀, 로지스틱은 둘로 나눠서판단할 때(지금 65점, 다음에 합격할까 불합격할까?)
# - 조건 : plot(fit)
#   1. 선형형 관계 : 회귀분석은 모든 분포된 데이터를 가장 잘 대표하는 회귀선을 찾는 것(lm)
#   2. 정규분포 : 잔차들의 정규분포
#   3. 등분산 :
#   4. 독립성 : 변수들끼리 독립성을 가져야. 그래서, 시점 차이에 따른 분석은 어려울 수 있다.
#     - 다중 공선성으로 독립성을 평가하는데 이 값이 작아야 한다. 통계에선 이 값이 작은 것을 관계없는 것으로 판단
#     - fit = lm(fomula) -> summary(fit) -> vif(fit)



# 교차분석(카이제곱분석) : 질적(명목)변수 -> 질적변수
# - 질적변수 -> 질적변수 : 원인, 결과 모두 질적변수
# - 비율검정
# - chi square test = 데이터 수(기대도수)가 충분히 많을 때 - 판단기준은 데이터테이블에 데이터쉘 갯수. 데이터가 5 이하의 데이터쉘이 전체 데이터 쉘의 20% 이하여야 한다. 만약 데이터쉘 6개일 때 데이터 값이 5 이하인 데이터쉘이 하나라면  16.6% ok! 5 이하 데이터쉘이 두개라면 33.2%로 데이터 부족이 뜬다.
# - Fisher`s exact test = 데이터 수가 부족할 때
# - Cochran-Amitage trend test = 명목변수가 서열변수(trend) - 등급, 서열이 원인변수인 경우를 의미.
# - 기준에 따라 차이검정일수도 있고 관계검정일수도 있다.
# - 일원 카이제곱(차이 검정) : 독립변수 하나(좋아하는 장소)
# - 이원 카이제곱(관계 검정) : 독립변수 두개(좋아하는 장소, 관심사)


#================
#잔차 : 회귀선과 실제 값의 차이, 거리
#편차 : 평균과 평균의 차이
#오차 : 
#================





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





#### 2. 카이제곱분석 ####
### 실습 1. 자동차의 실린더 수와 변속기의 관계가 있는지 알고 싶습니다.
str(mtcars)
head(mtcars)
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






### 실습 2.
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





#### 3. 회귀분석 ####

# 0. 4가지 조건을 확인하는 방법
plot(fit)
#fit은 lm(result ~ reason data = data_name)
#4가지 그래프 보여준다. 이 그래프들이 조건 확인하는 방법이기도 하다.
par(mfrow=c(2, 2))
plot(fit)
par(mfrow=c(1, 1))
#Residuals vs Fitted는 선형성 판단 그래프. 데이터가 무작위로 퍼뜨러져있어야 한다. 패턴을 가지면 선형성 보장 X
#Normal Q-Q는 정규분포 확인 그래프. 데이터 값들이 선에 가까워야 한다.
#Scale-Location은 등분산 확인. 데이터 값들이 무의미하게 퍼져있어야 한다.
#Residuals vs Leverage는 이상치 확인하는 그래프. 다중성 분산 분석에서 사용된다.
#독립성 판단은 그래프로 하기 어려움
#독립성 판단은 수치보다 데이터 테이블 자체(칼럼의 의미 등)를 다 이해하는게 제일 정확함.
#다만, 데이터가 너무 많으면 시간 오래 걸려. 그럴 땐 빠르게 숫자값으로 대체. 이 후 데이터 파악 통해 해결

#절편과 가중치 구하기.
fit <- lm(weight ~ height, data=women)
#정규분포 확인
shapiro.test(resid(fit))

# 1. 단일회귀분석 : 실제로 쓰진 않음. 다만, 원리를 이해하기 위해선 이 것이 가장 좋음
# 회귀분석은 회귀선을 찾는 것. 회귀선은 wx+b이며 기울기(머신러닝에선 가중치) w와 절편 b값을 구해야 알 수 있다.
# 현상 분석을 넘어 예측까지 할 수 있다. 이 것이 회귀분석의 가장 큰 강점

str(women)
#women? 미국 여성을 대상으로 키와 몸무게를 조사한 것. 연령은 30~39

with(women, plot(weight ~ height))

#1. 절편과 가중치 구하기.
fit <- lm(weight ~ height, data=women)
fit

abline(fit, col = "blue")

summary(fit)
# Multiple R-squared:  0.991,	Adjusted R-squared:  0.9903
# R-squared(설명계수)는 0~1 사이의 값을 가지며 1에 가까울수록 회귀선이 완벽해 완벽한 인과관계를 갖는다는 의미
# 1 = 100%, 0.5 = 50%, 0 = 0%
# 원인변수 때문에 결과변수가 도출되는거야! 라고 말할 수 있는 분석

cor.test(women$weight, women$height)
# 0.991(R계수) = 0.9954948(상관계수)^2

# 예측은 어떻게?
# Coefficients:
# (Intercept)       height  
# -87.52            3.45 
# 가중치는 3.45, 절편은 -87.52

# 해당 분석모델에 따르면height가 85인 사람의 몸무게는 얼마인가?
3.45*85-87.52
# 205.73

plot(weight ~ height, data=women)
abline(fit, col = "blue")

#2. 다항회귀분석
# 직선보다 곡선이 데이터 설명하는데 정확할 수 있어. 그럴 땐 y=x^+4x+4와 같은 이차함수 그래프 이용하면 된다.
# 예측에선 사용하기 어렵다. 예측은 직선만 가능
# 통계도 100% 예측은 어렵다.
plot(weight ~ height, data=women)
abline(fit, col = "blue")

fit2 <- lm(weight ~ height + I(height^2), data = women)
fit2

summary(fit2)
lines(women$height, fitted(fit2), col="red")

# 다중회귀분석
# w1x1 + w2x2 + w3x3 + ... + b = y // x는 원인, y는 결과
# moonbook acs의 HBP, smoking, age 회귀분석 해봅시다.










#선형회귀분석 실습1
data <- read.csv("../data/regression.csv", fileEncoding = "euc-kr")
data
#active_firms : 사업체 수, urban_park : 도시공원, doctor : 의사수, tris : 폐수 배출 업소, social_welfare : 사회복지시설, kindergarden : 유치원

# 종속변수 : birth_rate
# 독립변수 : kindergarden

# 가설 : 유치원 수가 많은 지역에 합계 출산율도 높은가? 또는 합계 출산율이 유치원 수에 영향을 주는가?
fit <- lm(birth_rate ~ kindergarten, data = data)
summary(fit)
#Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   1.29049    0.05799  22.253   <2e-16 ***
# kindergarten  0.04684    0.01887   2.482   0.0142 *  
# R-squared = 0.039

#그래프 확인
par(mfrow=c(2,2))
plot(fit)

shapiro.test(resid(fit))
#W = 0.95518, p-value = 8.088e-05
# 정규분포가 아니다.
# 지수나 로그로 결과값 크기를 줄여줘본다.


fit2 <- lm(log(birth_rate) ~ log(kindergarten), data = data)
summary(fit2)
# R-squared = 0.044
# 로그 씌워서 값의 크기를 줄였더니 설명력이 조금 좋아졌다.

plot(fit2)
shapiro.test(resid(fit2))
# data:  resid(fit2)
# W = 0.98811, p-value = 0.2227
# 정규분포다.

# 결론 : 정규분포를 따름에도 설명력 차이가 크게 없는걸로 봐선 애초에 두 변수의 관계는 인과관계가 아니다.
# 반대라면 어떨까?


fit3 <- lm(log(kindergarten) ~ log(birth_rate), data = data)
summary(fit3)
# 똑같다. 두 값은 인과관계가 크게 없다.
# 해당 데이터로만 분석했을 때, 유치원 숫자만으론 출산율에 크게 영향을 주지 않는다.
# 설명력이 50%~60% 정도 나오면 인과관계가 있다고 본다.




# 선형회귀분석 실습 2.

# Data from Kaggle : House sales price in kings count, USA

df <- read.csv("../data/kc_house_data.csv", header = T)
str(df)

fit <- lm(price ~ sqft_living, data=df)
shapiro.test(resid(fit))
# 데이터 갯수가 5000개 이상이라 정규분포 확인 불가
summary(fit)
par(mfrow=c(2,2))
plot(fit)


fit <- lm(log(price) ~ log(sqft_living), data=df)
shapiro.test(resid(fit))
# 데이터 갯수가 5000개 이상이라 정규분포 확인 불가
summary(fit)

par(mfrow=c(2,2))
plot(fit)
# log 씌우니 조건에 맞는 그래프가 도출
# 




#### 4. 다중회귀분석 ####
# y = a1x1 + a2x2 + a3x3 + ... + b

house <- read.csv("../data/kc_house_data.csv", header = T)
str(house)

# 집값을 떨어뜨리는 원인을 찾아보자.
# a. 변수들간의 관계는 복잡하다. 따라서 다각적으로 분석하는 시각, 관점이 필요하다.
# b. 좋은 변수들만 골라낼 수 있는 역량이 중요하다. (데이터 가공)
# c. 비슷한 변수들은 독립성이 떨어진다. 분석 전에 독립성 점검 해야한다.
# d. 표준화 계수 : 수영장은 있고 없고(명목), 거실은 크기(연속) ... 피표준화 계수다. 이걸 표준화해야한다.

# 종속변수 : Price // 독립변수 : sqft_living(거실크기) + floors(마루) + waterfront(수영장)


# 1. fomula에 맞는 직선을 먼저 구합시다.
fit2 = lm(price ~ sqft_living + floors + waterfront, data = house)
#lm(result ~ reason1 + reason2 + reason3, data = df)
summary(fit2)
# Coefficients:
# Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -41911.603   5559.022  -7.539 4.91e-14 ***
# sqft_living    270.743      2.002 135.240  < 2e-16 ***
# floors        8443.545   3387.556   2.493   0.0127 *  
# waterfront  830678.216  19881.837  41.781  < 2e-16 ***
#  ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Residual standard error: 251500 on 21609 degrees of freedom
# Multiple R-squared:  0.5308,	Adjusted R-squared:  0.5308
# F-statistic:  8150 on 3 and 21609 DF,  p-value: < 2.2e-16

# R-squared는 인과관계 정도로 설명력이라 함. 1에 가까울수록 설명력이 큼
# 일반적으로 50%~60% 정도면 인과관계가 있다고 판단
# p-value는 인과관계 여부. p-value가 0.05 이하이면 관계가 있는 것이고, 이상이면 관계가 없는 것
# 개별 인과관계도 볼 수 있다. 거실, 수영장은 관계가 있으나 floor는 관계 정도가 떨어짐

# 2. 비표준화 계수 -> 표준화 계수로
install.packages("lm.beta")
library(lm.beta)

fit3 <- lm.beta(fit2)
summary(fit3)
#Coefficients:
#Estimate Standardized Std. Error t value Pr(>|t|)    
#(Intercept) -4.191e+04    0.000e+00  5.559e+03  -7.539 4.91e-14 ***
#sqft_living  2.707e+02    6.773e-01  2.002e+00 135.240  < 2e-16 ***
#floors       8.444e+03    1.242e-02  3.388e+03   2.493   0.0127 *  
#waterfront   8.307e+05    1.958e-01  1.988e+04  41.781  < 2e-16 ***
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

#Residual standard error: 251500 on 21609 degrees of freedom
#Multiple R-squared:  0.5308,	Adjusted R-squared:  0.5308 
#F-statistic:  8150 on 3 and 21609 DF,  p-value: < 2.2e-16
# 다중회귀분석에선 Adjisted R-squared로 설명력 파악



# 3. 원인(독립)변수들의 독립성 - 상관관계 분석
# 독립변수들끼린 상관관계가 없어야 하고, 독립변수와 종속변수는 상관관계가 있어야
# 다중 공선성 : 독립변수들끼리 너무 많이 겹쳐서 발생하는 문제
# 상관관계는 다중 공선성이란 문제 발생 가능성을 점검하는 것.
# 완벽히 파악하기 위해선 상관계수 0.9 이상 / VIF 구하기
# VIF는 일반적으로 10보다 크면 문제가 있다고 판단.
# 더미변수, 원핫인코딩(리커트 척도 -> 0001, 0010, 0100, 1000)일 경우 3 이상이면 오류
# VIF^2 > 2 이면 다중공산성 문제가 있을 것이라 판단하기도 함

# 유의여부 확인(다중공산성 값에 부합하더라도 바로 빼는 것 X)
# 변수 제거
# 주성분 분석
# 다중공산성이 발생한 독립변수들을 합치기(평균 내기, 단 효과가 좋진 않음)
# ...


# 독립변수 : sqft_living, bathrooms, floors, sqft_lot

attach(house)
x <- cbind(sqft_living, bathrooms, floors, sqft_lot)
cor(x)

reg1 <- lm(price ~ sqft_living, data = house)
summary(reg1)

reg2 <- lm(price ~ sqft_living + floors, data = house)
summary(reg2)
#Coefficients:
#Estimate Std. Error t value Pr(>|t|)    
#(Intercept) -50436.05    5775.17  -8.733   <2e-16 ***
#sqft_living    279.28       2.07 134.897   <2e-16 ***
#floors        6458.26    3521.30   1.834   0.0667 

#floors는 p-value가 0.067로 신뢰구간 내에 있어 유의미한 차이가 없다는 결론 내린다. 그런데 estimate 값이나 층수 정의를 생각해보면 가격과 관련이 있어야 정상. 이 변수는 함부러 버릴 수 없다. 이럴 땐, 매개변수, 조절변수인지 판단해봐야 한다.

reg3 <- lm(price ~ sqft_living + floors + sqft_living*floors, data = house)
summary(reg3)
#Estimate 값이 -다. 층수가 커지면 값이 올라야하는데 반대로 estimate와 t-value 값이 -이면 층수가 작아야 값이 커진다는 설명. 이럴 때 다중공선성을 생각해봐야 한다. '너무 많은걸 설명하려는 것이 아닌가?'

#다중공산성 확인해보기
library(car)

vif(reg3)
# 리커트 척도에선 3 이상. 일반적으론 10 이상. 결과값 엄청 큼.
sqrt(vif(reg3))
# 제곱을 했을 땐, 2보다 크면 다중공산성. 결과값 4.9이니 다중공산성 문제가 있다 판단.


reg4 <- lm(price ~ floors + bedrooms, data = house)
summary(reg4)

detach(house)

attach(house)

x <- cbind(floors, bedrooms, waterfront)
cor(x) # 서로 관계없어. 일단 공선성문제는 없겠단 판단 가능
cor(x, price) #0.25 ~ 0.3으로 어느정도 관계 있어보임

reg5 <- lm(price ~ floors + bedrooms + waterfront, data = house)
summary(reg5) # 다만, 설명력이 낮은 것이 아쉽

vif(reg5)


reg6 <- lm(price ~ floors + bedrooms + waterfront + floors*waterfront, data = house)
summary(reg6) # 일단 결과 좋음. 설명력이 0.2대이지만, p-value, estimate 값 모두 충분하고 설명력도 0.2면 유의미한 인과관계는 보이는 것.

vif(reg6)
# vif값이 높은 것은 아쉬우나, 이렇게 p-value와 estimate값이 충분하고 설명력도 어느 정도 있다면 이 waterfront를 버리는건 너무 아쉽다. 즉, 버리지마.




#실습
head(state.x77)
# 데이터를 본 다음 가장 먼저할 것은 '종속변수', 즉 결과 설정
# 실습에선 Murder로
# 독립변수(원인)은 Popluation, Income, Illiteracy, Frost

# state.x77은 데이터프레임 아니다. 데이터프레임으로 가공


df <- as.data.frame(state.x77[, c("Murder", "Population", "Income", "Illiteracy", "Frost")])
head(df)

attach(df)
x <- cbind(Murder, Population, Income, Illiteracy, Frost)
cor(x)

fit <- lm(Murder ~ Population + Income + Illiteracy + Frost, data = df)
summary(fit)
fit

vif(fit)
sqrt(vif(fit))

# 믿어야 하나? 다중회귀분석에선 추가로 조건에 fit한지 판단.
# 이상치 여부 확인
# 이상치(outlier) : 표준편차보다 2배 이상 크거나 작은 값
# 큰 지레점(High Leverage Point) : p(절편을 포함한 인자들의 숫자)/n(전체 갯수)보다 2배에서 3배 크거나 작은 값은 의심
# 인자들의 숫자는 기울기의 숫자. 여기선 a1x1 ~ a4x4. 여기에 절편까지 총 5개. 전체 갯수는 50. 그래서 0.1이 지레점
# 영향 관측치(influential observation, cook`s D)
# 독립변수의 수 / (샘플 수 - 예측인자 수 - 1) 보다 클 경우
# 4 / (50 - 4 - 1 ) = 0.089
# 그래프로 세 가지 이상치를 한번에 살펴볼 수 있음 library(car) -> influenceplot()

par(mfrow=c(1,1))
influencePlot(fit, id = list(method="identify"))
# 1. outlier는 y축 기준으로 2보다 크거나 -2보다 작은 값들이 이상치 후보군
# 2. HLP는 x축 기준으로 0.1(독립변수의 수 / 샘플의 수 - 예측인자의 수 - 1)의 2배~3배보다 큰 것들
# 3. 영향관측치는 원이 큰 것
# 4. 데이터 알고 싶으면 그래프의 원 더블클릭한 후 그래프 우측 상단에 있는 finish 눌러주면 콘솔에 데이터들이 뜬다.
# 5. 일단 예시 데이터엔 결측치가 없다. 있다고 결과가 나오면 해당 칼럼을 불러 독립변수들을 체크해보면 된다.

par(mfrow=c(2,2))
plot(fit)

#1. 정규분포 확인
shapiro.test(resid(fit))

# 만약 정규분포가 아니라면? 어떻게 정규분포로 맞춰줄까? # 결과 변수에 람다승을 해준다.
powerTransform(df$Murder)
summary(powerTransform(df$Murder))
# 0.605542 -> 결과변수에 0.605542배 해주면 좋겠다라는 제안을 주는 것
# 실제론 -2, -1, -0.5, 0, 0.5, 1, 2 로 해준다. 그래서, 1로 계산.
# y^2, y^1, sqrt(y), log(y) or 1, 1/sqrt(y), 1/y, 1/y^2


#2. 선형성을 만족하지 않을 때
#x를 제곱해줘서 그래프를 곡선으로 만들어보기
boxTidwell(Murder ~ Population + Illiteracy, data = df)
# 결과값 보면 완전히 선형성을 이루고 있음을 의미한다.
# 여기에서 lambda는 선형성을 이루지 않을 때 람다승을 해보라는 제안 같은 것. 예시에선 필요없음


# 3. 등분산을 만족하지 않는 경우
ncvTest(fit)
# p-value 확인. 0.05 이상이면 등분산
# 등분산 만족하지 않을 때 교정하는 방법
par(mfrow=c(1,1))
spreadLevelPlot(fit)
#Suggested power transformation:  1.209626 


# 4. 악성 변수 -> 분석 신뢰성 및 성능 upgrade!
# AIC(Akaike's Information Criterion) : 좋은 변수들, 칼럼들을 정해주는 수치
# Backward Stepwise Regression
#   - 모든 독립변수를 대상으로 하나씩 빼며 AIC 측정
# Forward Stepwise Regression
#   - 변수를 하나씩 추가해서 AIC를 측정

fit <- lm(Murder ~ ., data = df)
summary(fit)

fit2 <- lm(Murder ~ Population + Illiteracy, data = df)
summary(fit2)
# p-value, R-squared 값 모두 더 좋아지는 것 확인. 불필요한 독립변수는 빼줘야해.

AIC(fit, fit2)
# df      AIC
# fit   6 241.6429
# fit2  4 237.6565
# AIC값은 작을수록 좋은 것.


# Backward Stepwise Regression
full.mode1 <- lm(Murder ~ ., data = df)
reduced.model <- step(full.mode1, direction = "backward")
reduced.model
# call에 최적의 회귀선을 도출해준다.
# lm(formula = Murder ~ Population + Illiteracy, data = df)


# Fowward Stepwise Regression
empty.mode1 <- lm(Murder ~ 1, data = df)
added.model <- step(empty.mode1, direction = "forward",
                    scope = (Murder ~ Population + Income + Illiteracy + Frost))
added.model
# call에 최적의 회귀선을 도출해준다.
# lm(formula = Murder ~ Population + Illiteracy, data = df)


# AIC만으로 계산하다보니 놓친 부분 있을 수 있어. 혹시 모르니까.
# 그래서 멈추지 않고 다 돌려보고 그 중 최적을 알려주는 함수가 있음
# All Subset Regression
install.packages("leaps")
library(leaps)

result <- regsubsets(Murder ~ ., data = df, nbest=4) #nbest는 최대 몇개의 변수로 돌아가는지 
result # 확인은 그래프로
par(mfrow=c(1,1))
plot(result, scale="adjr2")
#여기선 AIC로 파악X. R계수로 파악. 따라서 값이 높을수록 좋은 것!



#### 실습 ####
mydata <- read.csv("../data/regression.csv", fileEncoding = "euc-kr")
str(mydata)
# 종속변수는 출산율(birth_rate)
# 가장 영향력 있는 변수는?
# 정규성 검증, 등분산성 검증, 다중공선성 검증.
# 독립변수들이 출산율과 어떤 관련이 있나?

attach(mydata)
x <- cbind(birth_rate, dummy, cultural_center, social_welfare, active_firms, pop, urban_park, doctors, tris, kindergarten)
cor(x)

#backward
fit <- lm(birth_rate ~ ., data = mydata)
backward <- step(fit, direction = "backward")
# AIC is -infinity for this model ?

#ALL
install.packages("leaps")
library(leaps)

result <- regsubsets(birth_rate ~ ., data = mydata, nbest = 9)
result
plot(result, scale="adjr2")
