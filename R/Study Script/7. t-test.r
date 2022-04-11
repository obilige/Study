#### POWER ANALYSIS ####
# t-test한 Sample의 갯수가 충분한지 판단하는 방법
# cohens'd : 두 집단의 평균 차이를 (두 집단의 표준편차의 합) / 2로 나눠준다.
# 빅데이터는 할 필요 없음. 다만 소량의 데이터로 통계분석할 땐 이 단계를 거쳐야 한다.
# 일반적이지 않음. 특수한 분야에서 사용

# [신뢰구간에서 벗어난 통계적으로 유의미한 차이가 있는지 판단하는 T-TEST]
# 1. 데이터 갯수 : 30개 이하면 POWER ANALYSIS 시행
# -> effective_size <- abs(mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2)
#    effective_size
#    pwr.t.test(d = effective_size, alternative = "two.sided", type ="two.sample" , power = .8, sig.level = .05)

# 2. 데이터가 정규분포를 따르는지 파악
# -> shapiro.test()

# 3. 두 데이터가 등분산인지 파악
# -> var.test((mtcars$mpg ~ mtcars$am, data = mtcars))

# 4. 정규분포, 등분산이면 t.test(mtcars$mpg ~ mtcars$am, data = mtcars, alt = "two.sided", bar.equal = T)
# -> 종속변수 ~ 독립변수

# 5. 정규분포가 아니거나 등분산 아니면 : wilcox.test(age ~ sex, data=acs)









ky <- read.csv("../data/ky.csv", header = T)
ky
str(ky)
table(ky$group) # table(데이터명$필터명)으로 갯수 확인할 수 있다. 유용하니 반드시 기억합시다.
#  1  2 
# 20 20 

# 두 집단의 빈도수가 같음을 확인! 이제 POWER라는 패키지로 샘플 수가 충분한지 판단 가능.

install.packages("pwr")
library(pwr)

mean1 <- mean(ky$score[which(ky$group == 1)])
mean2 <- mean(ky$score[ky$group == 2])
cat(mean1, ', ', mean2)
sd1 <- sd(ky$score[ky$group == 1])
sd2 <- sd(ky$score[ky$group == 2])
cat(sd1, ',', sd2)

effective_size <- abs(mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2)
effective_size

# sqrt는 루트 씌워주는 것

pwr.t.test(d = effective_size, alternative = "two.sided", type ="two.sample" , power = .8, sig.level = .05)
#n = 17.63116 -> 각 그룹의 표본 갯수가 18개면 된다란 의미. ky 데이터 내 각 그룹은 20개이니 충분하다.
#일반적으로 30개 정도면 충분하다고 이야기 한다.
#d = 0.9719389
#sig.level = 0.05
#power = 0.8
#alternative = two.sided


# alternative : 양측검정할 것인가? 아니면 왼쪽이나 오른쪽만 검정할 것인가?
# type : 몇개의 샘플을 검정할 것인가?
# power : 귀무가설을 대립가설로 잘못 판단 or 대립가설을 귀무가설로 잘못 판단할 확률 설정. 일반적으로 .8로 정함
# sig.level : 신뢰구간. 5%가 기본값.
# d : cohen s d 값을 넣어줍니다.











#### 사례 1. ####

# 두 집단의 평균비교 : Two Sample t-test
install.packages("moonBook")
library(moonBook)

?acs
# 경기도에 소재한 대학 병원에서 2년동안 내원한 급성 관상동맥증후군 환자 대상 조사
# 실제 데이터입니다.

head(acs)
summary(acs)
table(acs$sex)

#가설 설정해봅시다.
#주제 1. 두 집단(남, 녀)의 나이 차이
# 귀무가설 : 남성과 여성의 나이 차이는 존재하지 않는다. (연구할 필요 없다.)
# 대립가설 : 남성과 여성의 나이 차이는 존재한다. (연구할 필요 있다.)
mean.man <- mean(acs$age[acs$sex == "Male"])
mean.woman <- mean(acs$age[acs$sex == "Female"])
cat(mean.man, ',', mean.woman)
# 60.61053 , 68.67596
# 통계적으로 유의미한 차이인지 판단하기 위해선 t-test가 필요
# t-test 쓰기 위한 조건
# 1. 결과값이 연속변수이어야 한다. -> 그럼 결과값이 연속변수가 아니면? Mann Whitney U Test // Wilcoxen rank sum test // Mann Whitney Wilcoxen Test(MWW 방식)
# 2. 정규분포 여부 : 평균 기준으로 좌우가 비슷하게 퍼져있는 분포 -> 정규분포가 아니면? MWW
# 3. 등분산 여부 : 비교 대상인 두 정규분포의 퍼짐 정도가 비슷하거나 같은가? 한마디로 분산이 같아야 한다.

