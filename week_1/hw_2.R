# 猜數字遊戲
# 基本功能
# 1. 請寫一個由"電腦隨機產生"不同數字的四位數(1A2B遊戲)
# 2. 玩家可"重覆"猜電腦所產生的數字，並提示猜測的結果(EX:1A2B)
# 3. 一旦猜對，系統可自動計算玩家猜測的次數

# some constants
endofgame <- F
guess.num <- 1
playround.count <- 0
# generate random four nums
random.four <- sample(0:9, 4, replace = T, prob = NULL)

while (endofgame==F) {
  a <- 0
  b <- 0
  already.a <- c(F, F, F, F)
  # reset checking number, which is for detecting 'b'
  checking.num <- random.four
  # player input four digit
  guess <- readline(prompt = "Please enter four numbers. ")
  
  # get individual nums
  for (i in 1:4) {
    guess.num[i] <- as.integer(substr(guess, i, i))
    # find a
    if (guess.num[i]==random.four[i]){
      a <- a+1
      already.a[i] <- T
      # make checking number unavailable for 'b' detect, which i use '10' to do so
      checking.num[i] <- 10
    }
  }
  
  # find b
  for (j in 1:4) {
    # see if the number is 'a' correct
    if (already.a[j]==F){ 
      for (k in 1:4) {
        if (guess.num[j]==checking.num[k]){
          b <- b+1
          # make the number unavailable for another b
          checking.num[k] <- 10
          break
        }
      }
    }
  }
  
  if (a==4){
    print(paste("Correct! You have tried ",playround.count," times."))
    endofgame <- T
  }else{
    print(paste0(a,"A",b,"B"))
    playround.count <- playround.count+1
  }
  
}
# 額外功能：每次玩家輸入完四個數字後，檢查玩家的輸入是否正確(錯誤檢查)

