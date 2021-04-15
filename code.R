library(rstan)
x <- rnorm(n = 10)
a <- 0
b <- 1
y <- a*x + b
fit <- stan("model.stan", data = list(x = x, y = y, N = length(x)))