# 모수적인 방식 or 비모수적인 방식
# 모수적인 방식은 평균을 신뢰할 수 있을 때, 비모수적인 방식은 평균을 신뢰할 수 없을 때
# 정규분포 따르면 평균을 신뢰할 수 있다. 그래서 모수적인 방식을 택한다. t-test
# 정규분포를 따르지 않으면 평균을 신뢰할 수 없다. 그래서 비모수적인 방식을 택한다. MWW
# 비모수적인 방식의 계산원리는 두 집단의 값들을 다 나열한다.

# 





moonBook::densityplot(age ~ sex, data=acs)
# - male은 정규분포에 가깝다.
# - female은 정규분포가 아니다.

# 정규분포인지 아닌지 그래프로 판단이 안설 때 -> 숫자로 판단
# 귀무가설 : 두 집단이 정규분포
# 대립가설 : 두 집단이 정규분포가 아니다.
shapiro.test(acs$age[acs$sex == 'Male'])
#data:  acs$age[acs$sex == "Male"]
#W = 0.99631, p-value = 0.2098 p-value가 20% 따라서, 귀무가설로 정규분포.
shapiro.test(acs$age[acs$sex == 'Female'])
#data:  acs$age[acs$sex == "Female"]
#W = 0.96138, p-value = 6.34e-07
# p-value가 신뢰구간 밖에 있다. 즉, 모집단과 유의미하게 다르므로 정규분포가 확실히 아니라 판단할 수 있다.

# 등분산인지 판단
# 귀무가설 : 등분산이다.
# 대립가설 : 등분산이 아니다.
var.test(age ~ sex, data=acs)
# F = 0.91353, num df = 286, denom df = 569, p-value = 0.3866
# alternative hypothesis: true ratio of variances is not equal to 1
# 95 percent confidence interval:
#   0.7495537 1.1209741
# sample estimates:
#   ratio of variances 
# 0.9135342
# F가 90%이므로 신뢰구간 내에 있다. 즉, 귀무가설로 두 데이터는 등분산임을 알 수 있다.



wilcox.test(age ~ sex, data=acs)

# Wilcoxon rank sum test with continuity correction

# data:  age by sex
# W = 115271, p-value < 2.2e-16
# alternative hypothesis: true location shift is not equal to 0




library(dplyr)
acs_diff <- acs %>% select(age, sex)


#t-test
?t.test
t.test(age ~ sex, data=acs, alt="two.sided", var.equal = T)



#welch's t-test
?t.test
t.test(age ~ sex, data=acs, alt="two.sided", var.equal = F)



# 데이터가 많으면? 굳이 정규분포인지 확인할 필요 없다.
# 중심극한정리. 예) 동전을 수만번 던지면? 그 수는 확률에 따라 앞, 뒤 반반에 가깝게 된다.









#### 사례2 : 집단이 한개인 경우 ####
# 모수를 알고 있는 경우

# 주제 : A회사의 건전지 수명이 1000시간?

#귀무가설 : 표본의 평균은 모집단의 평균과 같다.
#대립가설 : 표본의 평균이 모집단의 평균과 다르다.

sample <- c(980, 1008, 968, 1032, 1012, 1002, 996, 1017, 990, 955)
mean.sample <- mean(sample)
mean.sample


mean1 <- 1000
mean2 <- mean(sample)
sd1 <- sd(sample)
sd2 <- sd(sample)
effective_size <- abs(mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2)
effective_size

shapiro.test(sample) #정규분포를 따른다.
# 샘플이 하나일 땐 등분산 분석을 할 필요 없다.
# t-test 사용 가능. 시간 = 연속변수, shapiro.test에서 정규분포 확인. 등분산은 1개 샘플 분석이니 할 필요 X

# one sample t-test
t.test(sample, mu = 1000, alt = "two.sided")
# t = -0.54045, df = 9, p-value = 0.602


