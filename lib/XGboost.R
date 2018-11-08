load(paste(getwd(),"/Fall2018-Proj3-Sec2-grp4/output/feature_train.RData",sep=""))
feature <- dat_train$feature
label <- dat_train$label
feature1 <- data.frame(feature[,,1])
label1 <- data.frame(label[,,1])
feature2 <- data.frame(feature[,,2])
label2 <- data.frame(label[,,2])
feature3 <- data.frame(feature[,,3])
label3 <- data.frame(label[,,3])
m1 <- matrix(NA,dim(feature)[1],12)
m2 <- matrix(NA,dim(feature)[1],12)
m3 <- matrix(NA,dim(feature)[1],12)
m1 <- cbind(feature1,label1)
m2 <- cbind(feature2,label2)
m3 <- cbind(feature3,label3)


#Find the best training paramter for XGboost. The controlled parameters are "depth" and "eta"
library(xgboost)
depth.list <- c(4,5,6,7,8,9,10,11)
eta.list <- c(0.02,0.04,0.06,0.08,0.1)

error<-matrix(NA,nrow = length(depth.list),ncol = length(eta.list))
iteration<-matrix(NA,nrow = length(depth.list),ncol = length(eta.list))
train.sd <- matrix(NA,nrow = length(depth.list),ncol = length(eta.list))
test.sd<-matrix(NA,nrow = length(depth.list),ncol = length(eta.list))
cv <- function(train.D){
for(i in 1:length(depth.list)){
  for(j in 1:length(eta.list)){
    parameters <- list ( objective        = "reg:linear",
                         #booser              = "gbtree",
                         eta                 = eta.list[j],
                         max_depth           = depth.list[i],
                         subsample           = 0.5,
                         gamma = 0
    )
    crossvalid <- xgb.cv( params             = parameters,
                          data                = train.D,
                          nrounds             = 500,
                          verbose             = 1,
                          #watchlist           = ,
                          maximize            = FALSE,
                          nfold               = 5,
                          early_stopping_rounds    = 10,
                          print_every_n       = 1)
    iteration[i,j]<-crossvalid$best_iteration
    error[i,j]<- as.numeric(crossvalid$evaluation_log[crossvalid$best_iteration,4])
    train.sd[i,j]<-as.numeric(crossvalid$evaluation_log[crossvalid$best_iteration,3])
    test.sd[i,j]<-as.numeric(crossvalid$evaluation_log[crossvalid$best_iteration,5])
  }
}
  best.index<-which(error == min(error), arr.ind = TRUE)
  depth.choose<-depth.list[best.index[1,1]]
  eta.choose<-eta.list[best.index[1,2]]
  iteration.choose<-iteration[best.index[1,1],best.index[1,2]]
  return(list(depth=depth.choose,eta=eta.choose,iteration=iteration.choose))
}
c1 <- m1[,1:9]
colnames(c1) <- c(1:8,"label")
c2 <- m1[,c(1:8,10)]
colnames(c2) <- c(1:8,"label")
c3 <- m1[,c(1:8,11)]
colnames(c3) <- c(1:8,"label")
c4 <- m1[,c(1:8,12)]
colnames(c4) <- c(1:8,"label")
c5 <- m2[,1:9]
colnames(c5) <- c(1:8,"label")
c6 <- m2[,c(1:8,10)]
colnames(c6) <- c(1:8,"label")
c7 <- m2[,c(1:8,11)]
colnames(c7) <- c(1:8,"label")
c8 <- m2[,c(1:8,12)]
colnames(c8) <- c(1:8,"label")
c9 <- m3[,1:9]
colnames(c9) <- c(1:8,"label")
c10 <- m3[,c(1:8,10)]
colnames(c10) <- c(1:8,"label")
c11 <- m3[,c(1:8,11)]
colnames(c11) <- c(1:8,"label")
c12 <- m3[,c(1:8,12)]
colnames(c12) <- c(1:8,"label")


