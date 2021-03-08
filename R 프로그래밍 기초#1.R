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
x <- list(u=2, v="abc")
x

x$u  # x라는 list에 u element를 가져와라.

j <- list(name="Joe", salary=55000, union=T)  # -> 각각 scalar
j

j$sal