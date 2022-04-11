#### 5. 그래프 ####
# ggplot은 presentation에 유용.
# 실제 분석할 땐 가벼운 기본 그래프 쓰는게 좋다.

# 1. 기본 그래프
# plot : 산포도, 산점도
# plot(x축 데이터, y축 데이터, 옵션)
# plot(y축 데이터, 옵션)

y <- c(1,1,2,2,3,3,4,4,5,5)
plot(y)
# -> x값은 데이터 갯수만큼 나열. 즉, c(1:length(y))라고 보면 된다.
# -> 여기선 1부터 10까지 x값이 자동으로..
# -> 그래서 x가 1,2 일 때 y는 1. x가 3,4일 때 y는 2 ... 이렇게 나온다.
x <- 1:10
y <- 1:10
plot(x,y)
?plot

plot(x, y, xlim=c(0, 20), main = "GRAPH", type="o", pch=6, cex=0.8, col="pink", lty="dashed")
#xlim은 x 값 범위를 지정해주는 것. x축이 커지니 그래프 길어지는 효과있다.
#xlim을 할 땐 벡터로 입력해줘야 한다.
#main=은 제목을 달아줌.
#type는 형태를을 바꿔줌. "p", "l", "b", "o", "n"
#pch는 점의 모양을 바꿔줌, 숫자별로...
#cex는 점의 크기. 소수점으로 작게 표현도 가능
#col은 점의 색상. "red", "blue" 등
#lty는 선의 형태 변화. "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"

str(cars)
head(cars)
#   speed dist
# 1     4    2
# 2     4   10
# 3     7    4
# 4     7   22
# 5     8   16
# 6     9   10
plot(cars, main="CARS", col="red")
#cars는 speed, dist란 x, y값 둘 다 들어있다.
#x축과 y축 바꾸고 싶으면?
plot(cars$dist, cars$speed, main="CARS", col="BLUE", cex=.5)


# 같은 속도일 때 제동거리가 다르면? 대체적인 추세 알기 어렵다. 그래서 속도 그룹별 제동거리 평균을 구하면 대체적인 추세를 알 수 있다.
#지금까진 dplyr로 group_by -> summarize(mean()) 해서 구했다.
#더 쉬운 방법 있다.
tapply(cars$dist, cars$speed, mean)
plot(tapply(cars$dist, cars$speed, mean), xlab = "speed", ylab = "distance", cex=.5)




#points()
head(iris)
#   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
# 1          5.1         3.5          1.4         0.2  setosa
# 2          4.9         3.0          1.4         0.2  setosa
# 3          4.7         3.2          1.3         0.2  setosa
# 4          4.6         3.1          1.5         0.2  setosa
# 5          5.0         3.6          1.4         0.2  setosa
# 6          5.4         3.9          1.7         0.4  setosa

plot(iris$Sepal.Width, iris$Sepal.Length)
# -> 완전히 퍼져있는 형태. 어떤 관계도 파악할 수 없다.
# -> hue값으로 species를 주면 달라질 것 같다.
plot(iris$Petal.Width, iris$Petal.Length)
# -> 상관관계가 있어보인다.

#그런데 매번 iris를 입력해주는 것 귀찮지 않아? 이럴 때 with를 쓰면...

with(iris, {
  plot(Sepal.Width, Sepal.Length)
  plot(Petal.Width, Petal.Length)
  }
)
with(iris, {
  plot(Sepal.Width, Sepal.Length)
  points(Petal.Width, Petal.Length)
  }
)
# points()는 추가로 그래프 그려주는 것.



#lines() : 선그래프
plot(cars)
lines(cars)
lines(lowess(cars))
#lowess = 점과 선을 대표하는 일직선 하나를 그려주는 명령어

### barplot(), hist(), pie(), mosaicplot(), pair(), persp(), contour() ...



### 그래프 배열
# 한번에 여러 개의 그래프를 그리는 방법
# 그래프를 비교해야할 때 유용

head(mtcars)
str(mtcars)

# 그래프 4개를 동시에 그리기
par(mfrow=c(2,2))

plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)
boxplot(mtcars$wt)

# 그래프를 하나로 표기하고 싶을 땐?
par(mfrow=c(1,1))
plot(mtcars$wt, mtcars$mpg)


# 행과 열을 다르게 하고  싶을 땐?
?layout
layout(matrix(c(1,2,1,3), 2, 2, byrow=T))
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)

par(mfrow=c(1,1)) #원래대로

# 기본그래프 중 특이한 그래프 소개
#arrows
x <- c(1,3,6,8,9)
y <- c(12,56,78,32,9)
plot(x, y)
arrows(3, 56, 1, 12)
# y값 위치 -> x값 위치로 그리기
text(4, 40, "THIS IS SAMPLE", srt = 60)
#text(x위치, y위치, "입력할 글자, )


