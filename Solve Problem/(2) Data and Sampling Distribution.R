# 1. 평균 30 표준편차가 3인 정규분포에서 1,000개의 난수를 만들고, 
# 이러한 난수에서 반대로 평균을 추정한다
# (시드 번호: 2021 – R 코드: set.seed(2021).

set.seed(2021)
norm_sample <- rnorm(n=1000, mean=30, sd=3)
norm_sample

mean(norm_sample)


# 2. R 패키지 부트를 사용하여 중위수, 치우침 및 표준 오차의 원래 
#      추정치를 계산합니다. (데이터 세트 : loan_data_set, R = 500)

loan_data_set <- read.csv("loan_data_set.csv")

library(boot)
View(loan_data_set)

stat_fun <- function(x,idx) median(x[idx])
boot_obj <- boot(loan_data_set$x, R=500, statistic=stat_fun)
boot_obj

# library(boot)
#View(loan_data_set)

#stat_fun <- function(loan_data_set, idx) median(loan_data_set[idx])
#boot_obj <- boot(loan_data_set$x, R=500, statistic=stat_fun)
#boot_obj


# stat_fun <- function(x, idx) median(loan_data_set[idx])
# boot_obj <- boot(loan_data_set, R=500, statistic=stat_fun)



