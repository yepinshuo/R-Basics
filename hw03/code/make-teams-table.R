# ===============================================================
# Title: HW03, Stat 133, Fall 2017
# Description: 
#       This is a lab work for stat 133, HW03.
#       The main task of the homework is to ranking NBA teams.
# Input(s):  nba2017-teams.csv
# Output(s):  nba2017-teams.csv
# Author: Pinshuo Ye
# Date: 10-11-2017
# ===============================================================

# download RData file into working directory
github <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/"
csv <- "data/nba2017-roster.csv"
download.file(url = paste0(github, csv), destfile = 'nba2017-roster.csv')

# download RData file into working directory
github <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/"
csv <- "data/nba2017-stats.csv"
download.file(url = paste0(github, csv), destfile = 'nba2017-stats.csv')


# Creating the data table and change the vector type
library(readr)
dat1 <- data.frame(
  read_csv(
    "C:\\Users\\pinshuo\\stat133\\stat133-hws-fall17\\hw03\\data\\nba2017-roster.csv",
    col_types = cols(
      player = col_character(),
      team = col_factor(c("ATL", "BOS", "BRK", "CHI", "CHO", "CLE", "DAL", 
                          "DEN", "DET", "GSW", "HOU", "IND", "LAC", "LAL",
                          "MEM", "MIA", "MIL", "MIN", "NOP", "NYK", "OKC",
                          "ORL", "PHI", "PHO", "POR", "SAC", "SAS", "TOR",
                          "UTA", "WAS"), ordered = FALSE), 
      experience = col_integer(),
      position = col_factor(c("C", "PF", "PG", "SG", "SF"), ordered = FALSE),
      salary = col_double()
    )
    ))

# Creating the data table and change the vector type
library(readr)
dat2 <- data.frame(
  read_csv(
    "C:\\Users\\pinshuo\\stat133\\stat133-hws-fall17\\hw03\\data\\nba2017-stats.csv",
    col_types = cols(
      player = col_character(),
      field_goals_perc = col_double(),
      points3_perc = col_double(),
      points2_perc = col_double(),
      points1_perc = col_double()
    )
  ))

# adding new variables to the data frame using mutate
library(dplyr)
missed_fg <- dat2$field_goals_atts - dat2$field_goals_made
missed_ft <- dat2$points1_atts - dat2$points1_made
points <- dat2$points3_made * 3 + dat2$points2_made * 2 + dat2$points1_made
rebounds = dat2$off_rebounds + dat2$def_rebounds
efficiency <- (points + rebounds + dat2$assists 
               + dat2$steals + dat2$blocks 
               - missed_fg - missed_ft - dat2$turnovers) / dat2$games_played
efficiency <- as.numeric(efficiency, nsmall = 2)


# Output the structure of the data efficiency
sink(file = 
       'C:/Users/pinshuo/stat133/stat133-hws-fall17/hw03/output/efficiency-summary.txt')
summary(efficiency)
sink()

# using mutate to combine the vectors and the data frame
dat2 <- dat2 %>%
  mutate(missed_fg, missed_ft, points, rebounds, efficiency)

# using merge to combine the two data frame
dat <- merge(dat1, dat2)

# Grouping by team and creating the summary
teams <- 
  dat %>%
  group_by(team) %>%
  summarise(
    experience = round(sum(experience), 2),
    salary = round(sum(salary/1000000), 2),
    points3 = sum(points3_made),
    points2 = sum(points2_made),
    free_throws = sum(points1_made),
    points = sum(points),
    off_rebounds = sum(off_rebounds),
    def_rebounds = sum(def_rebounds),
    assists = sum(assists),
    steals = sum(steals),
    blocks = sum(blocks),
    turnovers = sum(turnovers),
    fouls = sum(fouls),
    efficiency = sum(efficiency)
  )

summary(teams)

#use sink to output the new table
sink(file = "C:/Users/pinshuo/stat133/stat133-hws-fall17/hw03/data/teams-summary.txt")
summary(teams)
sink()

# create the csv file
write.csv(teams,
          file = 
            "C:/Users/pinshuo/stat133/stat133-hws-fall17/hw03/data/nba2017-teams.csv")

teams$team <- as.character(teams$team)
#creating the star plot and output the file
stars(teams[ , -1], labels = teams$team) 
pdf(file = "C:/Users/pinshuo/stat133/stat133-hws-fall17/hw03/images/teams_star_plot.pdf")
stars(teams[ , -1], labels = teams$team) 
dev.off()

