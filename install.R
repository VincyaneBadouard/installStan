# R3.6

## configure toolchain

# install RTools
install.packages("pkgbuild")
  
rt_path <- gsub("//", "\\", pkgbuild::rtools_path(), fixed = T)
rt_bin <- paste0(substr(rt_path, 1, nchar(rt_path)-4), "/mingw_${WIN}/bin/")
writeLines(paste0('PATH="', rt_path,';${PATH}'), con = "~/.Renviron")
writeLines(paste0('Sys.setenv(BINPREF = "', rt_bin, '")'), con = "~/.Rprofile")

install.packages("jsonlite", type = "source") # ca marche !

# Makevars Configuration
dotR <- file.path(Sys.getenv("HOME"), ".R")
if(!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, "Makevars.win")
if(!file.exists(M)) file.create(M)
cat("\n CXX14FLAGS += -mtune=native -O3 -mmmx -msse -msse2 -msse3 -msse4.1 -msse4.2",
    file = M, sep = "\n", append = F)
# Il manque la ligne suivante dans le Makevars
# CXX14=$(BINPREF)g++ -std=c++1y

# withr version
devtools::install_version("withr", version="2.2.0")

## Rstan from source
remove.packages("rstan")
if(file.exists(".Rdata")) file.remove(".Rdata")

Sys.setenv(MAKEFLAGS = "-j4")

install.packages("rstan", type = "source")

example(stan_model, package = "rstan", run.dontrun = T)
