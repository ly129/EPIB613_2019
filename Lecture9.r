
set.seed(613)
# Sample from an extremely skewed population, e.g. exponential distribution.
x <- seq(from = 0, to = 10, by = 0.01)
y <- dexp(x = x, rate = 1)
par(mfrow=c(2,2))
plot(y = y, x = x, type = "l", main = "Exponential Density", ylab = "Density")

# Draw 5000 samples of size 5, 25 & 100, and plot the distribution of the sample mean.
sample5 <- sample25 <- sample100 <- rep(NA, 5000)
for (i in 1:5000){
    sample5[i] <- mean(rexp(n = 5, rate = 1))
    sample25[i] <- mean(rexp(n = 25, rate = 1))
    sample100[i] <- mean(rexp(n = 100, rate = 1))
}
hist(sample5, freq = F)
# curve(dexp, from = 0, to = 5, add = T)
hist(sample25, freq = F)
# curve(dexp, from = 0, to = 5, add = T)
hist(sample100, freq = F)
# curve(dexp, from = 0, to = 5, add = T)

# Recall a visual check of normality - Normal Q-Q plot
par(mfrow = c(2,2))
qqnorm(y)
qqline(y)
qqnorm(sample5)
qqline(sample5)
qqnorm(sample25)
qqline(sample25)
qqnorm(sample100)
qqline(sample100)

n <- 20
x <- rnorm(n, mean = 2, sd = 2) # Sample is actually drawn from N(2,4)
z <- (mean(x) - 1) / sqrt(4/n); z
p.val <- 2 * pnorm(q = z, mean = 0, sd = 1, lower.tail = F); p.val
# Rejected at alpha=0.05.

t.test(x = x, mu = 1)

# Reproduce the result
s.squared <- var(x)
t <- (mean(x) - 1) / sqrt(s.squared/n); t
p.val <- 2 * pt(q = t, df = n-1, lower.tail = F); p.val 
# Rejected at alpha=0.05.

n <- 50
y <- rpois(n = n, lambda = 3)

# If sigma^2=3 is known, we use z-score.
z <- (mean(y)-3)/sqrt(3/50)
p.val <- 2 * pnorm(q = z, mean = 0, sd = 1); p.val
# Rejected at alpha=0.05.

t.test(x = y, mu = 3)   # mu = 3 is the null hypothesis.

# Reproduce the result
(mean(y)-3)/sqrt(var(y)/n)

y1 <- rexp(n = n, rate = 1)       # mean = 1
y2 <- rexp(n = 2 * n, rate = 2)   # mean = 0.5
t.test(y1, y2, mu = 0.5, alternative = "greater")
# Default is "two-sided".

# No need to worry about the data generation process.
bmi.before <- rnorm(n = 50, mean = 30, sd = 8)
bmi.after <- bmi.before - rnorm(n = 50, mean = 3, sd = 2)
Patient.ID <- 1:50
d <- data.frame(Patient.ID, bmi.before, bmi.after)
head(d)

cor(bmi.before, bmi.after)
# The two variables are highly correlated.
# Those with high BMI before treatment are still relatively high after the treatment.
# We should only compare within pairs.

var(bmi.before)
var(bmi.after)
# Sometimes we can assume that the two variables have the same variance
# based on topic-specific knowledge.

t.test(x = bmi.before, y = bmi.after, mu = 3,
       alternative = "greater", paired = T, var.equal = T)
# var.equal = TRUE assumes equal variance.

data(airquality)
airquality$Month <- factor(airquality$Month, labels = month.abb[5:9])
aggregate(Wind~Month, data = airquality, FUN = mean)

pairwise.t.test(airquality$Wind, airquality$Month)

x1 <- rnorm(100, mean = 1, sd = 5)
x2 <- rnorm(50, mean = 5, sd = 8)
var.test(x1, x2)

# Reproduce the result
f <- var(x1)/var(x2); f
2 * pf(q = f, df1 = 99, df2 = 49)

prop.test(x = 7, n = 10, p = 0.5, correct = F)

# Reproduce the result
observed <- c(7,3)
expected <- c(5,5)
X2 <- sum((observed-expected)^2/expected); X2
pchisq(q = X2, df = 2-1, lower.tail = F)

# Reproduce the result
chisq.test(c(7,3), correct = F)

prop.test(x = 7, n = 10, p = 0.5, correct = T)

# Reproduce the result
X2 <- sum((abs(observed-expected)-0.5)^2/expected); X2

binom.test(7, 10)

# Reproduce the result
2 * pbinom(q = 6, size = 10, prob = 0.5, lower.tail = F)

dead <- c(5, 8)
alive <- c(15, 12)
total <- c(20, 20)
prop.test(dead, total, correct = F)

data.frame(dead, alive, total)

exp.dead <- rep(mean(dead), 2)
exp.alive <- rep(mean(alive), 2)
data.frame(exp.dead, exp.alive, total)

# Reproduce the result
# With the same formula
obs <- c(5, 8, 12, 15)
exp <- c(6.5, 6.5, 13.5, 13.5)
sum((obs-exp)^2/exp)

chisq.test(data.frame(dead, alive), correct = F)

cor(bmi.before, bmi.after)

cor.test(bmi.before, bmi.after)

# Reproduce the result
r <- cor(bmi.before, bmi.after)
se.r <- sqrt((1-r^2)/(50-2))
r/se.r
