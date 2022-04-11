R에서 ANOVA 하는 순서
1.	One-way ANOVA
result = aov(result_column ~ reason_column, data = data_name)
shapiro.test(resid(result)
	p-value 확인

bartlett.test(result_column ~ reason_column, data = data_name)
	p-value 확인

a.	aov분석(모두 정규분포, 등분산일 경우)
summary(result)
	result = aov(result_column ~ reason_column, data = data_name)
	p-value 확인
TukeyHSD(result)
	3개 이상의 그룹 중 어떤 그룹들이 기각영역에 있는지 파악


b.	Kruskal분석(정규분포가 아닐 때)
kruskal.test(result_column ~ reason_column, data = data_name)
	p-value 확인
install.packages("pgirmess")
library(pgirmess)
kruskalmc(data_name$result_column, data_name$reason_column)

c.	welch’s ANOVA(등분산이 아닐 때)
oneway.test(result_column ~ reason_column, data = data_name)
	p-value 확인
install.packages("nparcomp")
library(nparcomp)
result <- mctp(result_column ~ reason_column, data = data_name)
summary(result)





#### 사례 1. ONE WAY ANNOVA ####

# Sample 준비
library(moonBook)
moonBook::acs
str(acs)
head(acs)

# 결과(종속)변수 : LDLC(콜레스트롤 수치)
# 원인(독립)변수 : Dx(진단결과) -> STEMI(급성심근경색), NSTEMI(만성심근경색), unstable angina(협심증)
# 0. 데이터 파악해보기
table(acs$Dx)
table(is.na(acs$LDLC))
# FALSE  TRUE 
#   833    24 


# 1. 정규분포인지 확인(실제론 데이터가 800개가 넘으니 중심극한정리 원리에 따라 굳이 할 필요 없다.)
moonBook::densityplot(LDLC ~ Dx, data=acs)
# STEMI와 Unstable Angina는 끝까지 값이 이어져있다보니 정규분포라고 하기 어렵다. 결측치로 보이기도 한다.
with(acs, shapiro.test(LDLC[Dx == 'NSTEMI']))
# p-value = 1.56e-08
with(acs, shapiro.test(LDLC[Dx == 'STEMI']))
# p-value = 0.6066
with(acs, shapiro.test(LDLC[Dx == 'Unstable Angina']))
p-value = 2.136e-07

# 정규분포 확인하는 또 다른 방법(aov -> shapiro.test(resid()))
out = aov(LDLC ~ Dx, data=acs)
out
#                      Dx Residuals
# Sum of Squares    18765   1386306
# Deg. of Freedom       2       830
# -> resid(out)
shapiro.test(resid(out))
# p-value = 1.024e-11

# 2. 등분산인지 확인(실제론 데이터 800개가 넘으니 굳이 할 필요 없음)
bartlett.test(LDLC ~ Dx, data = acs)
# 등분산 : p-value = 0.1857



### 분석 1. ANOVA
out = aov(LDLC ~ Dx, data=acs)
summary(out)
#              Df  Sum Sq Mean Sq F value  Pr(>F)   
# Dx            2   18765    9382   5.617 0.00377 **
# Residuals   830 1386305    1670                   
# pr값이 p-value! 0.00377. **은 확실하게 차이가 있단 뜻. *은 차이가 애매하단 뜻


### 분석 2. Kruskal-wallis H test(정규분포 아니거나 결과(종속)변수가 연속변수가 아닌 경우)
kruskal.test(LDLC ~ Dx, data=acs)
# data:  LDLC by Dx
# Kruskal-Wallis chi-squared = 10.733, df = 2, p-value = 0.004669
# -> p-value가 0.0046으로 통계적으로 유의미한 차이가 존재함을 알 수 있다.


### 분석 3. welch's ANOVA
oneway.test(LDLC ~ Dx, data=acs, var.equal = F)
#oneway.test는 aov와 똑같은 함수. 다만, var.equal 인수가 없음. 그래서 등분산이 아닐 땐 var.equal = F를 입력할 수 있는 oneway.test()를 써준다.


### 분석 4. 사후검정 : 어떤 함수를 사용했느냐에 따라 방식이 달라진다.

# aov 사용 시 -> TukeyHSD()
TukeyHSD(out) # out <- aov(LDLC ~ Dx, data=acs)
#                              diff       lwr        upr     p adj
# STEMI-NSTEMI            -9.370105 -19.04130  0.3010954 0.0599378
# Unstable Angina-NSTEMI -13.217357 -22.47817 -3.9565482 0.0024227
# Unstable Angina-STEMI   -3.847252 -11.25450  3.5599980 0.4419434
# -> Unstable Angina-NSTEMI의 P adj(p-value) 값이 0.002로 차이가 있음을 알 수 있다. 이 외 나머지는 0.5 이상으로 차이 없다.


# Kruskal.test 사용시 -> pgirmess
install.packages("pgirmess")
library(pgirmess)

kruskalmc(acs$LDLC, acs$Dx)
#                         obs.dif critical.dif difference
# NSTEMI-STEMI           42.08483     58.05532      FALSE
# NSTEMI-Unstable Angina 74.40956     55.59177       TRUE
# STEMI-Unstable Angina  32.32473     44.46503      FALSE
# -> NSTEMI-Unstable Angina가 다름을 diffence에 TRUE 값으로 보여준다.


# oneway.test()를 사용했을 경우
install.packages("nparcomp")
library(nparcomp)

result <- mctp(LDLC ~ Dx, data = acs)
summary(result)

#----Data Info-------------------------------------------------------------------------# 
#            Sample Size    Effect     Lower     Upper
# 1          NSTEMI  148 0.5466111 0.5189087 0.5740277
# 2           STEMI  294 0.4961078 0.4723244 0.5199088
# 3 Unstable Angina  391 0.4572811 0.4350779 0.4796554

#----Analysis--------------------------------------------------------------------------# 
#       Estimator  Lower  Upper Statistic     p.Value
# 2 - 1    -0.051 -0.117  0.016    -1.785 0.174774252
# 3 - 1    -0.089 -0.152 -0.026    -3.310 0.002941821
# 3 - 2    -0.039 -0.092  0.014    -1.725 0.195780656

# -> 3과 1. Unstabale Angina와 NSTEMI의 p.Value가 0.00294로 다름을 확인할 수 있다.









# 실습 1.
head(iris)
table(iris$Species)

# 주제 : 품종별로 Sepal.Width의 평균 차이 있는가?
# 만약 있다면 어느 품종과 차이가 있는가?
# 원인 = 품종 / 결과 = Sepal.Width

analysis = aov(Sepal.Width ~ Species, data=iris)
analysis
shapiro.test(resid(analysis))
# p-value = 0.323
# -> 정규분포 따름

bartlett.test(Sepal.Width ~ Species, data = iris)
# p-value = 0.3515
# -> 등분산

#aov로 분석 가능
summary(analysis)
# -> <2e-16 ***
# 차이 난다. 격하게

TukeyHSD(analysis)
#                        diff         lwr        upr     p adj
# versicolor-setosa    -0.658 -0.81885528 -0.4971447 0.0000000
# virginica-setosa     -0.454 -0.61485528 -0.2931447 0.0000000
# virginica-versicolor  0.204  0.04314472  0.3648553 0.0087802
# p adj값이 모두 0.05 이하이니 3종 모두 차이가 나는 것을 확인할 수 있다.


library(ggplot2)
ggplot(iris, aes(Sepal.Width, Sepal.Length)) + geom_point(aes(colour = Species))









# 실습 2.
mydata <- read.csv("../data/anova_one_way.csv", fileEncoding = "euc-kr")
head(mydata)
table(mydata$ad_layer)

# 주제 : 시, 구, 군에 따라서 합계 출산율에 차이가 있는가?
# 만약 있다면 어느 것과 차이가 있는가?
# 원인(독립변수) : 시, 구, 군 // 결과(종속변수 : 합계 출산율)

city = aov(birth_rate ~ ad_layer, data = mydata)
shapiro.test(resid(city))
# -> p-value = 5.788e-07 정규분포를 따르지 않는다.
bartlett.test(birth_rate ~ ad_layer, data = mydata)
# -> p-value = 9.659e-05 등분산 아니다.

# 1. aov
summary(city)
# pr값은 2e-16 ***. 엄청나게 차이난다.
TukeyHSD(city)
# adj 값 모두 0.05 이하의 값을 보이므로 셋 평균 모두 서로가 서로를 기각하는 영역에 있음


# 2. Kruskal-wallis H test
kruskal.test(birth_rate ~ ad_layer, data = mydata)
# ->  p-value < 2.2e-16

library(pgirmess)

kruskalmc(mydata$birth_rate, mydata$ad_layer)
#                obs.dif critical.dif difference
# 자치구-자치군 87.57423     25.57137       TRUE
# 자치구-자치시 72.67130     26.11097       TRUE
# 자치군-자치시 14.90293     25.00975      FALSE
# -> 자치구와 자치군, 자치구와 자치시의 평균이 기각 영역에 있음. 구와 군, 구와 시의 출산율이 다름.


# 3. one-way test
oneway.test(birth_rate ~ ad_layer, data = mydata, var.equal = F)
# -> p-value < 2.2e-16 . 출산율 평균 다르다.

library(nparcomp)

result <- mctp(birth_rate ~ ad_layer, data = mydata)
summary(result)

#----Analysis--------------------------------------------------------------------------# 
#       Estimator  Lower Upper Statistic      p.Value
# 2 - 1     0.388  0.298 0.470     9.567 4.440892e-16
# 3 - 1     0.324  0.243 0.401     8.999 1.887379e-15
# 3 - 2    -0.063 -0.153 0.027    -1.656 2.256901e-01

moonBook::densityplot(birth_rate ~ ad_layer, data = mydata)











# 실습
library(dplyr)
telco <- read.csv("../data/Telco-Customer-Churn.csv", header = T)
head(telco)

#독립변수 : PaymentMethod   (지불방식)
#종속변수 : TotalCharges    (총 지불 금액)

table(telco$PaymentMethod)
str(telco)


table(is.na(telco$TotalCharges))
# 평균 같은 기술 통계에 대한 내용부터 파악
telco %>% select(PaymentMethod, TotalCharges) %>%
  group_by(PaymentMethod) %>%
  summarise(count = n(), avg = mean(TotalCharges, na.rm = T), sd = sd(TotalCharges, na.rm = T))




# 지불방식별로 총 지불 금액이 차이가 있는가?

#1. 정규분포 확인
shapiro.test(resid(analysis))
# sample size must be between 3 and 5000
# 5000개 이상이면 불가능. 굳이 해야겠다면 따로따로

with(telco, shapiro.test(TotalCharges[PaymentMethod ==  'Bank transfer (automatic)']))
with(telco, shapiro.test(TotalCharges[PaymentMethod ==  'Credit card (automatic)']))
with(telco, shapiro.test(TotalCharges[PaymentMethod ==  'Electronic check']))
with(telco, shapiro.test(TotalCharges[PaymentMethod ==  'Mailed check']))

# 귀찮으면 '앤더슨 달링 테스트'


# 공분산 테스트
bartlett.test(TotalCharges ~ PaymentMethod, data=telco)
# 2.2e-16
# 공분산 X


# Welch's test
oneway.test(TotalCharges ~ PaymentMethod, data=telco, var.equal = F)
# 2.2e-16
# 통계적으로 분명한 차이 존재.


# library(nparcomp)
library(nparcomp)
result <- mctp(TotalCharges ~ PaymentMethod, data=telco)
summary(result)



# 정규분포가 아니라는 가정 하에 테스트
kruskal.test(TotalCharges ~ PaymentMethod, data=telco)
# 	p-value 확인 : 2.2e-16
install.packages("pgirmess")
library(pgirmess)
kruskalmc(telco$TotalCharges, telco$PaymentMethod)





# 시각화
moonBook::densityplot(TotalCharges ~ PaymentMethod, data=telco)
ggplot(telco, aes(PaymentMethod, TotalCharges)) + geom_boxplot(aes(colour = PaymentMethod))
# 박스플롯으로 데이터시각화
# 4 데이터 값의 전반적인 추이 알 수 있고 이상치에 대해서도 알 수 있다.















#### 4. TWO WAY ANOVA ####

# One Way ANOVA와 비슷

mydata <- read.csv("../data/anova_two_way.csv", fileEncoding = "euc-kr")
mydata

#독립(원인)변수 : ad_layer, multichild
#독립변수가 2개이며, 그룹은 시, 군, 구 // 다자녀 yes, no3*2로 6개의 그룹이 생긴다.
#결과(종속)변수 : birth_rate


out <- aov(birth_rate ~ ad_layer + multichild + ad_layer:multichild, data = mydata)
shapiro.test(resid(out))
# p-value = 2.862e-06

summary(out)           
#                      Df Sum Sq Mean Sq F value Pr(>F)    
# ad_layer              2  4.722  2.3608  46.312 <2e-16 ***
# multichild            1  0.108  0.1082   2.122 0.1466    
# ad_layer:multichild   2  0.377  0.1886   3.699 0.0263 *  
# Residuals           220 11.215  0.0510                   

# 시군구의 출산율 평균은 통계적으로 유의미한 차이가 존재. 추가 분석 필요
# 다자녀 여부는 출산율 평균에 유의미한 차이를 만들지 못함.
# 다만, 시군구와 다자녀에 따른 출산율 평균은 통계적으로 유의미한 차이가 있음 따라서 추가 분석 필요




result <- TukeyHSD(out)
result

#자치군 YES, 자치구 NO
#자치군 YES, 자치시 NO

mydata %>% select(ad_layer, multichild, birth_rate) %>%
  group_by(ad_layer, multichild) %>%
  summarise(count = n(), mean = mean(birth_rate), sd=sd(birth_rate))
  

ggplot(mydata, aes(birth_rate, ad_layer, col = multichild)) + geom_boxplot()


#결론 :
# 자치군에 거주하며 지원 정책을 받는 가구의 출산율 평균이 자치구, 자치시에 거주하며 지원 정책을 받지 못하는 가구의 출산율 평균과 유의미한 차이를 보임.
# -> 자치군에 거주하는 가구를 대상으로 지원 정책이 효과가 있을 것으로 예상

# 단, 데이터 상에 자치군에 거주하며 지원 정책을 받는 가구의 수가 4 밖에 없어 이에 대한 데이터 수를 조금 더 확보하고 다시 한번 분석할 필요가 있어 보임. (다자녀 지원 정책을 받는 가구의 출산율 데이터 확보 필요)



#### 실습 2. 오늘 실습 과제 ####

library(dplyr)
telco <- read.csv("../data/Telco-Customer-Churn.csv", header = T)
head(telco)

#독립변수 : PaymentMethod, Contract
#종속변수 : TotalCharges

table(telco$Contract)
out <- aov(TotalCharges ~ PaymentMethod + Contract + PaymentMethod:Contract, data = telco)
summary(out)

result <- TukeyHSD(out)
result

#Credit card (automatic):Month-to-month-Bank transfer (automatic):Month-to-month 0.9998834
#Electronic check:Month-to-month-Bank transfer (automatic):Month-to-month        0.0001746
#Mailed check:Month-to-month-Bank transfer (automatic):Month-to-month            0.0000000
#Bank transfer (automatic):One year-Bank transfer (automatic):Month-to-month     0.0000000
#Credit card (automatic):One year-Bank transfer (automatic):Month-to-month       0.0000000
#Electronic check:One year-Bank transfer (automatic):Month-to-month              0.0000000
#Mailed check:One year-Bank transfer (automatic):Month-to-month                  0.0708340
#Bank transfer (automatic):Two year-Bank transfer (automatic):Month-to-month     0.0000000
#Credit card (automatic):Two year-Bank transfer (automatic):Month-to-month       0.0000000
#Electronic check:Two year-Bank transfer (automatic):Month-to-month              0.0000000
#Mailed check:Two year-Bank transfer (automatic):Month-to-month                  1.0000000
#Electronic check:Month-to-month-Credit card (automatic):Month-to-month          0.0137222
#Mailed check:Month-to-month-Credit card (automatic):Month-to-month              0.0000000
#Bank transfer (automatic):One year-Credit card (automatic):Month-to-month       0.0000000
#Credit card (automatic):One year-Credit card (automatic):Month-to-month         0.0000000
#Electronic check:One year-Credit card (automatic):Month-to-month                0.0000000
#Mailed check:One year-Credit card (automatic):Month-to-month                    0.3535420
#Bank transfer (automatic):Two year-Credit card (automatic):Month-to-month       0.0000000
#Credit card (automatic):Two year-Credit card (automatic):Month-to-month         0.0000000
#Electronic check:Two year-Credit card (automatic):Month-to-month                0.0000000
#Mailed check:Two year-Credit card (automatic):Month-to-month                    0.9999969
#Mailed check:Month-to-month-Electronic check:Month-to-month                     0.0000000
#Bank transfer (automatic):One year-Electronic check:Month-to-month              0.0000000
#Credit card (automatic):One year-Electronic check:Month-to-month                0.0000000
#Electronic check:One year-Electronic check:Month-to-month                       0.0000000
#Mailed check:One year-Electronic check:Month-to-month                           1.0000000
#Bank transfer (automatic):Two year-Electronic check:Month-to-month              0.0000000
#Credit card (automatic):Two year-Electronic check:Month-to-month                0.0000000
#Electronic check:Two year-Electronic check:Month-to-month                       0.0000000
#Mailed check:Two year-Electronic check:Month-to-month                           0.0094291
#Bank transfer (automatic):One year-Mailed check:Month-to-month                  0.0000000
#Credit card (automatic):One year-Mailed check:Month-to-month                    0.0000000
#Electronic check:One year-Mailed check:Month-to-month                           0.0000000
#Mailed check:One year-Mailed check:Month-to-month                               0.0000000
#Bank transfer (automatic):Two year-Mailed check:Month-to-month                  0.0000000
#Credit card (automatic):Two year-Mailed check:Month-to-month                    0.0000000
#Electronic check:Two year-Mailed check:Month-to-month                           0.0000000
#Mailed check:Two year-Mailed check:Month-to-month                               0.0000000
#Credit card (automatic):One year-Bank transfer (automatic):One year             1.0000000
#Electronic check:One year-Bank transfer (automatic):One year                    0.0053433
#Mailed check:One year-Bank transfer (automatic):One year                        0.0000000
#Bank transfer (automatic):Two year-Bank transfer (automatic):One year           0.0000000
#Credit card (automatic):Two year-Bank transfer (automatic):One year             0.0000001
#Electronic check:Two year-Bank transfer (automatic):One year                    0.0000000
#Mailed check:Two year-Bank transfer (automatic):One year                        0.0000000
#Electronic check:One year-Credit card (automatic):One year                      0.0166337
#Mailed check:One year-Credit card (automatic):One year                          0.0000000
#Bank transfer (automatic):Two year-Credit card (automatic):One year             0.0000000
#Credit card (automatic):Two year-Credit card (automatic):One year               0.0000006
#Electronic check:Two year-Credit card (automatic):One year                      0.0000000
#Mailed check:Two year-Credit card (automatic):One year                          0.0000000
#Mailed check:One year-Electronic check:One year                                 0.0000000
#Bank transfer (automatic):Two year-Electronic check:One year                    0.3778792
#Credit card (automatic):Two year-Electronic check:One year                      0.9002954
#Electronic check:Two year-Electronic check:One year                             0.0000000
#Mailed check:Two year-Electronic check:One year                                 0.0000000
#Bank transfer (automatic):Two year-Mailed check:One year                        0.0000000
#Credit card (automatic):Two year-Mailed check:One year                          0.0000000
#Electronic check:Two year-Mailed check:One year                                 0.0000000
#Mailed check:Two year-Mailed check:One year                                     0.2029763
#Credit card (automatic):Two year-Bank transfer (automatic):Two year             0.9985283
#Electronic check:Two year-Bank transfer (automatic):Two year                    0.0000000
#Mailed check:Two year-Bank transfer (automatic):Two year                        0.0000000
#Electronic check:Two year-Credit card (automatic):Two year                      0.0000000
#Mailed check:Two year-Credit card (automatic):Two year                          0.0000000
#Mailed check:Two year-Electronic check:Two year                                 0.0000000

telco %>% select(PaymentMethod, Contract, TotalCharges) %>%
  group_by(PaymentMethod, Contract) %>%
  summarise(count = n(), mean = mean(TotalCharges, na.rm = T), sd=sd(TotalCharges, na.rm = T))
#  PaymentMethod             Contract       count  mean    sd
#  <chr>                     <chr>          <int> <dbl> <dbl>
# 1 Bank transfer (automatic) Month-to-month   589 1887. 1736.
# 2 Bank transfer (automatic) One year         391 3313. 2161.
# 3 Bank transfer (automatic) Two year         564 4166. 2480.
# 4 Credit card (automatic)   Month-to-month   543 1806. 1762.
# 5 Credit card (automatic)   One year         398 3357. 2235.
# 6 Credit card (automatic)   Two year         581 4060. 2520.
# 7 Electronic check          Month-to-month  1850 1471. 1654.
# 8 Electronic check          One year         347 3853. 2160.
# 9 Electronic check          Two year         168 5273. 2216.
# 10 Mailed check             Month-to-month   893  551.  884.
# 11 Mailed check             One year         337 1483. 1528.
# 12 Mailed check             Two year         382 1870. 1879.



# 결론
#Mailed check:Two year-Mailed check:One year                                     0.2029763
#Credit card (automatic):Two year-Bank transfer (automatic):Two year             0.9985283

#Bank transfer (automatic):Two year-Electronic check:One year                    0.3778792
#Credit card (automatic):Two year-Electronic check:One year                      0.9002954

#Credit card (automatic):One year-Bank transfer (automatic):One year             1.0000000

#Mailed check:One year-Electronic check:Month-to-month                           1.0000000
#Mailed check:Two year-Credit card (automatic):Month-to-month                    0.9999969

#Mailed check:One year-Credit card (automatic):Month-to-month                    0.3535420
#Mailed check:One year-Bank transfer (automatic):Month-to-month                  0.0708340

#Credit card (automatic):Month-to-month-Bank transfer (automatic):Month-to-month 0.9998834
#신용카드 월 계약 - 수표 월계약 지출 평균








#### 실습 3. RM anova ####

df <- read.csv("../data/onewaySample.csv")
df

# 7명의 학생이 4번의 시험을 봤다.
# 평균 차이가 존재하는가?
# 있다면 어느 기간과 기간 사이에 차이가 있는가?

# 필요없는 데이터는 지워줍니다.
df <- df[, 2:6]
df

summary(df)
#      id          score0          score1          score3          score6     
# Min.   :1.0   Min.   :52.00   Min.   :34.00   Min.   :21.00   Min.   :12.00  
# 1st Qu.:2.5   1st Qu.:55.50   1st Qu.:35.00   1st Qu.:22.50   1st Qu.:13.50  
# Median :4.0   Median :58.00   Median :38.00   Median :25.00   Median :16.00  
# Mean   :4.0   Mean   :58.29   Mean   :37.57   Mean   :24.29   Mean   :15.71  
# 3rd Qu.:5.5   3rd Qu.:61.00   3rd Qu.:39.50   3rd Qu.:25.50   3rd Qu.:17.00  
# Max.   :7.0   Max.   :65.00   Max.   :42.00   Max.   :28.00   Max.   :21.00  

mean <- c(58.29, 37.57, 24.29, 15.71)
plot(mean, type = "o", lty = 2, col = 2)














#### 4. 예제

df <- read.csv("../data/test_t.csv")