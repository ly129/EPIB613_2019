# Set seed for reproducibility
set.seed(613)

# 100 diamond rings ranging from 1 to 1.5 carats
n <- 100
carat <- runif(n = n, min = 1, max = 1.5)
color <- as.factor(sample(c("G", "H"), size = n, replace = TRUE))

# Normally distributed deviation from my perfect model caused by other factors
error <- rnorm(n = n, mean = 0, sd = 0.5)

# On average:
# 1.00 carat: $10k;
# ................;
# 1.50 carat: $20k;

# Comparing to the average price.
# G color increases the price by 500
# H color decreases the price by 500
price <- -5 + 20 * carat + error + ifelse(color == "G", 0.5, -0.5)

plot(x = carat, y = price, main = "Price vs Carat - Fake Data")

fit1 <- lm(price~carat); fit1

# If our data is a data.frame, note the data argument.
diamond <- data.frame(Price = price, Carat = carat, Color = color)
head(diamond)
aggregate(Price~Color, data = diamond, mean)
table(diamond$Color)

fit1 <- lm(Price~Carat, data = diamond)
summary(fit1)

plot(x = carat, y = price, main = "Price vs Carat - Fake Data")
# Draw the best fit line from our linear model.
abline(fit1, col = "red")

# Explore the structure of fit1 and summary(fit1) to see how to extract values.
# str(fit1)
# str(summary(fit1))

summary(fit1)$coefficients

# Confidence intervals - default is 95%
confint(fit1, level = 0.95)

par(mfrow = c(2,2))
plot(fit1)

fit2 <- lm(Price~Carat+Color, data = diamond)
summary(fit2)

# Adjust for all other variables in the dataset other than Price.
# lm(Price~., data = diamond)

# Adjust for interaction terms - effect measure modification EPIB 603.
# lm(Price~ Carat + Color + Carat:Color, data = diamond)
# Equivalent to
# lm(Price~ Carat * Color, data = diamond)

predict(fit2, newdata = data.frame(Carat=1.22, Color="G"), interval = "confidence")

predict(fit2, newdata = data.frame(Carat=1.22, Color="G"), interval = "prediction")

CI <- predict(fit1, newdata = data.frame(Carat=seq(1,1.5,0.1)), interval = "confidence")
PI <- predict(fit1, newdata = data.frame(Carat=seq(1,1.5,0.1)), interval = "prediction")
plot(x = carat, y = price, main = "Price vs Carat - Fake Data")
# Draw the best fit line from our linear model.
abline(fit1, col = "red")
lines(x = seq(1,1.5,0.1), y = CI[,2], col = "green")
lines(x = seq(1,1.5,0.1), y = CI[,3], col = "green")

lines(x = seq(1,1.5,0.1), y = PI[,2], col = "blue")
lines(x = seq(1,1.5,0.1), y = PI[,3], col = "blue")

legend("bottomright", col = c("red", "green", "blue"), lty = c(1,1,1),
       legend = c("Fitted Line", "Confidence Interval", "Prediction Interval"))

price.G <- subset(x = diamond, Color == "G")$Price
price.H <- subset(x = diamond, Color == "H")$Price
mu.G <- mean(price.G)
mu.H <- mean(price.H)
mu.tot <- mean(diamond$Price)
data.frame(G=mu.G, H=mu.H, Total=mu.tot)

t.test(price.G, price.H)

myanova <- aov(Price~Color, data = diamond)
summary(myanova)

# Reproduce the test result from scratch
# ss means sum of squares
ss.within = sum((price.G-mu.G)^2) + sum((price.H-mu.H)^2)
ss.between = (mu.G-mu.tot)^2 * 48 + (mu.H-mu.tot)^2 * 52
ss.total = sum((price-mu.tot)^2)
data.frame(Within = ss.within, Between = ss.between, Total = ss.total)

head(diamond$Carat, 20)

anova(fit1)

anova(fit2)

print(anova(fit1, fit2))
