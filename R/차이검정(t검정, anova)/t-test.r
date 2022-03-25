# R에서 t-test하는 순서
# 1.	데이터 갯수 확인. 30개 이하면 POWER ANALYSIS로 유효한 갯수인지 확인
table(data_name$reason_column)
# If under 30, do pwr analysis
install.packages(“pwr”)
library(pwr)

mean1 <- mean(data_name$result_column[data_name$reason_column == value1)])
mean2 <- mean(data_name$result_column[data_name$reason_column == value2])
sd1 <- sd(data_name$result_column[data_name$reason_column == value1)
sd2 <- sd(data_name$result_column[data_name$reason_column == value2)
effective_size <- abs(mean1 - mean2) / sqrt((sd1^2 + sd2^2) / 2)

pwr.t.test(d = effective_size, alternative = "two.sided", type ="two.sample" , power = .8, sig.level = .05)
#	n값이 table(data_name$reason_column)에서 확인한 값보다 작아야한다.


# 2. 정규분포 확인
shapiro.test(data_name$result_column[data_name$reason_column == value1])
shapiro.test(data_name$result_column[data_name$reason_column == value2])
#	p-value가 0.05 이상이면 정규분포, 0.05 미만이면 정규분포 X


# 3. 등분산 여부 확인
var.test(result_column ~ reason_column, data = data_name)
	p-value가 0.05 이상이면 등분산, 미만이면 등분산 X


# 4. Independent two sample t-test
정규분포 따르며 등분산인 경우
t.test(result_column ~ reason_column, data = data_name, alt="two.sided", var.equal = T)
#	정규분포가 아닌 경우
wilcox.test(result_column ~ reason_column, data = data_name)
#   정규분포이나 등분산이 아닌 경우
t.test(result_column ~ reason_column, data = data_name, alt="two.sided", var.equal = F)

# 5. One Sample t-test : 모집단의 평균을 알고 있을 때 사용. 특수한 경우
t.test(result ~ reason, data = data_name, mu = 1000, alt = "two.sided")
#	mu는 모집단의 평균을 받는 인수값

# 6. Paired Sample t-test
t.test(extra ~ group, data = sleep2, alt = "two.sided", paired = T, bar.equal = T)
paired = T