# creating a ggplot to pdf
library(ggplot2)
ggplot(teams, aes(x = experience, y = salary)) +
  geom_point(col = "red") +
  geom_text(label = teams$team)+
  ggtitle("Scatterplot of Experience and Salary")

# Creating pdf version of the ggplot of experience and salary
pdf(file =
      "C:/Users/pinshuo/stat133/stat133-hws-fall17/hw03/images/experience_salary.pdf")
ggplot(teams, aes(x = experience, y = salary)) +
  geom_point(col = "red") +
  geom_text(label = teams$team)+
  ggtitle("Scatterplot of Experience and Salary")
dev.off()

teams <- arrange(teams, desc(salary))
# creating a horizontal bar plot
ggplot(data = teams, aes(x = reorder(team, salary), y = salary)) +
  geom_bar(stat = 'identity', fill = "dark grey") +
  geom_hline(yintercept = mean(teams$salary), lwd = 2, col = 2) +
  coord_flip()+
  labs(title = "NBA Teams ranked by Total Salary", 
       y = "Total Salary", x = "Team")

# creating a horizontal bar plot
ggplot(data = teams, aes(x = reorder(team, points), y = points)) +
  geom_bar(stat = 'identity', fill = "dark grey") +
  geom_hline(yintercept = mean(teams$points), lwd = 2, col = 2) +
  coord_flip()+
  labs(title = "NBA Teams ranked by Total Points", 
       y = "Total Points", x = "Team")

# creating a horizontal bar plot using the efficiency
ggplot(data = teams, aes(x = reorder(team, efficiency), y = efficiency)) +
  geom_bar(stat = 'identity', fill = "dark grey") +
  geom_hline(yintercept = mean(teams$efficiency), lwd = 2, col = 2) +
  coord_flip() +
  labs(title = "NBA Teams ranked by Total Efficiency", 
       y = "Total Efficiency", x = "Team")

# The ranking of the salary is somehow related to the efficiency.
# The Cavaliers is rank number one on both the ranking chart, so in these two
# comparasions, CLE is the first in the league. And it is obvious that the 
# total salary of the team is related to the quality of the players, as well as the 
# total team efficiency. And the relationship between the salary and the points is
# also relavant.

# Creating the new data frame of required vectors
teams1 <- select(teams, points3, points2, 
                 free_throws, off_rebounds, def_rebounds, 
                 assists, steals, blocks, turnovers, fouls)
pca <- prcomp(teams1, scale. = TRUE)
names(pca)

# showing the eigenvalue
eigs <- data.frame(
  eigenvalue = round(pca$sdev^2, 4),
  proportion = round(pca$sdev^2/sum(pca$sdev^2), 4),
  cumprop = round(cumsum(pca$sdev^2 / sum(pca$sdev^2)), 4)
)
eigs

# Creating the ggtext plot of the pc values of the teams
pcvalue <- data.frame(teams$team, pca$x)
ggplot(data = pcvalue, aes(x = -PC1, y = PC2)) +
  geom_text(aes(label = pcvalue$team)) +
  geom_hline(yintercept = 0, col = "dark grey")+
  geom_vline(xintercept = 0, col = "dark grey")+
  labs(x = "PC1")+
  ggtitle("PCA plot (PC1 and PC2)")

# Creating the index function
pcscale <- function(x) {
  100 * (x - min(x))/(max(x) - min(x))
}

# rewrite the scaled vector
teams <- mutate(teams, PC1 = -pcvalue$PC1, PC2 = pcvalue$PC2)
teams$PC1 <- pcscale(teams$PC1)
teams

# Creating the ggplot barplot of the pc values
ggplot(teams, aes(x = reorder(team, PC1), y = PC1)) +
  geom_bar(stat = "identity", fill = "dark grey") +
  coord_flip()+
  labs(x = "Team", y = "First PC(scaled from 0 to 100)", 
       title = "NBA teams ranked by scaled PC1")

# The scaled pc1 is to show the relative relationship between the teams.
# The largest is 100, and the smallest is 0, so the scaled barplot is more clear to
# show the rank. and according to this rank, GSW is no.1.

# Reflection:
# It is not the first time that I deal with this file stuctures, 
# and I feel good about it.
# The relative path is quite useful and organized, avoiding lot of mess.
# Writing R script is not as the rmd file, there is no extra informations,
# and no code chunks to seperate the codes, so it is very important to organized 
# and write good comments.
# The homework is not so hard, but there is some parameters that I am not familiar
# with, so it took me longer to find how to use the parameters.
# I asked several classmates about the parameters.
# Several hours to complete it.
# The homework is interesting, but finding the parameters is time consuming and not
# fun.















