### hw_1_question


########################################################### Task 1

# 查看內建資料集: 鳶尾花(iris)資料集
?iris

# 使用dim(), 回傳iris的列數與欄數
dim(iris)

# 使用head() 回傳iris的前六列
head(iris)

# 使用tail() 回傳iris的後六列
tail(iris)

# 使用str() 
str(iris)

# 使用summary() 查看iris敘述性統計、類別型資料概述。
summary(iris)



########################################################### Task 2

# 使用for loop 印出九九乘法表
# Ex: (1x1=1 1x2=2...1x9=9 ~ 9x1=9 9x2=18... 9x9=81)
i <- 1
j <- 1
for(i in 1:9){
  for(j in 1:9){
    print(paste(i,"x",j,"=",i*j))
  }
  j <- 1
}



########################################################### Task 3

# 使用sample(), 產出10個介於10~100的整數，並存在變數 nums
x <- c(10:100)
nums <- sample(x, size=10, replace = FALSE, prob = NULL )

# 查看nums
nums

# 1.使用for loop 以及 if-else，印出大於50的偶數，並提示("偶數且大於50": 數字value)
# 2.特別規則：若數字為66，則提示("太66666666666了")並中止迴圈。
for (x in 1:10) {
  if(nums[x]==66){
    print("太66666666666了") 
    break
  }
  if(nums[x]%%2==0 & nums[x]>50){
    print(paste("偶數且大於50:", nums[x]))
  }
}

 

########################################################### Task 4

# 請寫一段程式碼，能判斷輸入之西元年分 year 是否為閏年
year <- readline(prompt = "輸之西元年分: ")
year <- as.numeric(year)
if (year%%4==0){
  if (year<100){
    print(paste(year," 是閏年"))
  } else if (year%%100!=0){
    print(paste(year," 是閏年"))
  } else if (year%%400==0){
    print(paste(year," 是閏年"))
  } else {
    print(paste(year," 不是閏年"))
  }
} else {
  print(paste(year," 不是閏年"))
}
  

