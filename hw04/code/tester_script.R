# ===============================================================
# Title: HW04, Stat 133, Fall 2017, testing functions
# Description: 
#       This is a lab work for stat 133, HW04.
#       The main task of this r script file is to create functions
#       for ranking the students in the class
# Author: Pinshuo Ye
# Date: 11-08-2017
# ===============================================================

# test script 
library(testthat)
# source in functions to be tested 
source('functions.R')

sink('../output/test-reporter.txt') 
test_file('tests.R') 
sink()