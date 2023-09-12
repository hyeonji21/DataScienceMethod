setwd("./data")

# 실습을 위한 데이터 준비)

PSDS_PATH <- file.path(dirname(dirname(getwd())))

dfw <- read.csv('dfw_airline.csv')
sp500_px <- read.csv('sp500_data.csv', row.names=1)
sp500_sym <- read.csv('sp500_sectors.csv', stringsAsFactors = FALSE)
kc_tax <- read.csv('kc_tax.csv.gz')
lc_loans <- read.csv('lc_loans.csv')
airline_stats <- read.csv('airline_stats.csv', stringsAsFactors = FALSE)
airline_stats$airline <- ordered(airline_stats$airline, 
                                 levels=c('Alaska', 'American', 'Jet Blue', 'Delta', 'United', 'Southwest'))

library(dplyr)
library(tidyr)
library(ggplot2)
library(vioplot)
library(corrplot)
library(gmodels)
library(matrixStats)



# ----------------------------------------------------------------
# 예제 1.3.3 / 인구에 따른 살인 비율의 위치 추정

state <- read.csv("state.csv")
state

mean(state[['Population']])
mean(state$Population)

mean(state[['Population']], trim=0.1)

median(state[['Population']])

weighted.mean(state[['Murder.Rate']], w=state[['Population']])

install.packages("matrixStats")
library('matrixStats')
weightedMedian(state[['Murder.Rate']], w=state[['Population']])



# 예제 1.4.3 / 주별 인구의 변위 측정

sd(state[["Population"]])   # 표준편차
IQR(state[["Population"]])  # 사분위범위(IQR)
mad(state[["Population"]])  # 중위절대편차(평균절대오차, MAD)

sd(state$Population)
IQR(state$Population)
mad(state$Population)



# 예제 1.5.1
# 주별 살인율의 백분위수
quantile(state[["Murder.Rate"]], p=c(.05, .25, .5, .75, .95))

# 주별 인구를 보여주는 상자 그림
boxplot(state[["Population"]]/1000000, ylab="Population (millions)")



# 예제 1.5.2 
# 주별 인구 도수분포표
breaks <- seq(from=min(state[["Population"]]),
              to=max(state[["Population"]]), length=11)
pop_freq <- cut(state[["Population"]], breaks=breaks,
                right=TRUE, include.lowest = TRUE)
table(pop_freq)

# 주별 인구의 히스토그램
hist(state[["Population"]], breaks=breaks)
# 추가) lines(density(state[["Population"]]), lwd=3, col="blue")



# 예제 1.5.3 밀도추정
# 주별 살인별 밀도
hist(state[["Murder.Rate"]], freq=FALSE)
lines(density(state[["Murder.Rate"]]), lwd=3, col="blue")



# 예제 1.6 이진 데이터와 범주 데이터 탐색하기
# 댈러스-포트워스 항공의 운행 지연 요인에 따른 퍼센트 비율

dfw <- read.csv("dfw_airline.csv")
barplot(as.matrix(dfw)/6, cex.axis=.5)



# 예제 1.7 / ETF 수익 간의 상관관계
sp500_px <- read.csv("sp500_px.csv")
sp500_sym <- read.csv("sp500_sym.csv")
etfs <- sp500_px[row.names(sp500_px) > '2012-07-01',
                 sp500_sym[sp500_sym$sector == 'etf', 'symbol']]
library(corrplot)
corrplot(cor(etfs), method='ellipse')



# 예제 1.7.1 / AT&T와 버라이즌 수익 사이의 산점도

sp500_px <- read.csv("sp500_px.csv")
sp500_sym <- read.csv("sp500_sym.csv")
telecom <- sp500_px[, sp500_sym[sp500_sym$sector == 'telecommunications_services', 'symbol']]

plot(telecom$T, telecom$VZ, xlab="T", ylab="VZ")

# 예제 1.8.1 / 집의 크기와 과세 평가액을 나타낸 육각형 구간 분포

kc_tax0 <- subset(kc_tax, TaxAssessedValue < 750000 & SqFtTotLiving > 100 & SqFtTotLiving < 3500)
nrow(kc_tax0)


library(ggplot2)
install.packages("hexbin")
library(hexbin)

ggplot(kc_tax0, (aes(x=SqFtTotLiving, y=TaxAssessedValue))) + stat_binhex(color='white') + theme_bw() + scale_fill_gradient(low='white', high='black') + labs(x='Finished Square Feet', y='Tax-Assessed Value')

# / 집의 크기와 과세 평가액을 나타낸 등고선 도표

library(ggplot2)
graph <- ggplot(kc_tax0, aes(SqFtTotLiving, TaxAssessedValue)) + 
  theme_bw() + 
  geom_point(alpha=0.1) + 
  geom_density2d(color='white') + 
  labs(x='Finished Square Feet', y='Tax-Assessed Value')
graph

# 예제 1.8.2 / 대출 등급과 상황에 대한 분할표
library(descr)
x_tab <- CrossTable(lc_loans$grade, lc_loans$status, 
                    prop.c=FALSE, prop.chisq=FALSE, prop.t=FALSE)


# 예제 1.8.3 / 항공기 원인에 따른 지연 비율
boxplot(pct_atc_delay ~ airline, data=airline_stats, ylim=c(0, 50))


# / 항공기 원인에 따른 운항 지연 비율을 나타내는 상자그림과 바이올린 도표의 결합

graph <- ggplot(data=airline_stats, aes(airline, pct_carrier_delay)) + 
  ylim(0, 50) + 
  geom_violin(draw_quantiles = c(.25,.5,.75), linetype=2) +
  geom_violin(fill=NA, size=1.1) +
  labs(x='', y='Daily % of Delayed Flights') +
  theme_bw()
graph

# 예제 1.8.4 / 우편번호에 따른 과세 평가액 대 실 제곱피트
ggplot(subset(kc_tax0, ZipCode %in% c(98188, 98105, 98108, 98126)),
       aes(x=SqFtTotLiving, y=TaxAssessedValue)) +
  stat_binhex(colour='white') +
  theme_bw() +
  scale_fill_gradient(low='white', high="blue") +
  labs(x="Finished Square Feet", y="Tax Assessed Value") +
  facet_wrap("ZipCode")