### 가설설정
# 주제 : 어떤 학급의 평균 성적이 55점이었다.
# - 0 교시 수업을 하고 다시 성적을 살펴보았다.
# 귀무가설 : 표본의 평균은 모집단의 평균과 같다.
# 대립가설 : 표본의 평균은 모집단의 평균과 다르다.

sample2 <- c(58, 49, 39, 99, 32, 88, 62, 30, 55, 65, 44, 55, 57, 53, 88, 42, 39)
avg <- mean(sample2)
avg

shapiro.test(sample2)

t.test(sample2, mu = 55, alt = "two.sided")
t.test(sample2, mu = 55, alt = "less")
t.test(sample2, mu = 55, alt = "greater")
# t = 0.24546, df = 16, p-value = 0.8092
# 귀무가설 성립. 모집단과 표본평균은 같다. 크게 다른 부분 없다.
# 더 나아진 부분이 있는가? 에 대해 크게 달라진 부분은 없다로 결론이 나온다.



#### 사례 3. Paired Sample t-test ####
#t.test( .... , paired = T, ...)
str(sleep)
sleep
#   extra group ID
#1    0.7     1  1
#2   -1.6     1  2
#3   -0.2     1  3
#4   -1.2     1  4
#5   -0.1     1  5
#6    3.4     1  6
#7    3.7     1  7
#8    0.8     1  8
#9    0.0     1  9
#10   2.0     1 10
#11   1.9     2  1
#12   0.8     2  2
#13   1.1     2  3
#14   0.1     2  4
#15  -0.1     2  5
#16   4.4     2  6
#17   5.5     2  7
#18   1.6     2  8
#19   4.6     2  9
#20   3.4     2 10





# 주제 : 같은 집단에 대해 수면 시간의 증가량 차이에 대해. 유의미한 변화가 있는지, 다른 요인에 의한 변화가 있는지
sleep2 <- sleep[, -3]
sleep2

mean(sleep2$extra[sleep2$group == 1])
mean(sleep2$extra[sleep2$group == 2])

tapply(sleep2$extra, sleep2$group, mean)
#tapply가 훨씬 간편하다. 기억해두자.

#1. 두 데이터가 정규분포를 따르는지 확인
shapiro.test(sleep2$extra[sleep2$group == 1])
shapiro.test(sleep2$extra[sleep2$group == 2])


#2. 두 데이터가 등분산인지 판단
mean1 <- mean(sleep2$extra[sleep2$group == 1])
mean2 <- mean(sleep2$extra[sleep2$group == 2])
sd1 <- sd(sleep2$extra[sleep2$group == 1])
sd2 <- sd(sleep2$extra[sleep2$group == 2])

effective_size <- abs(mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2)
effective_size
pwr.t.test(d = effective_size, alternative = "two.sided", type ="two.sample" , power = .8, sig.level = .05)

t.test(extra ~ group, data = sleep2, alt = "two.sided", paired = T, bar.equal = T)




# 그래프로 확인
before <- subset(sleep2, group == 1, extra)
after <- subset(sleep2, group == 2, extra)

s_graph <- cbind(before, after)
s_graph

plot(s_graph, type = "profile")
# 오류 -> 칼럼 이름이 똑같아서

names(s_graph) <- c("before", "after")
s_graph

plot(s_graph, type = "profile")


install.packages("PairedData")
library(PairedData)

s_graph2 <- paired(before, after)
s_graph2

plot(s_graph2, type="profile") + theme_bw()









#실습 1
#주제 : 시와 군에 따라서 합계 출산율의 차이가 있는지 확인
mydata <- read.csv("../data/independent.csv", fileEncoding = "euc-kr")
mydata
str(mydata)
library(dplyr)


mydata1 <- mydata %>% filter(dummy == 1) %>%
  select(dummy, birth_rate)

mydata0 <- mydata %>% filter(dummy == 0) %>%
  select(dummy, birth_rate)
mydata1
mydata0

shapiro.test(mydata1$birth_rate)
shapiro.test(mydata0$birth_rate)

wilcox.test(birth_rate ~ dummy, data=mydata)


#실습 2.
str(mtcars)


mean1 <- mean(mtcars$mpg[mtcars$am == 0])
mean2 <- mean(mtcars$mpg[mtcars$am == 1])
sd1 <- sd(mtcars$mpg[mtcars$am == 0])
sd2 <- sd(mtcars$mpg[mtcars$am == 1])


