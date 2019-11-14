set.seed(613)
x <- c(runif(10, min = 1, max = 6), runif(10, min = 5, max = 10))
y <- c(rep(0,10), rep(1,10))
plot(x, y, main = "Does this linear model make sense?", cex = 2, pch = "+")
abline(lm(y~x), col = "red")

df <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
df$rank <- ceiling(df$rank/2) - 1
head(df)

table(df[,c("rank", "admit")])[c(2,1),c(2,1)]

OR <- 40*125/(87*148); OR

fit1 <- glm(admit~rank,
            family = binomial(link = "logit"),
            data = df)
summary(fit1)

exp(fit1$coefficients)
OR

exp(confint(fit1))

# type = "response" gives the fitted probability
nd <- data.frame(rank = c(0,1))
predict(fit1, type = "response", newdata = nd)

# type = "link" give the fitted linear predictor
predict(fit1, type = "link", newdata = nd)

log(0.212765957446936/(1-0.212765957446936))
log(0.410377358490567/(1-0.410377358490567))

fit2 <- glm(admit~gpa,
            family = binomial(),
            data = df)
summary(fit2)
# the link function for binomial family is logit by default - canonical link

fit2$coefficients

exp(fit2$coefficients)

predict(fit2, newdata=data.frame(gpa=4), type="response")

exp(-4.35758730334778+1.05110872619157*4)/(1+exp(-4.35758730334778+1.05110872619157*4))

lb <- 2
ub <- 4
plot(x = df$gpa, y = df$admit,
     main = "Fitted Admission Probability vs GPA", xlim = c(lb,ub))
fitted.admit <- predict(fit2,
                        newdata = data.frame(gpa = seq(lb,ub,0.01)),
                        type = "response")
lines(sort(x = seq(lb,ub,0.01)), y = sort(fitted.admit), col = "red")

# The relationship should be a S-shaped curve.
# We are not seeing the curve because the range of GPA is too small.

fit3 <- glm(admit~., family = binomial(), data = df)
summary(fit3)

# print is not necessary in R or Rstudio.
print(anova(fit2, fit3, test = "LRT"))
# LRT -> likelihood ratio test
# test = "Chisq" is equivalent here.

print(anova(fit1, test = "Chisq"))

library(MASS)
ds <- ships
ds <- ds[ds$service>0, ]
head(ds)

fit4 <- glm(incidents~type,
            family = poisson(link = "log"),
            data = ds)
summary(fit4)

summary(fit4)$coefficients

exp(confint(fit4))

# The canonical link for poisson regression is log, so omitted.
fit5 <- glm(incidents~type+offset(log(service)),
            family = poisson(), data = ds)
summary(fit5)

fit6 <- glm(incidents~type+as.factor(year)+offset(log(service)), family = poisson(), data = ds)

fit7 <- glm(incidents~type+as.factor(year)+as.factor(period)+offset(log(service)), family = poisson(), data = ds)

# anova() allows for comparison of many models at the same time.
print(anova(fit5, fit6, fit7, test = "LRT"))
