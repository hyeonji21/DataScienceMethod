#loan3000 데이터셋을 이용하여 default 예측을 위한 분석을 진행한다. 


# 1. outcome 변수를 반응변수로 하고 purpose_, dti, borrower_score, payment_inc_ratio를 설명변수로 하여 outcome 예측하기 위한 logistic regression 모형을 구축한다. 구축된 모형에 대한 적절한 해석을 하여라. 


loan3000 <- read.csv('loan3000.csv')
View(loan3000)
loan3000$outcome <- ordered(loan3000$outcome, levels=c('paid off', 'default'))
logistic_model <- glm(outcome ~ purpose_ + dti + borrower_score + 
                        payment_inc_ratio, data=loan3000, family='binomial')
logistic_model

summary(logistic_model)


# 2. ROC curve를 이용하여 최적의 cutoff 포인트를 찾는다. cutoff 포인트 결정의 타당한 근거를 제시한다. 
logistic_gam <- gam(outcome ~ s(payment_inc_ratio) + purpose_ + dti +
                      s(borrower_score), data=loan3000, family='binomial')

pred <- predict(logistic_gam, newdata=loan3000)
pred_y <- as.numeric(pred > 0)
true_y <- as.numeric(loan3000$outcome=='default')

idx <- order(-pred)
recall <- cumsum(true_y[idx]==1) / sum(true_y==1)
specificity <- (sum(true_y==0) - cumsum(true_y[idx]==0))/sum(true_y==0)
roc_df <- data.frame(recall = recall, specificity = specificity)
ggplot(roc_df, aes(x=specificity, y=recall)) + 
  geom_line(color='blue') + 
  scale_x_reverse(expand=c(0, 0)) +
  scale_y_continuous(expand=c(0, 0)) + 
  geom_line(data=data.frame(x=(0:100)/100), aes(x=x, y=1-x),
            linetype='dotted', color='red')



#install.packages("Epi")
library(Epi)

par("mar")
par(mar=c(1,1,1,1))

ROC(form = loan3000$outcome ~ loan3000$payment_inc_ratio + loan3000$purpose_ + loan3000$dti + loan3000$borrower_score, plot = "ROC")


# 3. 2번에서 결정한 cutoff를 가지고 confusion matrix를 작성한다.

pred <- predict(logistic_gam, newdata=loan3000)
pred_y <- as.numeric(pred > 0.485)
true_y <- as.numeric(loan3000$outcome=='default')
true_pos <- (true_y == 1) & (pred_y == 1)
true_neg <- (true_y == 0) & (pred_y == 0)
false_pos <- (true_y == 0) & (pred_y == 1)
false_neg <- (true_y == 1) & (pred_y == 0)
conf_mat <- matrix(c(sum(true_pos), sum(false_pos), sum(false_neg), 
                     sum(true_neg)), 2, 2)
colnames(conf_mat) <- c('Yhat = 1', 'Yhat = 0')
rownames(conf_mat) <- c('Y = 1', 'Y = 0')
conf_mat


# 4. confusion matrix로부터 accuracy, recall, specificity, precision을 계산하여라. 

# accuracy
(conf_mat[1, 1] + conf_mat[2, 2]) / (sum(conf_mat[1,]) + sum(conf_mat[2, ]))
# recall
conf_mat[1, 1] / sum(conf_mat[1,])
# specificity
conf_mat[2, 2] / sum(conf_mat[2,])
# precision
conf_mat[1, 1] / sum(conf_mat[,1])




