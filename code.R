# withr bug
# library(withr)
# packageVersion("withr")

# withr fix
# restart R session first
library(withr, lib.loc = "~/.withr/") # take withr in the .withr folder
packageVersion("withr")


library(rstan)
x <- rnorm(n = 10)
a <- 0
b <- 1
y <- a*x + b
fit <- stan("model.stan", data = list(x = x, y = y, N = length(x)))
