
test.xg <- function(test_LR_dir,test_HR_dir,models_final){
load(url1)
library(EBImage)
n_files <- length(list.files(test_LR_dir))
c_test <- list()
pred <- list()
pred_final <- list()
time_s <- rep(NA,n_files)
for(i in 1:n_files){
  f_time[i]<-system.time(imgLR <- readImage(paste0(test_LR_dir,  "img", "_", sprintf("%04d", i), ".jpg")))
  n<-dim(imgLR)[1]
  m<-dim(imgLR)[2]
  featMat <- array(NA, c(n*m, 8, 3))
  predMat <- array(NA,c(n*m,4,3))
  imgLR <- as.array(imgLR)
  select=c(1:(n*m))
  #n_points=length(select)
  select_row=(select-1)%%n +1
  select_col=(select-1)%/%n +1
  
  ### step 1. for each pixel and each channel in imgLR:
  ###           save (the neighbor 8 pixels - central pixel) in featMat
  ###           tips: padding zeros for boundary points
 time_s[i]<- (system.time(for (j in 1:3){
    pad=cbind(0,imgLR[,,j],0)
    pad=rbind(0,pad,0)
    center=pad[cbind(select_row+1,select_col+1)]
    featMat[,1,j]=pad[cbind(select_row,select_col)]-center
    featMat[,2,j]=pad[cbind(select_row,select_col+1)]-center
    featMat[,3,j]=pad[cbind(select_row,select_col+2)]-center
    featMat[,4,j]=pad[cbind(select_row+1,select_col+2)]-center
    featMat[,5,j]=pad[cbind(select_row+2,select_col+2)]-center
    featMat[,6,j]=pad[cbind(select_row+2,select_col+1)]-center
    featMat[,7,j]=pad[cbind(select_row+2,select_col)]-center
    featMat[,8,j]=pad[cbind(select_row+1,select_col)]-center
    #featMat[,,j] = featMat[,,j]-center[,,j]
    M <- as.matrix(cbind(featMat[,1,j],featMat[,2,j],featMat[,3,j],featMat[,4,j],featMat[,5,j],featMat[,6,j],featMat[,7,j],featMat[,8,j]))
    #center2 = predMat
    predMat[,1,j] <- predict(models_final[[j]][[1]],M)+center
    predMat[,2,j] <- predict(models_final[[j]][[2]],M)+center
    predMat[,3,j] <- predict(models_final[[j]][[3]],M)+center
    predMat[,4,j] <- predict(models_final[[j]][[4]],M)+center
    #center2[,,j] <- imgLR[,,j]
    #predMat[,,j] <- predMat[,,j]+center[,,j]
  }))[1]
  pred[[i]] <- predMat
  pathHR <- paste0(test_HR_dir,  "img", "_", sprintf("%04d", i), ".png")
  p <- pred[[i]]
  index<-c(1:(m*n))
  index2<-1:m
  featImg<- array(NA, c(2*n, 2*m, 3))
 for (k in 1:3){
    
    vec_odd<-numeric(2*m*n)
    vec_odd[c(2*index-1)]<-as.vector(p[,1,k])
    vec_odd[2*index]<-as.vector(p[,2,k])
    vec_even<-numeric(2*m*n)
    vec_even[c(2*index-1)]<-as.vector(p[,3,k])
    vec_even[2*index]<-as.vector(p[,4,k])
    mat_odd<-matrix(vec_odd,nrow = 2*n,ncol = m)
    mat_even<-matrix(vec_even,nrow = 2*n,ncol = m)
    
    imgMAt<-matrix(NA,nrow = 2*n,ncol = 2*m)
    
    imgMAt[,c(2*index2-1)]<-mat_odd
    imgMAt[,2*index2]<-mat_even
    
    featImg[,,k]<-imgMAt
  }
  pred_final[[i]] <- featImg
  HRimg<-Image(featImg,colormode = Color)
  writeImage(HRimg, file=pathHR,type="png")
}
url2 <- paste(getwd(),"/Fall2018-Proj3-Sec2-grp4/output/pred_matrix.RData",sep="")
save(pred_final, file=url2)
return(time_s)
}
