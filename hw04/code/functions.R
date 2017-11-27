# ===============================================================
# Title: HW04, Stat 133, Fall 2017
# Description: 
#       This is a lab work for stat 133, HW04.
#       The main task of this r script file is to create functions
#       for ranking the students in the class
# Author: Pinshuo Ye
# Date: 11-08-2017
# ===============================================================


# remove_missing
# taking a vector and return the new vector without missing value
remove_missing <- function(x){
  for (i in 1:length(x)){
    remove_na <- c(NA)
    x <- x[! x %in% remove_na]
  }
  x
}
# example of remove_missing() 
a <- c(1, 4, NA, NA, 10) 
remove_missing(a)


# get_minimum
# Creating a function that to find the min value
get_minimum <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    if(na.rm == TRUE){
      x <- sort(remove_missing(x), decreasing = FALSE)
    }else{
      x <- sort(x, decreasing = FALSE)
    }
    x[1]
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_minimum() 
a <- c(1, 4, 7, NA, 10) 
get_minimum(a, na.rm = TRUE)


# get_maximum
# Creating a function that to find the max value
get_maximum <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    if(na.rm == TRUE){
      x <- sort(remove_missing(x), decreasing = TRUE)
    }else{
      x <- sort(x, decreasing = TRUE)
    }
    x[1]
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_maximum() 
a <- c(1, 4, 7, NA, 10) 
get_maximum(a, na.rm = TRUE)


# get_range
# Creating a function that to find the range of the vector
get_range <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    if(na.rm == TRUE){
      x <- sort(remove_missing(x), decreasing = FALSE)
    }else{
      x <- sort(x, decreasing = FALSE)
    }
    x[length(x)] - x[1]
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_range()
a <- c(1, 4, 7, NA, 10) 
get_range(a, na.rm = TRUE)


# Function get_percentile10()
# to computethe 10th percentile of the input vector
get_percentile10 <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    if(na.rm == TRUE){
      x <- sort(remove_missing(x), decreasing = FALSE)
    }else{
      x <- sort(x, decreasing = FALSE)
    }
    x[1] + (x[length(x)] - x[1])*0.1
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_percentile10() 
a <- c(1, 4, 7, NA, 10) 
get_percentile10(a, na.rm = TRUE)


# Function get_percentile90()
# to computethe 90th percentile of the input vector
get_percentile90 <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    if(na.rm == TRUE){
      x <- sort(remove_missing(x), decreasing = FALSE)
    }else{
      x <- sort(x, decreasing = FALSE)
    }
    x[1] + (x[length(x)] - x[1])*0.9
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_percentile10() 
a <- c(1, 4, 7, NA, 10) 
get_percentile90(a, na.rm = TRUE)


# get median
# Write a function to get the median of the vector
get_median <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    if(na.rm == TRUE){
      x <- sort(remove_missing(x), decreasing = FALSE)
    }else{
      x <- sort(x, decreasing = FALSE)
    }
    if(length(x) %% 2 == 1){
      x[(length(x) + 1)/2]
    }else{
      0.5*(x[0.5*length(x)] + x[0.5*length(x) + 1])
    }
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_median() 
a <- c(1, 4, 7, NA, 10) 
get_median(a, na.rm = TRUE)


# get average
# Write a function to get the average of the vector
get_average <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    if(na.rm == TRUE){
      x <- sort(remove_missing(x), decreasing = FALSE)
    }else{
      x <- sort(x, decreasing = FALSE)
    }
    y <- 0
    for(i in 1:length(x)){
      y <- y + x[i]
    }
    y <- y/length(x)
    y
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_average() 
a <- c(1, 4, 7, NA, 10) 
get_average(a, na.rm = TRUE)


# get std
# Write a function to get the std of the vector
get_stdev <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    if(na.rm == TRUE){
      x <- sort(remove_missing(x), decreasing = FALSE)
    }else{
      x <- sort(x, decreasing = FALSE)
    }
    y <- 0
    for(i in 1:length(x)){
      y <- y + (x[i] - get_average(x))^2
    }
    y <- sqrt(y/(length(x) - 1))
    y
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_stdev() 
a <- c(1, 4, 7, NA, 10) 
get_stdev(a, na.rm = TRUE)

# get quantile 1
# Write a function to get the first quantile of the vector
get_quantile1 <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    b <- quantile(x, na.rm = TRUE)
    b <- unname(b)
    b[2]
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_quantile1() 
a <- c(1, 4, 7, NA, 10) 
get_quantile1(a, na.rm = TRUE)


