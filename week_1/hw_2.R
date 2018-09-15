# 猜數字遊戲
# 基本功能
# 1. 請寫一個由"電腦隨機產生"不同數字的四位數(1A2B遊戲)
# 2. 玩家可"重覆"猜電腦所產生的數字，並提示猜測的結果(EX:1A2B)
# 3. 一旦猜對，系統可自動計算玩家猜測的次數

# generate random four nums
random_four <- sample(0:9, 4, replace = T, prob = NULL)
# player input four digit
guess <- as.numeric(readline(prompt = "請輸入四個數字"))
# get individual nums
indi_num <- c(1:4)
a <- 0
b <- 0
countb <- c(1:10)
for (i in 1:4) {
  indi_num[i] <- as.numeric(substr(guess, i, i))
  if(indi_num[i]==random_four[i]){
    a <- a+1
  }else{
    countb[indi_num[i]] <- countb[indi_num[i]] + 1
  }
}
if(random_four==indi_num){
  print(paste("答對了，正確答案是", random_four))
}else{
  
}
# 額外功能：每次玩家輸入完四個數字後，檢查玩家的輸入是否正確(錯誤檢查)
