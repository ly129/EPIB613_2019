
df <- data.frame(names = c("Lucy", "John", "Mark", "Candy"),
                score = c(67, 56, 87, 91))
for (i in 1:4){
    df$student.no[i] <- paste("student", i)
    df$pass[i] <- ifelse(df$score[i] >= 60, TRUE, FALSE)
}
df

names(df)

# Recall the indexing system in R
df$names   # Select one variable

# Delete one variable
df.copy <- df
df.copy$names <- NULL
df.copy

df[, 2]

df[ , "score"]

str(df[ , "score"])   # 1D vector

df[ , "score", drop = FALSE]
str(df[ , "score", drop = FALSE])   # 4 x 1 data frame
# The argument "drop = FALSE" maintains the original dimension
# The default is true

df[1, ]
str(df[1, ])   # 1 x 4 data frame
# Can we drop a dimension here? Why?

df[1, , drop = TRUE]

# Delete variable "names" + reorder columns
df[ , c("student.no", "score", "pass")]

# Select rows that passed
df[df$pass == TRUE, ]

# Delete variable
df[ , -c(1, 2)]   # Delete the 1st and 2nd

# I believe that this used to work, but not anymore.
# df[ , -c("names", "score")]

# Now
drop <- c("names", "score")
df[ , !names(df) %in% drop]

select = c("student.no", "pass")
df[ , names(df) %in% select]

# How does this work?
1 %in% c(1, 3, 5)
"b" %in% c("a", "c", "e")
1:10 %in% c(1, 3, 5)



# "select" argument selects columns
subset(df, select = c(student.no, pass))

# Can also delete unwanted columns
subset(df, select = -c(names, score))

# "subset" argument selects rows
# Can apply conditions
subset(df, subset = (score > 80))

# Now use both select and subset arguments to apply conditions
# Select the names of those who passed
subset(df, select = names, subset = (pass == TRUE))

# Show the name and score of those who passed except Lucy(s).
# Recall logical operators &, | and !

library(dplyr)

# Show the name and score of those who passed except Lucy(s).
df.col <- filter(df, names != "Lucy" & pass == TRUE)
df.col

df.final <- select(df.col, c(names, score))
df.final

df

new.students <- data.frame(names = c("Name", "Nom"),
                           score = c(79, 48),
                           student.no = c("student 5", "student 6"),
                           pass = c(TRUE, FALSE))
new.students

df.new <- rbind(df, new.students); df.new

# Option 1
df.copy$id1 <- 1:4
df.copy

# Option 2
df.copy <- data.frame(df.copy, id2 = 1:4)
df.copy

# Option 3
id3 <- 1:4
cbind(df.copy, id3)

# df stores student's EPIB 613 score
df

# df.major stores student's program of study
df.major <- data.frame(student.no = c("student 1", "student 2", "student 3", "student 4", "student 5", "student 6"),
                       major = c("MSc PH", "PhD Epi", "MSc Epi", "MSc PH", "PhD Biostat", "MSc Biostat"))
df.major

# See what does the argument 'all' do.
df.full <- merge(df, df.major, by = "student.no", all = F)
df.full

# Some simple simulation
# People who take the drug, that are obese and that are younger are more likely to be cured.
# Setting seeds make random number generation reproducible.
set.seed(613)
n <- 100
drug <- sample(c(0, 1), size = n, replace = TRUE, prob = c(0.8, 0.2))
obesity <- sample(c(0, 1), size = n, replace = TRUE, prob = c(0.5, 0.5))
age <- round(rnorm(n, mean = 60, sd = 10))
logit.p <- log(1.8)*drug + log(0.85)*(age - 60) + log(1.2)*obesity + log(0.2)
p <- exp(logit.p)/(1 + exp(logit.p))
cured <- rbinom(n, size = 1, prob = p)
sim <- data.frame(drug, obesity, age, cured)
head(sim, 10)

# Tabulate exposure and outcome
table(sim[, c("drug", "cured")])
# ~20% among unexposed to the drug are cured
# 40% among exposed are cured



# Syntax 1
aggregate(x = sim$age, by = list(drug = sim$drug), FUN = mean)

# Alternative syntax
# I highly recommend this one
aggregate(age~drug, data = sim, FUN = mean)

# Mean age by exposure-obesity group, so 2 binary conditions and 4 subgroups
aggregate(x = sim$age, by = list(drug = sim$drug, obesity = sim$obesity), FUN = mean)

aggregate(age~drug+obesity, data = sim, FUN = mean)

# aggregate() can also take multiple target variables
aggregate(x = cbind(sim$age, sim$cured), by = list(drug = sim$drug, obesity = sim$obesity), FUN = mean)

aggregate(cbind(age, cured)~drug+obesity, data = sim, FUN = mean)

table(sim[, c("drug", "obesity", "cured")])