# get quantile 3
# Write a function to get the third quantile of the vector
get_quantile3 <- function(x, na.rm = TRUE){
  if(is.numeric(x)){
    b <- quantile(x, na.rm = TRUE)
    b <- unname(b)
    b[4]
  }
  else{
    print("non-numeric argument")
  }
}
# example of get_quantile3() 
a <- c(1, 4, 7, NA, 10) 
get_quantile3(a, na.rm = TRUE)

# count missing
# count the missing values of the numeric vector
count_missing <- function(x){
  b <- 0
  for (i in 1:length(x)){
    if(is.na(x[i])){
      b <- b + 1
    }
  }
  b
}
# example of count_missing() 
a <- c(1, 4, 7, NA, 10) 
count_missing(a)


# summary_stats()
# Create a summary that takes the num vector and 
# output the basic stat summary
summary_stats <- function(x){
  b <- c(get_minimum(x), get_percentile10(x),
         get_quantile1(x), get_median(x),
         get_average(x), get_quantile3(x),
         get_percentile90(x), get_maximum(x),
         get_range(x), get_stdev(x), count_missing(x))
  names(b) <- c("minimum", "percent10", "quantile1", "median",
                "mean", "quantile3", "percent90", "maximum", 
                "range", "stdev", "missing")
  b <- as.list(b)
  b
}
# example of summary_stats() 
a <- c(1, 4, 7, NA, 10) 
stats <- summary_stats(a)
stats

# print_stats()
# Create a summary that takes the num vector and 
# output the basic stat summary in a better format
print_stats <- function(x){
  for(i in 1:length(x)){
    if(nchar(names(x)[i]) != 9){
      for(j in 1:(9-nchar(names(x)[i]))){
        names(x)[i] <- paste(names(x)[i], " ", sep = "")
      }
    }
  }
  x <- paste(names(x), x, sep = ": ")
  noquote(x)
}
# example of print_stats() 
print_stats(stats)

# rescale100()
# Create a function that using the vector, xmin and
# xmax to scale the numbers
rescale100 <- function(x, xmin, xmax){
  for(i in 1:length(x)){
    x[i] <- (x[i] - xmin)/(xmax - xmin) * 100
  }
  x
}
# example of rescale100() 
b <- c(18, 15, 16, 4, 17, 9) 
rescale100(b, xmin = 0, xmax = 20) 


# creating  drop_lowest()
# creating the function that drop the lowest value 
# of the vector and change the length to (n-1)
drop_lowest <- function(x){
  if(is.numeric(x)){
    for(i in 1:length(x)){
      if(x[i] == get_minimum(x)){
        x[i] <- NA
        break
      }
    }
    remove_missing(x)
  }
  else{
    print("non-numeric argument")
  }
}
# example of drop_lowest() 
b <- c(10, 10, 8.5, 4, 7, 9) 
b <- drop_lowest(b)

# score_homework()
# Creating a function that taking the avg of hw
# with the option of drop
score_homework <- function(x, drop){
  if(drop == TRUE){
    x <- drop_lowest(x)
    get_average(x)
  }else{
    get_average(x)
  }
}
# example of score_homework() 
hws <- c(100, 80, 30, 70, 75, 85) 
score_homework(hws, drop = TRUE)
score_homework(hws, drop = FALSE)



# score_quiz()
# Creating a function that taking the avg of quiz
# with the option of drop
score_quiz <- function(x, drop){
  if(drop == TRUE){
    x <- drop_lowest(x)
    get_average(x)
  }else{
    get_average(x)
  }
}
# example of score_quiz() 
quizzes <- c(100, 80, 70, 0) 
score_quiz(quizzes, drop = TRUE)
score_quiz(quizzes, drop = FALSE)

# score_lab()
# creating the function that output the lab attendence
score_lab <- function(x){
  if(x >= 0 & x <= 12){
    if(x == 11|x == 12){
      print(100)
    }else if(x == 10){
      print(80)
    }else if(x == 9){
      print(60)
    }else if(x == 8){
      print(40)
    }else if(x == 7){
      print(20)
    }else{
      print(0)
    }
  }
  else{
    print("invalid input")
  }
}
# example of score_lab() 
score_lab(12)  
score_lab(10)
score_lab(6)






