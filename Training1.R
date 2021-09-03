# 1. Using the ch1_data solve following.
# calculate mean, median, weighted mean, standard deviation and Interquartile # range.

ch1_data <- read.csv("ch1_data.csv")
ch1_data

mean(ch1_data[['population']])
median(ch1_data[['population']])
weighted.mean(ch1_data[['population']])
sd(ch1_data[['population']])
IQR(ch1_data[['population']])


# 2. Use the bank50.csv data to solve the problem below. Find summary statistics of age and box plot.

bank50 <- read.csv("bank50.csv")
bank50

summary(bank50[['age']])
boxplot(bank50[['age']])

# 3. 1. se the real-life-ex.csv data to answer following questions.

#● Check the mean and median values of price and mileage from the data.
#● Use boxplot to check the distribution of vehicle prices by car brand.
#● Draw a scatter plot using ‘Engine V’ and ‘Price’ variables.
#● Adjust the x-axis range from 0 to 10 to redraw the scatter plot.

#1
real_life_ex <- read.csv("Real-life-ex.csv")
real_life_ex
 
mean(real_life_ex[['Price']], na.rm=T)
median(real_life_ex[['Price']], na.rm=T)
mean(real_life_ex[['Mileage']], na.rm=T)
median(real_life_ex[['Mileage']], na.rm=T)

#2

#library(ggplot2)
#ggplot(data=real_life_ex, aes(x=Brand, y=Price)) + geom_boxplot()

boxplot(real_life_ex$Price ~ real_life_ex$Brand, data=real_life_ex, xlab='Brand', ylab='Price')


#3
plot(real_life_ex$EngineV, real_life_ex$Price, xlab='Engine V', ylab='Price')

#4
plot(real_life_ex$EngineV, real_life_ex$Price, xlab='Engine V', ylab='Price',xlim=c(0,10))

