setwd("C:/Users/user/Documents/GitHub/Rlanguage/week_3/hw")
insurance.data = read.csv("insurance.csv")

library(ggplot2)
my.plot = ggplot(insurance.data, aes(age, bmi, colour=sex)) + geom_point()
my.plot

