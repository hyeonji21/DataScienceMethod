# 2장 

# 2.6 1,000명의 대출 신청자의 연간 소득의 히스토그램, n=5일 때 1,000개 평균, n=20일 때 1,000개 평균

library(ggplot2)
loans_income <- read.csv("loans_income.csv")[,1]

# 단순랜덤표본을 하나 취한다.
samp_data <- data.frame(income=sample(loans_income, 1000),
                        type = 'data_dist')

# 5개 값의 평균으로 이뤄진 표본을 하나 취한다.
samp_mean_05 <- data.frame(
  income = tapply(sample(loans_income, 1000*5),
                  rep(1:1000, rep(5, 1000)), FUN=mean),
  type='mean_of_5')

# 20개 값의 평균으로 이뤄진 표본을 하나 취한다.
samp_mean_20 <- data.frame(
  income = tapply(sample(loans_income, 1000*20),
                  rep(1:1000, rep(20, 1000)), FUN=mean),
  type='mean_of_20')

# data.frame 바인딩 후 factor로 형 변환
income <- rbind(samp_data, samp_mean_05, samp_mean_20)
income$type = factor(income$type,
                     levels=c('data_list', 'mean_of_5', 'mean_of_20'),
                     labels=c('Data', 'Mean of 5', 'Mean of 20'))

# 히스토그램 그리기
ggplot(income, aes(x=income)) +
  geom_histogram(bins=40) +
  facet_grid(type ~.)


# 2.4 bootstrap

library(boot)
stat_fun <- function(x, idx) median(x[idx])
boot_obj <- boot(loans_income, R=1000, statistic=stat_fun) 
boot_obj


# 2.6.1 정규분포로부터 추출한 100개 표본의 QQ 그림
norm_samp <- rnorm(100)
qqnorm(norm_samp)
abline(a=0, b=1, col='grey')


# 2.7 NFLX에 대한 수익에 대한 QQ 그림

sp500_px <- read.csv("sp500_px.csv")
nflx <- sp500_px[, 'NFLX']
nflx <- diff(log(nflx[nflx>0]))
qqnorm(nflx)
abline(a=0, b=1, col='grey')

hist(nflx)


# Skewed distribution

plot(density((rgamma(1000, shape=4, rate=1)), adjust=2))
qqnorm(rgamma(1000, shape=4, rate=1))
abline(a=0, b=1, col='grey')


# Student's t-Distribution
# confidence interval using t-distribution

(xbar=mean(loans_income))
(s=sd(loans_income))
(n=length(loans_income))
xbar + c(qt(0.05, df=n-1),qt(0.95, df=n-1)) * s/sqrt(n)


# Bionomial distribution

dbinom(x=2, size=5, p=0.1)
dbinom(x=0, size=200, p=0.02)

pbinom(q=2, size=5, p=0.1)


# Poisson distribution

rpois(100, lambda=2)


# Exponential distribution

rexp(n=100, rate=0.2)
