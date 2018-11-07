cv <- function(train.D){
  #Find the best training paramter for XGboost. The controlled parameters are "depth" and "eta"
  library(xgboost)
  depth.list <- c(4,5,6,7,8,9)
  eta.list <- c(0.02,0.04,0.06,0.08,0.1)
  
  error<-matrix(NA,nrow = length(depth.list),ncol = length(eta.list))
  iteration<-matrix(NA,nrow = length(depth.list),ncol = length(eta.list))
  train.sd <- matrix(NA,nrow = length(depth.list),ncol = length(eta.list))
  test.sd<-matrix(NA,nrow = length(depth.list),ncol = length(eta.list))
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
    u <- paste(getwd(),"/Fall2018-Proj3-Sec2-grp4/output/error",i,"_xg.RData",sep="")
    save(error,u)
  }
  best.index<-which(error == min(error), arr.ind = TRUE)
  depth.choose<-depth.list[best.index[1,1]]
  eta.choose<-eta.list[best.index[1,2]]
  iteration.choose<-iteration[best.index[1,1],best.index[1,2]]
  u1 <- paste(getwd(),"/Fall2018/Proj3-Sec2-grp4/output/error_xg.RData",sep="")
  save(error, file=u1)
  return(list(depth=depth.choose,eta=eta.choose,iteration=iteration.choose))
}

cv_real <- function(feature_train, label_train){
  library(xgboost)
  #load(paste(getwd(),"/Fall2018-Proj3-Sec2-grp4/output/feature_train.RData",sep=""))
  feature <- feature_train
  label <- label_train
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
  par=list(par1,par2,par3,par4,par5,par6,par7,par8,par9,par10,par11,par12)
  return (list(parlist=par,matrix=c))
}