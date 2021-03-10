### 데이터사이언스방법론_R 프로젝트 기초

## 1. object
#  - scalar, vector, matrix, list, other object 등 다양한 종류 포함 가능.
#    (무엇이든지 가능)

# 선언 (declaration)
object1 <- 1
object2 = 2

# 참조 (reference)
object1
object2

## 2. Scalars : 구성인자가 하나
x <- 8
x

## 3. Vectors
x <- c(5, 12, 13)
x
length(x)
mode(x)
y <- "abc"
y
length(y)
mode(y)
z <- c("abc", "29 88")
length(z)
mode(z)

# vector indexing
y <- c(1.2, 3.9, 0.4, 0.12)
y[c(1, 3)] # <- 1,3번째를 인덱싱 해라.
y[1]
y[2]
y[2:3]
v <- 3:4
y[v]

x <- c(4, 2, 17, 5)
y <- x[c(1, 1, 3)]
y

z <- c(5, 12, 13)
z[-1]  # element 1 제외하고
z[-1:-2] # element 1, 2 제외하고


## 4. Matrices and Array
y <- matrix(c(1, 2, 3, 4), nrow=2, ncol=2)
y
y <- matrix(c(1, 2, 3, 4), nrow=2)
y
y[,2]


## 5. General Matrix Operations
# Linear Algebra Operations on Matrices
y %*% y
3 * y
y+y
y*y


## 6. Matrix Indexing
z <- matrix(c(1, 2, 3, 4, 1, 1, 0, 0, 1, 0, 1, 0), nrow=4)
z
z[,2:3]

y <- matrix(c(11, 21, 31, 12, 22, 32), nrow=3)
y
y[2:3,]

y <- matrix(c(1, 2, 3, 4, 5, 6), nrow=3)
y
y[c(1, 3),] <- matrix(c(1, 1, 8, 12), nrow=2)
y


## 7. List : 다양한 형태로 저장
x <- list(u=2, v="abc") # u, v -> 반드시 element 이름 필요
x

x$u  # x라는 list에 u element를 가져와라.

j <- list(name="Joe", salary=55000, union=T)  # -> 각각 scalar
j

j$sal


## 8. Data frames 
##        : 네모난 표 형태, 형태는 여러 개로 섞어서 가능.
##          레코드(record) : 하나의 개체, 사람, 사물 등등
##          첫번째행 - 같은 요소, 두번째행 - 같은 요소.

## (matrix는 행, 열 모두 같은 형태)
  
d <- data.frame(list(kids=c("Jack", "Jill"), ages=c(12, 10)))
d
d$ages
d

### List와 Data Frame 비교
## List는 행,열 사이즈가 달라도 되지만, 
## Data Frame은 matrix처럼 사이즈가 똑같이 가야함. (네모)

# List에서도 이렇게 쓸 수 있음
d[[1]]
d$kids #이 방법으로 쓰는 것이 좋음! (교수님)
d[,1]
str(d)


## 9. Function

# function-name = function(inputs)
# {
#     function body
#     return(outputs)  # return : 밖으로 나오게 함
#                                 (outputs이 없으면 return도 없음)
# }

# example)
pow <- function(x, y){
  # function to print x raised to the power y
  
  result <- x^y
  print(paste(x,"raised to the power", y, "is", result))
}

# input 변수에 바로 대입하는 것 : positional parameta
pow(8,2)
pow(2,8)

# 순서 상관없이 input argument 값 지정 가능 : keyword parameta (이게 더 좋음)
pow(x=8, y=2)
pow(y=2, x=8)

# 평균 계산하는 함수
my.mean1 <- function(data){
  n <- length(data)
  sum <- 0
  for (i in 1:n) sum <- sum + data[i]
  return (sum / n)
}

x=1:10
my.mean1(x)
my.mean1(1:10)

xmean <- my.mean1(1:10)  # 값이 저장됨 (새로운 object 저장) => 함수의 output 값

dumy.arg <- function(){
  cat("Hello World!!!\n")
  cat("Welcome R system", date(), "\n")  
            # date() : input argument 없는 함수(자체 내에 저장되어있는 함수.)
}
dumy.arg()

# Checking the working directory
getwd()

# Setting working directory

# 폴더 경로 입력 : R 키면 가장 먼저해야할 것. (데이터 분석을 여기서 하겠다.)
setwd("C:/Users/0105l/Desktop/고려대학교/대학교/2021. 2학년 1학기/데이터사이언스방법론/R 프로그래밍 기초")

# Reading data frame
state <- read.csv('state.csv')

# Installing package
install.packages("mvtnorm")
library(mvtnorm)
