n <- 10000
x <- rnorm(n, mean = 100, sd = 20)
diff(range(x))

boot.iter <- 1000
rangeX <- numeric(boot.iter)

set.seed(613)
for (i in 1:boot.iter) {
    boot.index <- sample(1:n, n, replace = T)
    boot.sample <- x[boot.index]
    rangeX[i] <- diff(range(boot.sample))
}
quantile(x = rangeX, probs = c(0.025,0.5,0.975))
hist(rangeX, breaks = 20)

# Illustration of the idea on a different dataset.
stroke <- read.csv("https://raw.githubusercontent.com/ly129/EPIB613_2019/master/stroke.csv")
head(stroke)

fit <- glm(dead~sex+diab+coma+minf, data = stroke, family = binomial())
exp(coef(fit))

# ROR of myocardial infarction vs. diabetes
ROR_minf_diab <- exp(coef(fit))[5] / exp(coef(fit))[3]
ROR_minf_diab

exp(confint(fit))

n <- nrow(stroke)
boot.iter <- 1000
ROR <- numeric(boot.iter)

set.seed(613)
for (i in 1:boot.iter) {
    boot.index <- sample(1:n, n, replace = T)
    boot.sample <- stroke[boot.index, ]
    fit <- glm(dead~sex+diab+coma+minf, data = boot.sample, family = binomial())
    ROR[i] <- exp(coef(fit))[5] / exp(coef(fit))[3]
}
quantile(x = ROR, probs = c(0.025,0.5,0.975))
hist(ROR, breaks = 20)

library(survival)
# 1=censored, 2=dead
lung <- lung[complete.cases(lung), ]
head(lung)

head(Surv(time = lung$time, event = lung$status))

km <- survfit(Surv(time, status)~1, conf.int = 0.95, data = lung)
# summary(km)

plot(km, conf.int = T, main = "Kaplan-Meier Survival Curve")

km.sex <- survfit(Surv(time, status)~sex, conf.int = 0.95, data = lung)
plot(km.sex, col = 2:3)
legend("topright", legend=c("Male", "Female"), col=2:3, lty=c(1,1))

# Complementary log-log plot is used to check assumptions visually
# If parallel, proportional hazard assumption holds -> Cox Model (Section 12.2.3)
plot(km.sex, fun = "cloglog", col = 2:3, xlab = "Time", ylab = "log[-log S(t)]",
     main = "Complementary log-log survival plot", log = "x", xmax = 2000)
legend("topleft", legend = c("Male", "Female"), lty = c(1,1), col = 2:3)

# Optional
# Cumulative hazard plot
plot(km.sex, fun = "cumhaz", main="Cumulative Hazard vs. Time", col = 2:3)
legend("topleft", legend = c("Male", "Female"), lty = c(1,1), col = 2:3)

survdiff(Surv(time, status)~sex, data = lung)

fit.cox1 <- coxph(Surv(time,status)~sex, data = lung)
summary(fit.cox1)

# Multiple Cox regression
fit.cox2 <- coxph(Surv(time,status)~., data = lung)
summary(fit.cox2)

fit.cox3 <- coxph(Surv(time,status)~inst+sex+ph.ecog+ph.karno+wt.loss, data = lung)

# Model Comparison
print(anova(fit.cox1, fit.cox3))
# So here the full model has significantly better likelihood.
# Therefore, reject the reduced model.

cox.zph(fit.cox3)

par(mfrow = c(2,3))
plot(cox.zph(fit.cox3))

cd4 <- read.table("https://raw.githubusercontent.com/ly129/EPIB613_2019/master/cd4.txt", header = TRUE)
cd4$Date <- as.Date(cd4$Date, tryFormats = "%m/%d/%Y")
cd4$Treatment <- cd4$Treatment - 1
head(cd4, 10)

# Total observations
dim(cd4)

# Total patients
length(unique(cd4$ID))

plot(y = cd4[cd4$ID == 1,]$CD4Pct,
     x = cd4[cd4$ID == 1,]$Date,
     type = 'b', xlab = "Date", ylab = "CD4 Percentage", col = 1,
     ylim = range(cd4$CD4Pct[1:27]),
     xlim = range(cd4$Date[1:27]))
for (i in 2:6) {
    lines(y = cd4[cd4$ID == i,]$CD4Pct,
          x = cd4[cd4$ID == i,]$Date,
          col = i, type = "b")
}

library(lme4)

# Random intercept model
# We can see that the syntax is exactly the same as in lm()
fit1 <- lmer(formula = CD4Pct~Date+BaseAge+Treatment+(1|ID), data = cd4)
summary(fit1)

plot(fit1@u, main = "Fitted Random Intercepts")

# Random intercept + random slope for treatment
# We can see that the syntax is exactly the same as in glm()
fit2 <- lmer(formula = CD4Pct~Date+BaseAge+Treatment+(1+Treatment|ID),REML = T, data = cd4)
summary(fit2)

# lme4 package also has generalized linear mixed effects model
# We can see that the syntax is exactly the same as in glm()

glmer(formula = Treatment~BaseAge+ARV+(1|ID), family = binomial(), data = cd4)

# # Another package is nlme
library(nlme)
fit.intercept <- lme(fixed = CD4Pct~Date+BaseAge+Treatment, random = ~1|ID, data = cd4)
fit.intercept.slope <- lme(fixed = CD4Pct~Date+BaseAge+Treatment, random = ~1+Treatment|ID, data = cd4)

set.seed(613)
x <- sort(runif(100, -10,10))
y <- x^2 + rnorm(100, 0, 5)
plot(function(a){a^2}, xlim = c(-10,10), lwd = 3, col = "red", ylim = c(-10, 110))
points(x = x, y = y)

xy <- data.frame(x = x, y = y)
xy$x.square <- x^2

fit1 <- lm(y~x, data = xy); abline(fit1, col = "blue", lwd = 3)
fit2 <- lm(y~x+x.square, data = xy)
xx <- seq(-10, 10, by = 0.1)
fit2
yy <- predict(fit2, newdata = data.frame(x = xx, x.square = xx^2))
lines(x = xx, y = yy, col = "green", lwd = 3)
legend("top", legend = c("y = x^2", "lm(y~x)", "lm(y~x+x^2)"),
       lty = 1, col = c("red", "blue", "green"), lwd = c(3,3,3))

library(splines)

# 5 knots
head(bs(x, knots = 5))

fit.splines <- lm(y~bs(x, knots = 5))

plot(function(a){a^2}, xlim = c(-10,10), lwd = 3, col = "red",
    ylim = c(-10, 110))
points(x = x, y = y)
lines(x, y = predict(fit.splines, newdata = bs(x, knots = 5)), col = "green", lwd = 3)
legend("top", legend = c("True", "Splines"), lwd = c(3,3), lty = c(1,1), col = c("red", "green"))


