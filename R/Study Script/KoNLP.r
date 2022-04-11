# 맥북 m1에서 rJava 설치 방법 url
https://blog.naver.com/vouloir12/222431257941

install.packages("multilinguer")
library("multilinguer")
install_jdk()
install.packages(c("stringer", "hash", "tau", "Sejong", "RSQLite", "devtools"), type = "binary")

install.packages("remotes")
install.packages("KoNLP", repos = c("https://forkonlp.r-universe.dev","https://cloud.r-project.org"), INSTALL_opts = c("–no-multiarch"))

install.packages("rJava")

