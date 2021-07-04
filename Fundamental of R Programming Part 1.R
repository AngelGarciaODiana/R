#alt + - " <- "
#ctrl + enter -> Ejecutar el código
# shift + 3

# This is comment
# Variable Assignment
a <- 1
b <- 2
c <- 3

a <- 1

X <- a+b+c

a

# Name of Variable
# do not start with number and _
# can use .,_ -> var.1
# can not use % sign in variable name
# 

var.name1 <- 1

# var_name% <- 1
# 1var_name <- 1

var1.name <- 1

._var.name <-10

._var.name

var.name1

print(var.name1)

cat(a,b,c)

ls(all.names = TRUE)

# Crear 3 variables:
# x <- 60
# y <- 50
# z <- 90

# Crear 1 objeto donde se sumen todas las varaibles hechas anteriormente
# Mostrar los datos de las variables y el objeto con la función print()
# Concatenar las varaibles x, y, z con la función cat()

# ARITHMETIC OPERATIONS
# +,-,/,*,%%

a <- 10
b <- 15
c <- 20

z <- a + b + c

a-b
b-a
a-b+c
a/b
b/a
a*b

b%%a # 15 mod 10


# RELATIONAL OPERATORS
# >, <, >= , <=, ==, !=

a>b
a<b

c >= b

b>=b

a==b

a==a
b==b

z == (a+b)

z == (a+b+c)


a != b
b != a
a != a


# LOGICAL OPERATORS
# &,|, !, isTRUE, &&, ||, !=

(a>b) & (b>a)
#FALSE & TRUE

(a>b) | (b>a) # False or True -> True
#FALSE | TRUE

!(a>b) # !False -> True
#!(FALSE)

!(a>b) & (b>a)
#(!(FALSE)) TRUE & (TRUE)

a&&b

a & b

a <- 0

a & b

a <- c(0, 1, 3)
b <- c(1, 2, 0)

a & b # elementwise

a && b # on whole vector


a <- c(1, 0, 0)
b <- c(1, 2, 0)

a && b # on whole vector

a || b


# ASSIGNMENT OPERATORS
  # Left: <-, =, <<- 
a <- 10

10<- a

# Right: ->, ->>
1 -> a
10 ->> a

# MISCELLANEOUS OPERATORS
# : -> sequence of numbers
# %in%' -> if a value belongs to a vector
# %*% -> matrix * t(matrix)

a <- 1:10

# a <- 10
b <- 2
c <- 30

b %in% a
c %in% a

m1 <- matrix(c(1,2,3,4,5,6), nrow = 2)
m1


m1 %*% t(m1)
#X %*% t(Y)


#CREAR 3 OBJETOS:
#a <- 50
#b <- 30
#c <- 15
#CREAR UNA VARIABLE (Z) QUE CONTENGA LA SUMA DE LOS 3 OBJETOS
#OPERADORES ARITMETICOS:
#a+c, b-c, z/a, a*c
#OPERADORES LOGICOS:
#(a>c) > (b<=a)
#OPERADORES CONDICIONANTES:
#z & a, c | a
#matriz <- matrix(c(1:10), nrow = 5)
#matrizb <- matrix(c(2:11), nrow = 5)
#matriz %*% t(matrizb)



# FUNCTION

#function def
yourfunction <- function(param1, param2){
  #function body
  x <- (param1^param2)
  
  return(x)
}

yourfunction(2, 10)



#R CUADRADO
rsqrd <- function(x){
  x <- (x^2)
  
  return(x)
}


#WE USE THE FUNCTION
r <- c(12, 15, 13)

rsqrd(r)


#CREAR FUNCION DE R2
#rsqrd <- function(x){
#x <- (x^2)

#return(x)
#}

#CREAR UNA VARIABLE:
#R <- 8, 15, 16, 19, 20
#EJECUTAR LA FUNCION DE R2



# Built-in functions
# mean, sum, var, std, median, sqrt, seq, matrix

sum(1,2)
result <- mean(c(1,2,1))

result

sqrt(a)
a


# DATA TYPES in R
# vectors, list, dataframes, arrays, matrics,
# numeric, logical, complex, char, raw, integer
a <- 12
b <- 3.14159

class(b)
typeof(a)

a <- 12L
b <- 3.14159L

typeof(b)

TRUE
FALSE

a <- 1 + 2i
typeof(a)

a <- 'char'
typeof(a)

a <- charToRaw("KGP Talkie")
typeof(a)


# STRINGS IN R

# "" or ''
# can not use "'

a <- "KGP Talkie at kgptalkie.com"
a
print(a)
cat(a)

b <- 'Visit kgptalkie.com'
b

c <- "KGP Talkie's lectures"
c

d <- 'This is "KGP TALKIE" Channel'
d

print(d)

d <- "This is \"KGP TALKIE\" Channel"
d



cat(a, b)

# Paste()
a <- "Hello"
b <- "KGP"
c <- "Talkie"

?paste()
paste(a, b, c, sep = ",")


a <- "Hello"
b <- "KGP"
c <- "Talkie from Laxmi Kant"
paste(a, b, c, sep = "", collapse = " ")

# format()
# pi <- 3.141592 ->>> 3.14
x <- 3.141592
y <- format(x, digits = 3)

