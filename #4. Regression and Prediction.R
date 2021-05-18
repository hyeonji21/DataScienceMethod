gamble = read.csv(file = "gamble.csv")
View(gamble)
gamble_lm <- lm(gamble ~ gender + grading + income + GPA, data=gamble)
gamble_lm
summary(gamble_lm)

resid <- residuals(gamble_lm)
resid
mean(resid)
median(resid)
resid

cor(resid, gamble$gamble)
plot(resid, gamble$gamble, xlab="residual", ylab="fitted value")

cor(resid, gamble$income)
plot(resid, gamble$income, xlab="residual", ylab="income")

plot(resid, 2)

cor(resid, fitted(gamble_lm))
cor(resid, fitted.values(gamble_lm))
plot(resid, fitted_value, xlab="residual", ylab="fitted_value")




