# R3.6

## Clean
remove.packages("rstan")
if(file.exists(".Rdata")) file.remove(".Rdata")
if(file.exists("~/.Renviron")) unlink("~/.Renviron")
if(file.exists("~/.Rprofile")) unlink("~/.Rprofile")
if(file.exists("~/.R/Makevars.win")) unlink("~/.R/Makevars.win")

## configure toolchain

# install RTools
install.packages("pkgbuild")
rt_path <- gsub("//", "/", pkgbuild::rtools_path(), fixed = T)
rt_bin <- paste0(substr(rt_path, 1, nchar(rt_path)-4), "/mingw_${WIN}/bin/")
writeLines(paste0('PATH="', rt_path,';${PATH}'), con = "~/.Renviron")
writeLines(paste0('Sys.setenv(BINPREF = "', rt_bin, '")'), con = "~/.Rprofile")
install.packages("jsonlite", type = "source") # ca marche !

# Makevars Configuration
dotR <- file.path(Sys.getenv("HOME"), ".R")
if(!file.exists(dotR)) dir.create(dotR)
M <- file.path(dotR, "Makevars.win")
if(file.exists(M)) unlink(M)
file.create(M)
cat("CXX14=$(BINPREF)g++ -std=c++1y\nCXX14FLAGS += -mtune=native -O3 -mmmx -msse -msse2 -msse3 -msse4.1 -msse4.2",
    file = M, sep = "\n", append = F)

# withr version
remove.packages("withr")
install.packages("withr")
devtools::install_version("withr", version="2.2.0", 
                          lib = "C:/Users/Utilisateur/Documents/.withr") # The good version of withr for stan in the .withr folder

## Rstan from source
Sys.setenv(MAKEFLAGS = "-j4")
install.packages("rstan", type = "source")

# Test
source("code.R")
