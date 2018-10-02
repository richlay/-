setwd("C:/Users/user/Documents/GitHub/Rlanguage/week_3/course")
wine.data = read.csv("Book1.csv")
country = wine.data[wine.data$country=="Italy",]
require(datasets)
plot(x=country$province,
     y=country$price,
     main="country to points",
     xlab="Italy",
     ylab="price")