effective_size <- abs(mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2)
effective_size
pwr.t.test(d = effective_size, alternative = "two.sided", type ="two.sample" , power = .8, sig.level = .05)


shapiro.test(mtcars$mpg[mtcars$am == 0])
shapiro.test(mtcars$mpg[mtcars$am == 1])

var.test(mtcars$mpg ~ mtcars$am, data = mtcars)
t.test(mtcars$mpg ~ mtcars$am, data = mtcars, alt = "two.sided", bar.equal = T)
t.test(mtcars$mpg ~ mtcars$am, data = mtcars, alt = "less", bar.equal = T)
t.test(mtcars$mpg ~ mtcars$am, data = mtcars, alt = "greater", bar.equal = T)
# -> greater는 p-value가 0.99이다. 연비가 많이드는 쪽은 차이가 없다는 것을 알 수 있다.




#실습 3

data <- read.csv("../data/pairedData.csv")
data



# [신뢰구간에서 벗어난 통계적으로 유의미한 차이가 있는지 판단하는 T-TEST]
# 1. 데이터 갯수 : 30개 이하면 POWER ANALYSIS 시행
# -> effective_size <- abs(mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2)
#    effective_size
#    pwr.t.test(d = effective_size, alternative = "two.sided", type ="two.sample" , power = .8, sig.level = .05)

# 2. 데이터가 정규분포를 따르는지 파악
# -> shapiro.test()

# 3. 두 데이터가 등분산인지 파악
# -> var.test((mtcars$mpg ~ mtcars$am, data = mtcars))

# 4. 정규분포, 등분산이면 t.test(mtcars$mpg ~ mtcars$am, data = mtcars, alt = "two.sided", bar.equal = T)
# -> 종속변수 ~ 독립변수

# 5. 정규분포가 아니거나 등분산 아니면 : wilcox.test(age ~ sex, data=acs)

mean1 <- mean(data$before)
mean2 <- mean(data$After)
cat(mean1, ',', mean2)
sd1 <- sd(data$before)
sd2 <- sd(data$After)
effective_size <- abs(mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2)
effective_size
pwr.t.test(d = effective_size, alternative = "two.sided", type ="two.sample" , power = .8, sig.level = .05)

shapiro.test(data$before)
shapiro.test(data$After)

var.test(data$After, data$before)

t.test(data$After, data$before, alt = "two.sided", paired = T)


#long형으로 바꾸기
library(reshape2)

data1 <- melt(data, id = "ID", variable.name = "GROUP", value.name = "RESULT")
data1

shapiro.test(data1$RESULT[data1$GROUP == "After"])
shapiro.test(data1$RESULT[data1$GROUP == "before"])
t.test(RESULT ~ GROUP, data = data1, paired = T, alt = "two.sided")

#long형 변경 방법(tidyr) : 요즘 많이 쓰는 함수
install.packages("tidyr")
library(tidyr)
data2 <- gather(data, key = "GROUP", value = "RESULT", -ID)
data2


# 그래프
library(PairedData)
before <- data$before
after <- data$After
s_graph <- paired(before, after)
plot(s_graph, type = "profile") + theme_bw()

library(moonBook)
moonBook::densityplot(RESULT ~ GROUP, data = data2)



#실습 4.

data4 <- read.csv("../data/paired.csv", fileEncoding = "euc-kr")
# 1. 불필요한 데이터 제거. long형으로 바꾸는데 방해 
data4 <- data4 %>% select(ID, birth_rate_2010, birth_rate_2015)

# 2. long형으로 변경
library(reshape2)
data <- melt(data4, id = "ID", variable.name = "GROUP", value.name = "RESULT")
data
table(data$GROUP)
# 73, 73

shapiro.test(data$RESULT[data$GROUP == "birth_rate_2010"])
shapiro.test(data$RESULT[data$GROUP == "birth_rate_2015"])
# 정규분포 X

wilcox.test(RESULT ~ GROUP, data = data, paired = T)
# p-value : 0.80. 통계상 유의미한 차이 없음. 신뢰구간 내 존재.





df <- gather(data4, key = "GROUP", value = "RESULT", -c(ID, cities))
df

with(df, shapiro.test(df$RESULT[df$GROUP == "birth_rate_2010"]))
with(df, shapiro.test(df$RESULT[df$GROUP == "birth_rate_2015"]))

