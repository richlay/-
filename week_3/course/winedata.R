setwd("C:/Users/user/Documents/GitHub/Rlanguage/week_3/course")
wine.data = read.csv("wine100.csv")
country = wine.data[wine.data$country=="Italy",]
plot(x=country$X,
     y=country$price,
     main="Italy",
     xlab="no.",
     ylab="price")
