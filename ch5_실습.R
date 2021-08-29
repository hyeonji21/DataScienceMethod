library(klaR)
library(MASS)
library(dplyr)
library(ggplot2)
library(FNN)
library(mgcv)
library(rpart)

# 나이브 베이즈
# The loan payment data:

install.packages("klaR")
library(klaR)
loan_data <- read.csv('loan_data.csv.gz')
loan_data$purpose_ <- factor(loan_data$purpose_)
loan_data$home_ <- factor(loan_data$home_)
loan_data$emp_len_ <- factor(loan_data$emp_len_)
loan_data$outcome <- factor(loan_data$outcome)

naive_model <- NaiveBayes(outcome ~ purpose_ + home_ + emp_len_, data = na.omit(loan_data))
naive_model$table


# The last value of the data set for testing:

new_loan <- loan_data[147, c('purpose_', 'home_', 'emp_len_')]
row.names(new_loan) <- NULL
new_loan


# The model predicts a default (R):

predict(naive_model, new_loan)

# ----------------------------------------------------

# 피셔의 선형 판별 (판별분석)
# 선형판별자 가중치 구하기

library(MASS)
loan3000 <- read.csv('loan3000.csv')
loan_lda <- lda(outcome ~ borrower_score + payment_inc_ratio, data=loan3000)
loan_lda$scaling

# 상환과 연체에 대한 확률 계산

pred <- predict(loan_lda)
head(pred$posterior)

# LDA 시각화 / predict함수의 출력값을 사용하여, 체납에 대한 확률값 시각화

lda_df <- cbind(loan3000, prob_default=pred$posterior[,'default'])

ggplot(data=lda_df, aes(x=borrower_score, y=payment_inc_ratio, color=prob_default)) + geom_point(alpha=.6) + scale_color_gradient2(low='white', high='blue') + geom_line(data=lda_df, col = 'green', size=2, alpha=.8)

# ----------------------------------------------------

# 로지스틱 회귀
# logisitic regression to the personal loan data

logistic_model <- glm(outcome ~ payment_inc_ratio + purpose_ + home_ + emp_len_ + borrower_score, data=loan_data, family='binomial')
logistic_model


# predicted values from logistic regression

pred <- predict(logistic_model)
summary(pred)

# Converting these values to probabilities is a simple transform:

prob <- 1/(1 + exp(-pred))
summary(prob)

summary(logistic_model)

# logistic generalized additive model

logistic_gam <- gam(outcome ~ s(payment_inc_ratio)+ purpose_ + home_ + 
                      emp_len_ + s(borrower_score),
                    data=loan_data, family='binomial')
logistic_gam

# ----------------------------------------------------

# Assessing the model

# confusion matrix

pred <- predict(logistic_gam, newdata=loan_data)
pred_y <- as.numeric(pred > 0)
true_y <- as.numeric(loan_data$outcome == 'default')
true_pos <- (true_y == 1) & (pred_y == 1)
true_neg <- (true_y == 0) & (pred_y == 0)
false_pos <- (true_y == 0) & (pred_y == 1)
false_neg <- (true_y == 1) & (pred_y == 0)
conf_mat <- matrix(c(sum(true_pos), sum(false_pos), sum(false_neg), 
                     sum(true_neg)), 2, 2)
colnames(conf_mat) <- c('Yhat = 1', 'Yhat = 0')
rownames(conf_mat) <- c('Y = 1', 'Y = 0')
conf_mat

# precision
conf_mat[1, 1] / sum(conf_mat[,1])
# recall
conf_mat[1, 1] / sum(conf_mat[1,])
# specificity
conf_mat[2, 2] / sum(conf_mat[2,])


#----------------------------------------

# ROC CURVE
idx <- order(-pred)
recall <- cumsum(true_y[idx]==1) / sum(true_y==1)
specificity <- (sum(true_y==0) - cumsum(true_y[idx]==0)) / sum(true_y==0)
roc_df <- data.frame(recall = recall, specificity = specificity)
ggplot(roc_df, aes(x=specificity, y=recall)) + 
  geom_line(color='blue') + 
  scale_x_reverse(expand=c(0, 0)) +
  scale_y_continuous(expand=c(0, 0)) + 
  geom_line(data=data.frame(x=(0:100)/100), aes(x=x, y=1-x),
            linetype='dotted', color='red')

# AUC
sum(roc_df$recall[-1] * diff(1 - roc_df$specificity))

#------------------------------------------------------
# Strategies for imbalanced data
# undersampling

full_train_set <- read.csv('full_train_set.csv.gz')
mean(full_train_set$outcome == 'default')

# model training result of glm using full data set
full_model <- glm(outcome ~ payment_inc_ratio + purpose_ + home_ + emp_len_ + dti + revol_bal + revol_util, data=full_train_set, family='binomial')
pred <- predict(full_model)
mean(pred > 0)


# oversampling
wt <- ifelse(full_train_set$outcome=='default', 
             1/mean(full_train_set$outcome == 'default'), 1)
full_model <- glm(outcome ~ payment_inc_ratio + purpose_ + 
                    home_ + emp_len_ + dti + revol_bal + revol_util,
                  data=full_train_set, weight=wt, family='binomial')
pred <- predict(full_model)
mean(pred > 0)