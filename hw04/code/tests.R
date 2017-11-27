# =================================================================
# Title: HW04, Stat 133, Fall 2017, testing functions
# Description: 
#       This is a lab work for stat 133, HW04.
#       The main task of this r script file is to create functions
#       for ranking the students in the class
# Author: Pinshuo Ye
# Date: 11-08-2017
# =================================================================

a <- c(1, 4, 7, NA, 10)
b <- c(1, 4, NA, 7, 10)
c <- c(1, NA, 4, 7, NA)
d <- c(NA, 4, NA, 7, 10)

x <- c(1, 4, 7, 10)
y <- c(18, 15, 16, 4, 17, 9) 
z <- c(0, 100, 200, 300)
w <- c(-1, 2, 2, 2, 4)

library(stringr)
library(testthat)
context("Vector Operations")

test_that("The missing value is removed", {
  expect_equal(remove_missing(a), c(1, 4, 7, 10))
  expect_equal(remove_missing(b), c(1, 4, 7, 10))
  expect_equal(remove_missing(c), c(1, 4, 7))
  expect_equal(remove_missing(d), c(4, 7, 10))
})

test_that("get_min is getting vector`s minimum value", {
  expect_equal(get_minimum(a, na.rm = TRUE), 1)
  expect_equal(get_minimum("a"), "non-numeric argument")
  expect_equal(get_minimum(c, na.rm = TRUE), 1)
  expect_equal(get_minimum(d, na.rm = TRUE), 4)
})

test_that("get_max is getting vector`s maximum value", {
  expect_equal(get_maximum(a, na.rm = TRUE), 10)
  expect_equal(get_maximum("a"), "non-numeric argument")
  expect_equal(get_maximum(c, na.rm = TRUE), 7)
  expect_equal(get_maximum(d, na.rm = TRUE), 10)
})

test_that("get_range is getting vector`s range", {
  expect_equal(get_range(a, na.rm = TRUE), 9)
  expect_equal(get_range("a"), "non-numeric argument")
  expect_equal(get_range(c, na.rm = TRUE), 6)
  expect_equal(get_range(d, na.rm = TRUE), 6)
})

test_that("get_percentile10 is getting vector`s 10th percentile", {
  expect_equal(get_percentile10(a, na.rm = TRUE), 1.9)
  expect_equal(get_percentile10("a"), "non-numeric argument")
  expect_equal(get_percentile10(c, na.rm = TRUE), 1.6)
  expect_equal(get_percentile10(d, na.rm = TRUE), 4.6)
})

test_that("get_percentile90 is getting vector`s 90th percentile", {
  expect_equal(get_percentile90(a, na.rm = TRUE), 9.1)
  expect_equal(get_percentile90("a"), "non-numeric argument")
  expect_equal(get_percentile90(c, na.rm = TRUE), 6.4)
  expect_equal(get_percentile90(d, na.rm = TRUE), 9.4)
})

test_that("get_median is getting vector`s median", {
  expect_equal(get_median(a, na.rm = TRUE), 5.5)
  expect_equal(get_median("a"), "non-numeric argument")
  expect_equal(get_median(c, na.rm = TRUE), 4)
  expect_equal(get_median(d, na.rm = TRUE), 7)
})

test_that("get_median is getting vector`s median", {
  expect_equal(get_median(a, na.rm = TRUE), 5.5)
  expect_equal(get_median("a"), "non-numeric argument")
  expect_equal(get_median(c, na.rm = TRUE), 4)
  expect_equal(get_median(d, na.rm = TRUE), 7)
})

test_that("get_average is getting vector`s average", {
  expect_equal(get_average(a, na.rm = TRUE), 5.5)
  expect_equal(get_average("a"), "non-numeric argument")
  expect_equal(get_average(b, na.rm = TRUE), 5.5)
  expect_equal(get_average(d, na.rm = TRUE), 7)
})