wilcox.test(RESULT ~ GROUP, data = df, paired = T)
t.test(RESULT ~ GROUP, data = df, paired = T)





# 실습 5.
mat <- read.csv("../data/student-mat.csv", header = T)
mat
str(mat)

# 주제 1. 남녀별 각 시험에 대해 평균 차이가 있는지 알고 싶다. (sex, g1, g2, g3)
# = 종속 : 시험 평균 성적, 독립 : 성별
# 주제 2. 같은 사람에 대해 성적 차이가 있는지 알고 싶다. 첫번째 시험과 세번째 시험의 차이
# = 종속 : 성적, 독립 : 첫번째 시험, 세번째 시험

#주제 1. 성별 시험 성적 평균 차이
shapiro.test(mat$G1[mat$sex == "M"])
shapiro.test(mat$G1[mat$sex == "F"])
shapiro.test(mat$G2[mat$sex == "M"])
shapiro.test(mat$G2[mat$sex == "F"])
shapiro.test(mat$G3[mat$sex == "M"])
shapiro.test(mat$G3[mat$sex == "F"])
# 모두 정규분포 따르지 않는다. wilcox.test
# 다만 데이터 갯수가 많으니 그냥 정규분포 따른다고 가정해도 상관없다.

var.test(G1 ~ sex, data = mat)
var.test(G2 ~ sex, data = mat)
var.test(G3 ~ sex, data = mat)

t.test(G1 ~ sex, data = mat, var.equal = T, alt = "two.sided")
t.test(G2 ~ sex, data = mat, var.equal = T, alt = "two.sided")
t.test(G3 ~ sex, data = mat, var.equal = T, alt = "two.sided")
# 차이가 있다 없다 판단하기 애매함. 94% ~ 96%. 주관적인 해석이 들어갈 수 밖에 없다.
t.test(G1 ~ sex, data = mat, var.equal = T, alt = "less")
t.test(G2 ~ sex, data = mat, var.equal = T, alt = "less")
t.test(G3 ~ sex, data = mat, var.equal = T, alt = "less")
# F, M 순으로 분석된다. 값이 작은 F가 왼쪽에 있으니 "less"로 단측검정을 해줘야한다.
# 기준은 왼쪽 데이터. 왼쪽 데이터 평균이 오른쪽 데이터 평균의 신뢰구간 안에 있는가 판단하는 것이고
# 오른쪽 데이터 평균이 왼쪽 데이터보다 작으면 less, 크면 greater로 하는 것

moonBook::densityplot(G3 ~ sex, data = mat)

mean(mat$G2[mat$sex == "M"])
mean(mat$G2[mat$sex == "F"])
mean(mat$G3[mat$sex == "M"])
mean(mat$G3[mat$sex == "F"])

wilcox.test(G1 ~ sex, data=mat) # p-value = 0.059 -> X
wilcox.test(G2 ~ sex, data=mat) # p-value = 0.049 -> 차이 있다.
wilcox.test(G3 ~ sex, data=mat) # p-value = 0.041 -> 차이 있다.

# 결론 : G2, G3 시험은 성별에 따른 성적 평균 차이가 통계적으로 유의미하다. 추가 분석 필요. 


# 주제 2. G3와 G1 성적 차이에 대해
with(mat, shapiro.test(G1))
with(mat, shapiro.test(G3))

wilcox.test(G3 ~ G1, data = mat, paired = T)

Grade <- mat %>% select(G1, G3)
Grade
df <- gather(Grade, key = "TERM", value = "GRADE")
df
wilcox.test(GRADE ~ TERM, data = df, paired = T)
# p-value = 0.31 # 유의미한 차이 없다. 끝!
# wilcox는 순위를 가지고 하는 것. 그래서 일반적으로 사용하지 않는다.
t.test(GRADE ~ TERM, data = df, paired = T, alt = "greater")
# 두 값이 다르다면 비모수적 방식인 wilcox보다 t.test이 더 신뢰받는다. 따라서 차이가 있다로 결론을 내리는 것이 좋다.
t.test(mat$G1, mat$G3, paired = T, alt = "greater")
# wide형 데이터프레임으로도 가능


first <- mat$G1
third <- mat$G3
s_graph <- paired(first, third)
plot(s_graph, type = "profile")




