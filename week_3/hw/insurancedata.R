setwd("C:/Users/user/Documents/GitHub/Rlanguage/week_3/hw")
insurance.data = read.csv("insurance.csv")
male = insurance.data[insurance.data$sex=="male",]
require(datasets)
plot(x=male$age,
     y=male$bmi,
     main="age to bmi for male",
     xlab="Age",
     ylab="BMI")