# 꽃잎그래프
x <- c(1,1,1,2,2,2,2,2,2,3,3,4,5,6,6,6)
y <- c(2,1,4,2,3,2,2,2,2,2,1,1,1,1,1,1)
plot(x,y)
#값이 얼마없다. 중복 값이 많기 때문.

?sunflowerplot
z <- data.frame(x, y)
z
sunflowerplot(z)
# 중복된 값을 꽃잎으로 보여줍니다.


# 별 그래프
# 데이터 전체의 윤곽을 살펴보는 그래프
# 데이터 항목에 대한 변화의 정도를 한 눈에 파악

str(mtcars)
stars(mtcars[1:4], key.loc=c(13, 2.0), flip.labels = T, draw.segments = T)
#flip.labels는 열 맞춰주는. 다만, 제목이 길면 겹친다. 그래서 True값이 default인 듯하다.
#key.loc은 그림의 이미지가 무엇을 의미하는지 보여준다.
#draw.segment는 나이팅게일 그래프를 보여줌.


# symbols
x <- c(1,2,3,4,5)
y <- c(2,3,4,5,6)
z <- c(10,5,100,20,10)

symbols(x, y, z)
# x와 y는 좌표. z는 좌표에서 표시할 값을 의미










#### ggplot2
# 레이어 지원
# - 배경 설정
# - 그래프 추가
# - 설정 추가(축, 범위, 범례, 색, 표식 등)
# 말 그대로 쌓아가면서 그래프를 꾸밀 수 있음


library(ggplot2)
mpg <- ggplot2::mpg
head(mpg)


###1. 산점도
#(1). 배경 만들기
ggplot(data=mpg, aes(x=dsipl, y=hwy))
#뭘 입력했을 때 어떤 값을 알고 싶은가? - 입력값 x 알게될 값 y

#(2). 그래프 추가
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()

#(3). 이 외 추가.
#함수를 합쳐주고 빼주는 방식으로
#x축과 y축의 범위를 정해줍니다.
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6) + ylim(10,30)
ggplot(data=mpg, aes(displ, hwy)) + geom_point() + xlim(3,6) + ylim(10,30)

# midwest 이용해서 전체 인구(poptotal), 아시아 인구(popasian) 간에 어떤 관계가 있는지 알고 싶다.
ggplot(data=midwest, aes(poptotal, popasian)) + geom_point() + xlim(0, 300000) + ylim(0, 10000)
#단위가 지수. 바꿀 수 있다.

options(scipen=99)
ggplot(data=midwest, aes(poptotal, popasian)) + geom_point() + xlim(0, 300000) + ylim(0, 10000)


###2. 막대그래프와 히스토그램
# 연속형 데이터, 범주형 데이터
# 그래프 이미지가 붙어있고, 떨어져있다.
# 히스토그램은 x만 있어도 된다. 막대그래프는 x, y 두 변수가 필요하다.
# 히스토그램은 geom_bar() // 막대그래프는 geom_col()

#예제. mpg데이터에서 구동방식 drv별로 고속도로 평균연비(hwy) 조회하고 그 결과를 표시
mpg_dh <- mpg %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy))
mpg_dh

ggplot(data=mpg_dh, aes(drv, mean_hwy)) + geom_col()
ggplot(data=mpg_dh, aes(reorder(drv, mean_hwy), mean_hwy)) + geom_col() #보기 편하게 크기 순으로 정렬하고 싶으면
ggplot(data=mpg_dh, aes(reorder(drv, -mean_hwy), mean_hwy)) + geom_col() #내림차순으로 정리하고 싶으면? -를 붙여줘

?reorder()

ggplot(mpg, aes(drv)) + geom_bar()






# 어떤 회사에서 생산한 SUV 차종의 도시 연비가 가장 높은지 알아보려고 한다.
# "SUV" 차종을 대상으로 평균 cty가 가장 높은 회사 다섯 곳을 그래프로 표시
str(mpg)

df <- mpg %>% filter(class == "suv") %>%
  group_by(manufacturer) %>%
  summarise(mean_cty=mean(cty)) %>%
  arrange(desc(mean_cty)) %>%
  head(5)

df

ggplot(df, aes(reorder(manufacturer, -mean_cty), mean_cty)) + geom_col()

# 자동차 종류별 빈도수를 확인하고 싶다? 자동차 종류별로 몇대인지 알고 싶다? -> 히스토그램

ggplot(mpg, aes(reorder(class)) + geom_bar()

       
       
       
       
       
       
       
#### 선그래프 : geom_line()
str(economics)
head(economics)       

ggplot(economics, aes(date, unemploy)) + geom_line()



#그래프 : 산포도, 막대(hist), 선, 원, 상자


#### 상자그래프 : geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()

# 이 기능을 다 외울 수 없어. 이 때 치트 페이지를 사용하면 좋다.
# help -> cheetsheet -> Data Visualization with ggplot2