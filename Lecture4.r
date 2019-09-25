
df <- data.frame(names = c("Lucy", "John", "Mark", "Candy"),
                score = c(67, 56, 87, 91))
df

x <- NULL
for (i in 1:5){
    x[i] = 2*i
}
x

9 %% 2   # 9 mod 2
9 %/% 2

# y %% x
i <- 0
y <- 9
x <- 2
while (y>=x){
    y <- y - x
    i <- i + 1
}
y   # modulus
i   # integer division
# why?

watermelon <- FALSE
no.orange <- if (watermelon == TRUE){
    "Buy 1 orange"
} else {
    print("Buy 6 oranges")   # As seen in class, print() is useless here.
}
no.orange

# I prefer a simple function, ifelse(test, yes, no)
watermelon <- F
ifelse(watermelon == TRUE, yes = "Buy 1 orange", no = "Buy 6 oranges")

# ifelse is vectorized
df$pass <- ifelse(test = df$score >= 65, yes = TRUE, no = FALSE)
df

i <- 0
# repeat {system("say Because they have watermelons!")
#         i <- i + 1
#     if (i>=3){
#         break
#     }
# }



# Using indices from last lecture to change specific entries in R objects
df.copy <- df
df.copy$score[2] <- df.copy$names[3] <- NA
df.copy

is.na(df.copy)

# Total number of cells with missing values
sum(is.na(df.copy))

# Whether a data point (row) is complete
complete.cases(df.copy)

!complete.cases(df.copy)

# Inomplete data points
df.copy[!complete.cases(df.copy), ]
# Recall the logical operator "!"

# Taking the average score
mean(df.copy$score)

mean(df.copy$score, na.rm = TRUE)

sum(df.copy$score)
sum(df.copy$score, na.rm = T)

na.omit(df.copy)

Sys.Date()
# Note the standard date format in R

Sys.time() # Eastern Daylight Time

date()

first.hw.post <- as.Date("Oct 4, 2018", tryFormats = "%b %d, %Y")
first.hw.post

first.hw.due <- as.Date("2018년10월11일", tryFormats = "%Y년%m월%d일")
first.hw.due
# Just want to show you that any format can be recognized.
# As long as you can let R know how to read it.

# Help file: Date-time Conversion Functions to and from Character
# ?strptime

first.hw.due - Sys.Date()

as.numeric(Sys.Date())

# Time origin of R
Sys.Date() - as.numeric(Sys.Date())

# How long does it take R to load the survival package
time0 <- proc.time()
library(survival)
proc.time() - time0

format(Sys.Date(), format = "%A %B %d %Y")

# Absolute value
abs(-3)

ceiling(3.14159)

floor(3.14159)

trunc(3.14159)

signif(3.14159, 3)

# ?round



for (i in 1:4){
    df$student.no[i] <- paste("student", i)
    df$curved.score[i] <- round(sqrt(df$score[i]) * 10)
}
str(df)

n <- nrow(df)
plot(as.factor(df$student.no), df$curved.score,
     # Math symbols in text
     main = expression(paste("Score is ", alpha, ", curved score is ", sqrt(alpha)%*%10)),
     # Variable value in text
     xlab = paste("There are", n, "students"))

df.scores <- df[, c("score", "curved.score")]; df.scores

apply(df.scores, MARGIN = 2, FUN = mean)

apply(df.scores, MARGIN = 1, FUN = diff)   # diff() calculates the difference - see Section 4.4.4

myarray <- array(1:12, dim = c(2,3,2)); print(myarray)

apply(myarray, MARGIN = c(2, 3), sum)

sapply(df, is.numeric)

age=c(1,6,4,5,8,5,4,3)
weight=c(45,65,34)
age

mean(age)

prod(age)

median(age)

var(age)
sd(age)

max(age)
min(age)
range(age)

which.max(age)   #returns the index of the greatest element of x
which.min(age)   #returns the index of the smallest element of x

seq(from = 0, to = 1, by = 0.25)
quantile(age, probs = seq(from = 0, to = 1, by = 0.25))
# Returns the specified quantiles.

unique(age)   # Gives the vector of distinct values

diff(age)   # Replaces a vector by the vector of first differences

sort(age)   # Sorts elements into order

order(age)
age[order(age)]   # x[order(x)] orders elements of x

cumsum(age)   # Cumulative sums
cumprod(age)   # Cumulative products

age
cat <- cut(age, breaks = 2); cat   # Divide continuous variable in factor with n levels
table(cat)   # Cross tabulation and table creation

# Split the variable into categories
age.cat <- split(age, cut(age,2))
age.cat

# split() gives a list
str(age.cat)

# lapply: list apply
lapply(age.cat, mean)

# The structure

func_name <- function(argument){
    statement
}

X.to.the.power.of.Y <- function(y, x){
    x^y
}
X.to.the.power.of.Y(x = 3, y = 2)
X.to.the.power.of.Y(3, 2)     # Following a question in class, note the difference.

df.scores

# The following code does not work
# apply(df.scores, MARGIN = 2, FUN = ^2)

# Instead we can do
my.fun <- function(x){x^2}
apply(df.scores, MARGIN = 2, FUN = my.fun)

# Two inputs, y and x, so two arguments

# Option 1 - use %% and %/% operators
modulus1 <- function(y, x){
    mod <- y %% x
    int.div <- y %/% x
    return(list(modulus=mod, integer.division=int.div))
}
out1 <- modulus1(y = 9, x = 2)
print(out1)
str(out1)

out1$modulus
out1$integer.division

# Option 2 - use trunc() or floor()

modulus2 <- function(y, x){
    mod <- trunc(y/x)     # or floor(y/x)
    int.div <- y - x * mod
    return(c(modulus=mod, integer.division=int.div))
}
out2 <- modulus2(9, 2)
print(out2)
str(out2)

out2[1]
out2[2]

attr(out2, "names")

# Option 3 - use loops

modulus3 <- function(y, x){
    i <- 0
    while (y>=x){
        y <- y - x
        i <- i + 1
    }
    return(cat("modulus=", y, ", Integer division=", i)) # modulus
}

# I want modulus(y, x) to give me 'y mod x' for any integers y and x.
out3 <- modulus3(9, 2)

# Note that without printing out3, the result is already shown.


