# ===============================================================
# Title: HW04, Stat 133, Fall 2017, cleaning data
# Description: 
#       This is a lab work for stat 133, HW04.
#       The main task of this r script file is to clean the raw
#       data.
# Date: 11-25-2017
# ===============================================================

library(readr)
dat <- data.frame(
  read_csv(
    "..\\data\\rawdata\\rawscores.csv"
  ))

# output the str of the data frame 
sink('../output/summary-rawscores.txt') 
str(dat)
print("Hw1")
summary_stats(dat$HW1)
print_stats(summary_stats(dat$HW1))
print("Hw2")
summary_stats(dat$HW2)
print_stats(summary_stats(dat$HW2))
print("Hw3")
summary_stats(dat$HW3)
print_stats(summary_stats(dat$HW3))
print("Hw4")
summary_stats(dat$HW4)
print_stats(summary_stats(dat$HW4))
print("Hw5")
summary_stats(dat$HW5)
print_stats(summary_stats(dat$HW5))
print("Hw6")
summary_stats(dat$HW6)
print_stats(summary_stats(dat$HW6))
print("Hw7")
summary_stats(dat$HW7)
print_stats(summary_stats(dat$HW7))
print("Hw8")
summary_stats(dat$HW8)
print_stats(summary_stats(dat$HW8))
print("Hw9")
summary_stats(dat$HW9)
print_stats(summary_stats(dat$HW9))
print("ATT")
summary_stats(dat$ATT)
print_stats(summary_stats(dat$ATT))
print("QZ1")
summary_stats(dat$QZ1)
print_stats(summary_stats(dat$QZ1))
print("QZ2")
summary_stats(dat$QZ2)
print_stats(summary_stats(dat$QZ2))
print("QZ3")
summary_stats(dat$QZ3)
print_stats(summary_stats(dat$QZ3))
print("QZ4")
summary_stats(dat$QZ4)
print_stats(summary_stats(dat$QZ4))
print("EX1")
summary_stats(dat$EX1)
print_stats(summary_stats(dat$EX1))
print("EX2")
summary_stats(dat$EX2)
print_stats(summary_stats(dat$EX2))
sink()

# Replacing all the na`s into 0
for(i in 1:16){
  for(j in 1:334){
    if(is.na(dat[j, i])){
      dat[j, i] <- 0
    }
  }
}

#rescaling quiz
dat$QZ1 <- rescale100(dat$QZ1, xmin = 0, xmax = 12)
dat$QZ2 <- rescale100(dat$QZ2, xmin = 0, xmax = 18)
dat$QZ3 <- rescale100(dat$QZ3, xmin = 0, xmax = 20)
dat$QZ4 <- rescale100(dat$QZ4, xmin = 0, xmax = 20)

#rescaling test
Test1 <- rescale100(dat$EX1, xmin = 0, xmax = 80)
Test2 <- rescale100(dat$EX2, xmin = 0, xmax = 90)
dat <- data.frame(dat, Test1, Test2)

#creating homework
library(dplyr)
Homework <- rep(0, 334)
for(i in 1:334){
  v <- as.numeric(dat[i, 1:9])
  Homework[i] <- score_homework(v, drop = TRUE)
}
dat <- data.frame(dat, Homework)

#creating quiz
Quiz <- rep(0, 334)
for(i in 1:334){
  v <- as.numeric(dat[i, 11:14])
  Quiz[i] <- score_quiz(v, drop = TRUE)
}
dat <- data.frame(dat, Quiz)

# creating overall
Lab <- rep(0, 334)
for(i in 1:334){
  v <- dat[i, "ATT"]
  Lab[i] <- score_lab(v)
}
dat <- data.frame(dat, Lab)

Overall <- rep(0, 334)
for(i in 1:334){
  Overall[i] <- 0.1 * dat[i, "Lab"] + 0.3 * dat[i, "Homework"] + 0.15* dat[i, "Quiz"] +
    0.2 * dat[i, "Test1"] + 0.25 * dat[i, "Test2"]
}
dat <- data.frame(dat, Overall)

# creating grade
Grade <- rep("A", 334)
for(i in 1:334){
  if(dat$Overall[i] >= 0 & dat$Overall[i] < 50){
    Grade[i] <- "F"
  }else if(dat$Overall[i] >= 50 & dat$Overall[i] < 60){
    Grade[i] <- "D"
  }else if(dat$Overall[i] >= 60 & dat$Overall[i] < 70){
    Grade[i] <- "C-"
  }else if(dat$Overall[i] >= 70 & dat$Overall[i] < 77.5){
    Grade[i] <- "C"
  }else if(dat$Overall[i] >= 77.5 & dat$Overall[i] < 79.5){
    Grade[i] <- "C+"
  }else if(dat$Overall[i] >= 79.5 & dat$Overall[i] < 82){
    Grade[i] <- "B-"
  }else if(dat$Overall[i] >= 82 & dat$Overall[i] < 86){
    Grade[i] <- "B"
  }else if(dat$Overall[i] >= 86 & dat$Overall[i] < 88){
    Grade[i] <- "B+"
  }else if(dat$Overall[i] >= 88 & dat$Overall[i] < 90){
    Grade[i] <- "A-"
  }else if(dat$Overall[i] >= 90 & dat$Overall[i] < 95){
    Grade[i] <- "A"
  }else if(dat$Overall[i] >= 95 & dat$Overall[i] <= 100){
    Grade[i] <- "A+"
  }
}
dat <- data.frame(dat, Grade)

# output the stats of the scores
sink('../output/Lab-stats.txt') 
summary_stats(Lab)
print_stats(summary_stats(Lab))
sink()

sink('../output/Homework-stats.txt') 
summary_stats(Homework)
print_stats(summary_stats(Homework))
sink()

sink('../output/Quiz-stats.txt') 
summary_stats(Quiz)
print_stats(summary_stats(Quiz))
sink()

sink('../output/Test1-stats.txt') 
summary_stats(Test1)
print_stats(summary_stats(Test1))
sink()

sink('../output/Test2-stats.txt') 
summary_stats(Test2)
print_stats(summary_stats(Test2))
sink()

sink('../output/Overall-stats.txt') 
summary_stats(Overall)
print_stats(summary_stats(Overall))
sink()

# sink the clean data
sink('../output/summary-cleanscores.txt') 
str(dat)
sink()

# export the clean data frame of scores to a CSV ???le 
write.csv(dat, file = "../data/cleandata/cleanscores.csv")