test_that("get_stdev is getting vector`s std", {
  expect_equal(get_stdev(a, na.rm = TRUE), sd(a, na.rm = TRUE))
  expect_equal(get_stdev("a"), "non-numeric argument")
  expect_equal(get_stdev(b, na.rm = TRUE), sd(b, na.rm = TRUE))
  expect_equal(get_stdev(d, na.rm = TRUE), sd(d, na.rm = TRUE))
})

test_that("get_stdev is getting vector`s std", {
  expect_equal(get_stdev(a, na.rm = TRUE), sd(a, na.rm = TRUE))
  expect_equal(get_stdev("a"), "non-numeric argument")
  expect_equal(get_stdev(b, na.rm = TRUE), sd(b, na.rm = TRUE))
  expect_equal(get_stdev(d, na.rm = TRUE), sd(d, na.rm = TRUE))
})

test_that("get_quantile1 is getting vector`s first quantlile", {
  expect_equal(get_quantile1(a, na.rm = TRUE), 3.25)
  expect_equal(get_quantile1("a"), "non-numeric argument")
  expect_equal(get_quantile1(b, na.rm = TRUE), 3.25)
  expect_equal(get_quantile1(d, na.rm = TRUE), 5.5)
})

test_that("get_quantile3 is getting vector`s third quantlile", {
  expect_equal(get_quantile3(a, na.rm = TRUE), 7.75)
  expect_equal(get_quantile3("a"), "non-numeric argument")
  expect_equal(get_quantile3(b, na.rm = TRUE), 7.75)
  expect_equal(get_quantile3(d, na.rm = TRUE), 8.5)
})

test_that("countmissing is getting vector`s number of missing value", {
  expect_equal(count_missing(a), 1)
  expect_equal(count_missing(b), 1)
  expect_equal(count_missing(c), 2)
  expect_equal(count_missing(d), 2)
})

test_that("summary_stats is getting vector`s basic summary", {
  expect_equal(length(summary_stats(a)), 11)
  expect_equal(as.numeric(summary_stats(a))[1], 1)
  expect_equal(as.numeric(summary_stats(a))[2], as.numeric(quantile(a, 0.1, na.rm = TRUE)))
  expect_equal(as.numeric(summary_stats(a))[11], as.numeric(summary(a)[7]))
})

test_that("rescale is getting vector`s scaled numbers", {
  expect_equal(rescale100(w, xmin = 2, xmax = 12), c(-30, 0, 0, 0, 20))
  expect_equal(rescale100(x, xmin = 0, xmax = 50), c(2, 8, 14, 20))
  expect_equal(rescale100(y, xmin = 0, xmax = 20), c(90, 75, 80, 20, 85, 45))
  expect_equal(rescale100(z, xmin = 0, xmax = 200), c(0, 50, 100, 150))
})

test_that("drop_lowest is getting vector`s lowest number", {
  expect_equal(drop_lowest(x), c(4, 7, 10))
  expect_equal(drop_lowest(y), c(18, 15, 16, 17, 9))
  expect_equal(drop_lowest(z), c(100, 200, 300))
  expect_equal(drop_lowest("a"), "non-numeric argument")
})

test_that("score_homework is getting vector`s homework score", {
  expect_equal(score_homework(x, drop = TRUE), 7)
  expect_equal(score_homework(x, drop = FALSE), 5.5)
  expect_equal(score_homework(z, drop = TRUE), 200)
  expect_equal(score_homework(w, drop = TRUE), 2.5)
})

test_that("score_quiz is getting vector`s quiz score", {
  expect_equal(score_quiz(x, drop = TRUE), 7)
  expect_equal(score_quiz(x, drop = FALSE), 5.5)
  expect_equal(score_quiz(z, drop = TRUE), 200)
  expect_equal(score_quiz(w, drop = TRUE), 2.5)
})

test_that("score_lab is getting vector`s lab score", {
  expect_equal(score_lab(79), "invalid input")
  expect_equal(score_lab(12), 100)
  expect_equal(score_lab(9), 60)
  expect_equal(score_lab(3), 0)
})


