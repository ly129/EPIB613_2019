
vector <- 2:6
vector

# Pick the 2nd
vector[2]

# Pick 2nd - 4th
vector[2:4]

# Pick no. 1, 3, 5
vector[c(1, 3, 5)]

# Code like a pro
# This good practice makes it clearer for revisits and/or edits
# Reproducibility!

# Pick no. 1, 3, 5
index <- c(1, 3, 5)

vector[index]

# Use the index system to re-order
vector[c(5,4,3,2,1)]

# Recall that we could give names to vector entries
names(vector) <- letters[2:6]; vector

vector["b"]

matrix <- matrix(c(3:14), nrow = 4, byrow = TRUE)
print(matrix)
# Note that the indices are given.

matrix[2, 3]

matrix[2, ]

matrix[ , c(1, 3)]

# Change the order of columns. 
matrix[ , c(3, 1)]

rownames(matrix)

# Recall that we could give names to columns and rows

row.names <- c("row1", "row2", "row3", "row4")
col.names <- c("col1", "col2", "col3")
rownames(matrix) <- row.names
colnames(matrix) <- col.names
print(matrix)
rownames(matrix)

matrix["row1", ]
# The output is a named vector as a result of dimension reduction

matrix["row2", "col3"]

array <- array(3:14, dim = c(2, 3, 2))
print(array)

array[ , , 1]

array[2, 3, 2]

array[1, , 2]

df <- data.frame(names = c("Lucy", "John", "Mark", "Candy"),
                 score = c(67, 56, 87, 91))

print(df)

df[2, ]

df[ , 1]

# There are (column) names that are ready to use in data frames.
names(df)

df$names
# data.frame$variable.name gives the variable.

vector
vector[vector>4]

vector>4

# What is John's score?
df[df$names == "John",]

# How does this work?
df$names == "John"

# Anyone scored 100?
print(df[df$score == 100,])

# Highest score?
max(df$score)     # max() for maximum

# Who had the highes score?
df[df$score == max(df$score), ]

# Note that this is still a data frame.
str(df[df$score == max(df$score), ])

# I only need the name.
df[df$score == max(df$score), ]$names

# Change the order of columns
df[ , c("score", "names")]
# By now you should have realized that,
# we change the order of columns by picking the columns
# in the order that we want.

list <- list("Red", factor(c("a","b")), c(21,32,11), TRUE)
print(list)

list[[1]]

list[[3]][2]

head(mtcars) # You can use this dataset directly whenever you want.

# data() # Shows all datasets in base R.

# head(cancer)
# Load 'cancer' data before loading the 'survival' package will result in error.
library(survival)
head(cancer)

# ?read.table     # Uncomment to run the code

x <- read.csv(file = "http://www.medicine.mcgill.ca/epidemiology/hanley/bios602/MultilevelData/otitisDataTall.txt",
              header = FALSE)
dim(x)

head(x) # head() Displays the first 6 (default) rows.

xx <- read.csv(file = "http://www.medicine.mcgill.ca/epidemiology/hanley/bios602/MultilevelData/otitisDataTall.txt",
               header = TRUE)
dim(xx)

head(xx) # Note that "header = TRUE" makes the first row column names.

# d <- read.csv(file.choose())

df
write.csv(df, file = "~/Desktop/df.csv")

# Check the dimensions of the data frame.
dim(mtcars)

# Check the column names
names(mtcars)

# Or if you remember the function str()
str(mtcars)

# Look at the first few rows, default is 6 rows
head(mtcars, n=10)

# Check the last few rows, default is 6 rows
tail(mtcars, n = 3)

# Quick summary of the data frame
summary(mtcars)

# Check missing values
sum(is.na(mtcars))
# is.na() is true if a cell is "NA" - missing value
# sum() over all cells tells how many true's there are.
# Recall from Lecture 2.
