# Testing using bionomial distribution

# 대립가설 : greater (pA > pB) 
# 현재 신뢰구간에서 하한만 나타남을 알 수 있음.(상한은 1을 넘지 못함.)
prop.test(x=c(200, 182), n=c(23739, 22588), alternative='greater')

# 대립가설 : less (pA < pB)
prop.test(x=c(200, 182), n=c(23739, 22588), alternative='less')

# 대립가설 : two.sided (pA != pB)
prop.test(x=c(200, 182), n=c(23739, 22588), alternative='two.sided')


# Web Stickiness
library(ggplot2)
session_time <- read.csv('web_page_data.csv')
ggplot(session_time, aes(x=Page, y=Time)) + geom_boxplot()

mean_a <- mean(session_time[session_time['Page'] == 'Page A', 'Time'])
mean_b <- mean(session_time[session_time['Page'] == 'Page B', 'Time'])
mean_b - mean_a


# Permutation test
perm_fun <- function(x, nA, nB)
{
n <- nA + nB
idx_b <- sample(1:n, nB)
idx_a <- sample(1:n, idx_b)
mean_diff <- mean(x[idx_b]) - mean(x[idx_a])
return(mean_diff)
}

# R = 1,000 times, and specifying nA=21 and nB=15
perm_diffs <- rep(0, 1000)
for (i in 1:1000){
perm_diffs[i] = perm_fun(session_time[,'Time'], 21, 15)
}
hist(perm_diffs, xlab='Session time differences (in seconds)')
abline(v=mean_b-mean_a)

# probability of observed case
mean(perm_diffs > (mean_b - mean_a))

# permutation test procedure

obs_pct_diff <- 100*(200/23739-182/22588)
conversion <- c(rep(0,45945), rep(1,382))
perm_diffs <- rep(0, 1000)
for (i in 1:1000)
{
perm_diffs[i]=100 * perm_fun(conversion, 23739, 22588)
}
hist(perm_diffs, xlab='Conversion rate (percent)', main='')
abline(v=obs_pct_diff)

mean(perm_diffs > obs_pct_diff)


# t-test
t.test(Time~Page, data=session_time, alternative='less')


# ANOVA
#install.packages("lmPerm")
library(lmPerm)
four_sessions <- read.csv("four_sessions.csv")
summary(aovp(Time~Page, data=four_sessions))


# Chi-square test
click_rate <- read.csv("click_rates.csv")
clicks <- matrix(click_rate$Rate, nrow=3, ncol=2, byrow=TRUE)
dimnames(clicks) <- list(unique(click_rate$Headline), unique(click_rate$Click))

chisq.test(clicks, simulate.p.value=TRUE)

chisq.test(clicks, simulate.p.value=FALSE)

help(chisq.test)


# 피셔의 정확검정
fisher.test(clicks)

# gamma graph
qqnorm(rgamma(1000, shape =4, rate=1))
abline(a=0, b=1, col='grey')






