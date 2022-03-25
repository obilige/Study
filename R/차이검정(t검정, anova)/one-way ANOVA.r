# R에서 one-way ANOVA 순서
#1. 정규분포 확인
result = aov(result_column ~ reason_column, data = data_name)
shapiro.test(resid(result))
#	정규분포 확인. p-value >= 0.05

bartlett.test(result_column ~ reason_column, data = data_name)
#	등분산 확인 p-value >= 0.05

#a.	aov분석(모두 정규분포, 등분산일 경우)
summary(result)
#	result = aov(result_column ~ reason_column, data = data_name)
#	p-value 확인
TukeyHSD(result)
#	사후검정 : 3개 이상의 그룹 중 어떤 그룹들이 기각영역에 있는지 파악

#b.	Kruskal분석(정규분포가 아닐 때)
kruskal.test(result_column ~ reason_column, data = data_name)
#	p-value 확인
install.packages("pgirmess")
library(pgirmess)
kruskalmc(result_column, reason_column)
#	사후검정

#c.	welch’s ANOVA(정규분포이나 등분산이 아닐 때)
oneway.test(result_column ~ reason_column, data = data_name)
#	p-value 확인
install.packages("nparcomp")
library(nparcomp)
result <- mctp(result_column ~ reason_column, data = data_name)
summary(result)
#	사후검정

#d.	one-way repeated measured ANOVA
multimode <- lm(cbind(data_name$column1, data_name$column2, data_name$column3, data_name$column4) ~ 1)
multimode
fact <- factor(c("column1", "column2", "column3", "column4"), ordered = F) #column1~column4 실제 칼럼명 적어주기
result <- Anova(multimode1, idata = data.frame(fact), idesign = ~fact, type="III")
summary(result, multivariae=F)
#	p-value 확인
df2 <- melt(df, id.vars = "id")
colnames(df2) <- c("id", "term", "score")
df2$id <- factor(df2$id)
with(df2, pairwise.t.test(score, term, paired=T, p.adjust.method = "bonferroni"))
#	사후검정 : p-value 확인
