#1. Using the data ‘birthwt’. We are going to find out the difference in the weight of a mother depending on whether she is giving birth or not. Solve and draw following questions: 
# (Use R code: install.package(“MASS”); library(MASS); data(birthwt))

#install.packages("MASS")
library(MASS)
data(birthwt)

help(birthwt)
View(birthwt)

boxplot(birthwt$lwt ~ birthwt$low, data=birthwt, xlab='low', ylab='weight')

mean_a <- mean(birthwt[birthwt['low']== '0', 'lwt'])
mean_b <- mean(birthwt[birthwt['low']== '1', 'lwt'])
mean_b - mean_a


perm_fun <- function(x,nA,nB)
{
n <- nA + nB
idx_b <- sample(1:n, nB)
idx_a <- setdiff(1:n, idx_b)
mean_diff <- mean(x[idx_b]) - mean(x[idx_a])
return(mean_diff)
}

length(birthwt[birthwt$low == '0', 'low'])
length(birthwt[birthwt$low == '1', 'low'])


perm_diffs <- rep(0, 1000)
for (i in 1:1000){
perm_diffs[i] = perm_fun(birthwt[,'lwt'], 130, 59)
}
hist(perm_diffs, xlab='Weight Difference')
abline(v=mean_b - mean_a)

mean(perm_diffs > (mean_b - mean_a))


#2. Use ‘feed’ data to verify the below passage and conduct a suitable hypothesis test. Nineteen pigs are assigned at random among four experimental groups. Each group is fed a different diet. The data are pig body weights, in kilograms. After being raised on these diets. We wish to ask whether pig weights are the same for all four diets.(If necessary, data should be handled appropriately for analysis.)

feed <- read.csv("feed.csv")
feed

boxplot(feed)


library(lmPerm)
Weight <- c(feed$Feed1, feed$Feed2, feed$Feed3, feed$Feed4)
Feed <- c(rep('Feed1', 5), rep('Feed2', 5), rep('Feed3', 5), rep('Feed4', 5))
summary(aovp(Weight ~ Feed, data=feed))
