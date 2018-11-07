######################################################
### Calculate mse and psnr ###
######################################################

msepsnr <- function(){
  library("EBImage")
  
  MSE<-NULL
  PSNR<-NULL
  
  n_files=1500
  for(i in 1:n_files){
    
    train_dir <- "../data/train_set/HR/"
    test_dir <- "../data/test_set/HR/"
    
    imgP <- as.array(readImage(paste0(test_dir,  "img_", sprintf("%04d", i), ".jpg")))
    imgH <- as.array(readImage(paste0(train_dir,  "img_", sprintf("%04d", i), ".jpg")))
    
    mse <- mean(abs(imgP-imgH)^2)
    psnr <- 10*log10(1/mse)
    
    MSE <- c(MSE, mse)
    PSNR <- c(PSNR, psnr)
  }
  mp <- c(mean(MSE),mean(PSNR))
  return(mp)
}