c1_1=(xgb.DMatrix(data=as.matrix(c1[,1:8]),label=c1[,"label"],missing=NaN))
c2_1=(xgb.DMatrix(data=as.matrix(c2[,1:8]),label=c2[,"label"],missing=NaN))
c3_1=(xgb.DMatrix(data=as.matrix(c3[,1:8]),label=c3[,"label"],missing=NaN))
c4_1=(xgb.DMatrix(data=as.matrix(c4[,1:8]),label=c4[,"label"],missing=NaN))
c5_1=(xgb.DMatrix(data=as.matrix(c5[,1:8]),label=c5[,"label"],missing=NaN))
c6_1=(xgb.DMatrix(data=as.matrix(c6[,1:8]),label=c6[,"label"],missing=NaN))
c7_1=(xgb.DMatrix(data=as.matrix(c7[,1:8]),label=c7[,"label"],missing=NaN))
c8_1=(xgb.DMatrix(data=as.matrix(c8[,1:8]),label=c8[,"label"],missing=NaN))
c9_1=(xgb.DMatrix(data=as.matrix(c9[,1:8]),label=c9[,"label"],missing=NaN))
c10_1=(xgb.DMatrix(data=as.matrix(c10[,1:8]),label=c10[,"label"],missing=NaN))
c11_1=(xgb.DMatrix(data=as.matrix(c11[,1:8]),label=c11[,"label"],missing=NaN))
c12_1=(xgb.DMatrix(data=as.matrix(c12[,1:8]),label=c12[,"label"],missing=NaN))

find_parameters <-function(parameter){
  list ( objective        = "reg:linear",
                     #booser              = "gbtree",
                     eta                 = parameter$eta,
                     max_depth           = parameter$depth,
                     subsample           = 0.5,
                     gamma = 0
)
}
par1 <- cv(c1_1)
par2 <- cv(c2_1)
par3 <- cv(c3_1)
par4 <- cv(c4_1)
par5 <- cv(c5_1)
par6 <- cv(c6_1)
par7 <- cv(c7_1)
par8 <- cv(c8_1)
par9 <- cv(c9_1)
par10 <- cv(c10_1)
par11 <- cv(c11_1)
par12 <- cv(c12_1)
par <- list()
c <- list()
c <- list(c1_1,c2_1,c3_1,c4_1,c5_1,c6_1,c7_1,c8_1,c9_1,c10_1,c11_1,c12_1)
par <- list(par1,par2,par3,par4,par5,par6,par7,par8,par9,par10,par11,par12)
models <- list()
models_1 <- list()
models_2 <- list ()
models_3 <- list()
train_time <- rep(NA,12)
for(i in 1:12){
  train_time[i] <- (system.time(models[[i]] <- xgb.train( params = find_parameters(par[[i]]),
                           data                = c[[i]],
                           #nrounds             = 130, 
                           nrounds             = par[[i]]$iteration, 
                           verbose             = 1,
                           #watchlist           = watchlist,
                           maximize            = FALSE)))[1]
}
models_1 <- list(models[[1]],models[[2]],models[[3]],models[[4]])
models_2 <- list(models[[5]],models[[6]],models[[7]],models[[8]])
models_3 <- list(models[[9]],models[[10]],models[[11]],models[[12]])
models_final <- list(models_1,models_2,models_3)
url1 <- paste(getwd(),"/Fall2018-Proj3-Sec2-grp4/output/xgboost_models.RData",sep="")
save(models_final,file=url1)

#Super-resolution
#load(url1)
library(EBImage)
LR_dir <- paste(getwd(),"/Fall2018-Proj3-Sec2-grp4/data/test_set/LR/",sep="")
HR_dir <- paste(getwd(),"/Fall2018-Proj3-Sec2-grp4/data/test_set/HR/",sep="")
n_files <- length(list.files(LR_dir))
c_test <- list()
pred <- list()
pred_final <- list()
  time <- (system.time(for(i in 1:n_files){
  imgLR <- readImage(paste0(LR_dir,  "img", "_", sprintf("%04d", i), ".jpg"))
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
    for (j in 1:3){
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
  }
  pred[[i]] <- predMat
  pathHR <- paste0(HR_dir,  "img", "_", sprintf("%04d", i), ".png")
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
}))[[1]]
url2 <- paste(getwd(),"/Fall2018-Proj3-Sec2-grp4/output/pred_matrix.RData",sep="")
save(pred_final, file=url2)






