
# ?ToothGrowth
tg <- ToothGrowth
rbind(head(tg, 3), tail(tg, 3))

# Check the dimension
dim(tg)

# Summary
summary(tg)
# Note the difference for categorical and numeric variables.

var(tg$len)

n.sample = dim(tg)[1]
sum((tg$len - mean(tg$len))^2)/(n.sample - 1)

par(mfrow=c(2 ,2))
hist(tg$len,
     main = "Distribution of Tooth Length",
     xlab = "Length",
     freq = F,   # F gives probability, T gives count
     breaks = 2) # Number of bars
hist(tg$len,
     main = "Distribution of Tooth Length",
     xlab = "Length",
     freq = F,
     breaks = 5)
hist(tg$len,
     main = "Distribution of Tooth Length",
     xlab = "Length",
     freq = F,
     breaks = 20)
hist(tg$len,
     main = "Distribution of Tooth Length",
     xlab = "Length",
     freq = F,
     breaks = 100)
rug(tg$len, col = "red")# Add ticks at the data points on the x axis.

# Is the distribution normal?
# See how different number of bins can affect our arbitrary judgement of the distribution.

hist(tg$len, freq = F, ylim = c(0, 0.05))
lines(density(tg$len), col = "red", lwd = 2)

par(mfrow = c(1, 2))
boxplot(tg$len, main = "No outlier - Too bad for teaching")
fake.len <- c(tg$len, 50)
boxplot(fake.len, main = "After adding a fake outlier")
points(x = rep(1,3), quantile(fake.len, seq(0.25, 0.75, 0.25)), pch = "X", col = "red")
points(x=rep(1,2), c(min(tg$len), max(tg$len)), pch = "X", col = "blue")
points(x=1, max(fake.len), pch = "X", col = "purple")
# Box: IQR - 25th and 75th quantile
# Whiskers: the lowest datum still within 1.5 IQR of the lower quartile,
# and the highest datum still within 1.5 IQR of the upper quartile

set.seed(613)
par(mfrow = c(1,2))
plot(ecdf(tg$len), main = "ECDF")
plot(ecdf(rnorm(1000)))

qqnorm(tg$len)
qqline(tg$len)

# recall aggregate( )
aggregate(len~., data = tg, FUN = mean)

tapply(tg$len,
       INDEX = list(tg$supp, tg$dose),
       FUN = mean)

by(tg$len,
   INDICES = list(supp = tg$supp, dose = tg$dose),
   FUN = mean)

# aggregate(len~., data = tg, FUN = range)
# Gives an error - has to be 1D.

# A list of length 6
print(tapply(tg$len,
             INDEX = list(tg$supp, tg$dose),
             FUN = range))
# One of the 6 items in the list.
tapply(tg$len,
       INDEX = list(tg$supp, tg$dose),
       FUN = range)[[1]]

by(tg$len,
   INDICES = list(supp = tg$supp, dose = tg$dose),
   FUN = range)

par(mfrow = c(2,3))
aggregate(len~., data = tg, FUN = hist)

par(mfrow = c(2,3))
tapply(tg$len,
       INDEX = list(tg$supp, tg$dose),
       FUN = qqnorm)

par(mfrow = c(2,3))
by(tg$len,
   INDICES = list(supp = tg$supp, dose = tg$dose),
   FUN = qqnorm)

head(mtcars)

cov(mtcars[, c("mpg", "cyl", "disp", "hp")])

cor(mtcars[, c("mpg", "cyl", "disp", "hp")])

plot(mtcars[, c("mpg", "cyl", "disp", "hp")])
# See how powerful the plot function is.

cov(mtcars$mpg, mtcars$disp)

str(qqnorm(tg$len))
