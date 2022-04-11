#### 연습문제 ####
library(ggplot2)
mpg <- ggplot2::mpg
head(df)
table(mpg$drv)
table(mpg$fl)
#제조사 / 자동차 모델 / 배기량(disp) / 생산연도 / 실린더 갯수 / 변속기어 / 구동방식(drv) / 도시연비(cty) / 고속도로(hwy) / 연료(fl) / 차 규격(소형차)

str(mpg)

table(mpg$manufacturer)
names(mpg)
str(mpg)

summary(mpg)
table(mpg$year)




# 배기량(displ)이 4이하인 차량의 모델명, 배기량, 생산년도 조회
mpg %>% filter(displ <= 4) %>%
  select(model, displ, year)

# 통합연비 파생변수(total)를 만들고 통합연비로 내림차순 정렬을 한 후에 3개의 행만 선택해서 조회
# 통합연비 : total <- (cty + hwy)/2
mpg %>% mutate(total = (cty + hwy)/2) %>%
  select(model, year, total) %>%
  arrange(desc(total))


# 회사별로 "suv"차량의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고 1위~5위까지 조회
table(mpg$class)
#1. 도시연비, 고속도로 연비의 평균 = 통합연비 평균
mpg %>% filter(class == 'suv') %>%
  mutate(total = (cty + hwy)/2) %>%
  select(model, year, total, class) %>%
  arrange(desc(total)) %>%
  head(5)

#2. 도시연비, 고속도로연비, 통합연비 평균? (X)

#3. 통합연비 데이터 따로
mpg_total <- mpg %>% mutate(total = (cty + hwy)/2)
mpg_total

# 어떤 회사의 hwy연비가 가장 높은지 알아보려고 한다. hwy평균이 가장 높은 회사 세곳을 조회
mpg %>% group_by(manufacturer) %>%
  summarize(hwy_avg = mean(hwy)) %>%
  arrange(desc(hwy_avg)) %>%
  head(3)


# 어떤 회사에서 compact(경차) 차종을 가장 많이 생산하는지 알아보려고 한다. 각 회사별 경차 차종 수를 내림차순으로 조회
mpg %>% group_by(manufacturer, class) %>%
  filter(class == 'compact') %>%
  summarize(amount_compact = n()) %>%
  arrange(desc(amount_compact))


# 연료별 가격을 구해서 새로운 데이터프레임(fuel)으로 만든 후 기존 데이터셋과 병합하여 출력.
# c:CNG = 2.35, d:Disel = 2.38, e:Ethanol = 2.11, p:Premium = 2.76, r:Regular = 2.22
# unique(mpg$fl)
df_fl <- data.frame(fl = c('c', 'd', 'e', 'p', 'r'), fl_price = c(2.35, 2.38, 2.11, 2.76, 2.22))
mpg_fl <- left_join(mpg, df_fl, by = 'fl')
mpg_fl

# 통합연비의 기준치를 통해 합격(pass)/불합격(fail)을 부여하는 test라는 이름의 파생변수를 생성. 이 때 기준은 20으로 한다.
mpg_test <- mpg_total %>% mutate(test = if_else(total>20, 'pass', 'fail'))
table(mpg_test$test)
?mutate()
?if_else()

# test에 대해 합격과 불합격을 받은 자동차가 각각 몇대인가?
table(mpg_test$test)
# fail pass 
#  111  123 


# 통합연비등급을 A, B, C 세 등급으로 나누는 파생변수 추가:grade
# 30이상이면 A, 20~29는 B, 20미만이면 C등급으로 분류
mpg_grade <- mpg_total %>% mutate(grade = if_else(total >= 30, 'A', if_else(total >=20, 'B', 'C')))
mpg_grade
table(mpg_grade$grade)
#  A   B   C 
# 10 118 106 









#### 연습문제 2 ####
midwest <- as.data.frame(ggplot2::midwest)
str(midwest)

#poptotal : 총인구수
#popwhite : 백인 수
#...
#perc는 비율

summary(midwest)


# 전체 인구대비 미성년 인구 백분율(ratio_child) 변수를 추가
midwest_child <- midwest %>% mutate(ratio_child = ((poptotal - popadults)/poptotal)*100)

# 미성년 인구 백분율이 가장 높은 상위 5개 지역(county)의 미성년 인구 백분율 출력
midwest_child %>% select(county, ratio_child) %>%
  arrange(desc(ratio_child)) %>%
  head(5)

# 분류표의 기준에 따라 미성년 비율 등급 변수(grade)를 추가하고, 각 등급에 몇개의 지역이 있는지 조회
# 미성년 인구 백분율이 40이상이면 "large", 30이상이면 "middel", 그렇지않으면 "small"
midwest_grade <- midwest_child %>% mutate(grade = if_else(ratio_child >= 40, "large", if_else(ratio_child >= 30, "middle", "small")))
table(midwest_grade$grade)
#  large middle  small 
#     32    396      9 

# 전체 인구 대비 아시아인 인구 백분율(ratio_asian) 변수를 추가하고 하위 10개 지역의 state, county, 아시아인 인구 백분율을 출력
midwest %>% mutate(ratio_asian = (popasian / poptotal) * 100) %>%
  select(state, county, ratio_asian) %>%
  arrange(ratio_asian) %>%
  head(10)



[문항3] t-test를 실제 적용 시 결과값이 연속변수가 아니거나 정규분포가 아닐 때 사용하는 모델은 무엇인가?
정답 : Wilcox.test()
kruskal.test(result_column ~ reason_column, data = data_name)
install.packages("pgirmess")
library(pgirmess)
kruskalmc(data_name$result_column, data_name$reason_column)