typeof(x)
typeof(y)


as.double(y)

format(x, scientific = TRUE)


# : Operators for Vector Creation
a <- "kgp"

x <- 1:10
x
seq(1,10)

?seq()

seq(1, 10, 0.1)

1.2:3.14

a <- c("apple", "kgp", "talkie", 1, 3)

# Using [] operators: Accessing Vector Elements
a[1]
a[2]

a[c(1,2)]

a[c(TRUE, FALSE, FALSE, FALSE, TRUE, TRUE)]


# Vector Manipulation
a <- 1:10
b <- seq(10, 1, -1)

a + b

a - b 

a*b

a/b

# Vector Recycling
b <- 1:2
a
b

a + b

a - b 

c <- a*b

a/b

c


sort(c, decreasing = TRUE)


# LIST in R
c("kgp", "talkie", 1)

x <- list("kgp", "talkie", 1, 1.12, 1L, TRUE)

x[10]



# NAMED LIST
x <- list("kgp", "talkie", 1, TRUE)

names(x) <- c('string1', 'string2', 'numeric', 'boolean')

x$string1
x$numeric


#LIST MANIPULATION AND MERGING
x$string1 <- "KGP"
x$numeric <- 10

x$boolean <- a

x <- list(a, d, 1, TRUE)

names(x) <- c('string1', 'string2', 'numeric', 'boolean')

x <- list("one", "two", "three")
y <- list(1, 2, 3)

z <- c(y, x)

z

x <- list(1, 2, 3)
y <- list(1, 4, 9)

z <- unlist(x)*unlist(y)
z

z <- as.list(z)
z



# Matrix in R
a <- c(1, 2, 3, 4, 5, 6)

x <- matrix(a, nrow = 2, byrow = TRUE)
x


a <- c(1, 2, 3, 4, 5, 6, 7) #,1

x <- matrix(a, nrow = 3, byrow = TRUE)
x



a <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), nrow = 3)
b <- matrix(c(1, 4, 9, 16, 25, 36, 49, 64, 81), nrow = 3)

a[1,2]

b[3,2]

a[1,]

a[,1]

a + 1

a + b

a - b

a/b

a
b

a * b


# Arrays in R
# a -> (3, 4, 3)

a <- c(1, 2, 3)
b <- c(4, 5, 6)

z <- array(c(a, b), c(2,3,1))
z


a <- c(1, 2, 3) #3
b <- c(1, 4, 9, 16, 25, 36, 49, 64, 81) #9

z <- array(c(a, b), c(3, 3, 2)) #18-12 -> 6

z


a <- c(1, 2, 3, 4, 5, 6, 7, 8,9) #3
b <- c(1, 4, 9, 16, 25, 36, 49, 64, 81) #9

z <- array(c(a, b), c(3, 3, 2)) #18-12 -> 6

cols <- c("col1", 'col2', 'col3')
rows <- c('rows1', 'row2', 'row3')
mats <- c('matrix1', 'matrix2')


?array()
z <- array(c(a, b), c(3, 3, 2), dimnames = list(rows, cols, mats)) #18-12 -> 6
z

z[3,,2]
z[3,,1]

# Factors in R
# Factors are the data objects which are used to categorize 
#the data and store it as levels. 
#They can store both strings and integers. 
names <- c('sun', 'mon', 'tue', 'sun', 'mon', 'fri', 'mon')

is.factor(names)
is.vector(names)

l <- factor(names)
is.factor(l)

l
factor(l, levels = c('sun', 'mon', 'tue', 'fri'))


#gl()
?gl()
gl(3,4, labels = c('sun', 'mon', 'tue', 'fri'), ordered = TRUE)


#Conditional Statements in R
# If If-Else If-Else-If

x <- 100L
if (is.integer(x)){
  print('this is integer')
}

x <- 100
if (is.integer(x)){
  print('this is integer')
}else{
  print('this is not integer')
}


x <- 100
if (is.integer(x)){
  print('this is integer')
}else if(is.double(x)){
  print('this is double')
}else{
  print('this is not integer')
}

is.double(x)

if(TRUE){
  print('True')
}


# Loops
# Repeat Loop
# While Loop

vec <- c('hello', 'kgp talkie')
count <- 1

repeat{
  print(vec)
  
  if (count>5){
    break
  }
  
  count <- count + 1
}

count<-1
while (count<5) {
  print(vec)
  count <- count + 1
}


# For Loop
count <- seq(1, 10)
for (i in count) {
  print(vec)
}

count <- seq(1, 10)
for (i in count) {
  print(paste(i, vec))
}

paste('index', vec, ssep = '|')

# Loop Control Statements
# Next Statement and Break Statement

count <- seq(1, 10)
name <- "kgp talkie"
for (i in count) {
  print(paste(i, 'times:', name))
}


count <- seq(1, 10)
name <- "kgp talkie"
for (i in count) {
  if (i==5 | i==4){
    next
  }
  print(paste(i, 'times:', name))
}

count <- seq(1, 10)
name <- "kgp talkie"
for (i in count) {
  if (i>5){
    cat('breaking at ', i)
    break
  }
  print(paste(i, 'times:', name))
}
























































































