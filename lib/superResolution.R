########################
### Super-resolution ###
########################

### Author: Chengliang Tang
### Project 3

superResolution <- function(LR_dir, HR_dir, modelList){
  
  ### Construct high-resolution images from low-resolution images with trained predictor
  
  ### Input: a path for low-resolution images + a path for high-resolution images 
  ###        + a list for predictors
  
  ### load libraries
  library("EBImage")
  n_files <- 1# length(list.files(LR_dir))
  
  ### read LR/HR image pairs
  for(i in 1:n_files){
    imgLR <- readImage(paste0(LR_dir,  "img", "_", sprintf("%04d", i), ".jpg"))
    pathHR <- paste0(HR_dir,  "img", "_", sprintf("%04d", i), ".jpg")
    featMat <- array(NA, c(dim(imgLR)[1] * dim(imgLR)[2], 8, 3))
    
    imgLR <- as.array(imgLR)
    select=dim(imgLR)[1] * dim(imgLR)[2]
    n_points=length(select)
    select_row=(select-1)%%dim(imgLR)[1]+1
    select_col=(select-1)%/%dim(imgLR)[1]+1
    
    ### step 1. for each pixel and each channel in imgLR:
    ###           save (the neighbor 8 pixels - central pixel) in featMat
    ###           tips: padding zeros for boundary points
    for (j in 1:3){
      pad=cbind(0,imgLR[,,j],0)
      pad=rbind(0,pad,0)
      center=pad[cbind(select_row+1,select_col+1)]
      featMat[(i-1)*n_points+1:n_points,1,j]=pad[cbind(select_row,select_col)]-center
      featMat[(i-1)*n_points+1:n_points,2,j]=pad[cbind(select_row,select_col+1)]-center
      featMat[(i-1)*n_points+1:n_points,3,j]=pad[cbind(select_row,select_col+2)]-center
      featMat[(i-1)*n_points+1:n_points,4,j]=pad[cbind(select_row+1,select_col+2)]-center
      featMat[(i-1)*n_points+1:n_points,5,j]=pad[cbind(select_row+2,select_col+2)]-center
      featMat[(i-1)*n_points+1:n_points,6,j]=pad[cbind(select_row+2,select_col+1)]-center
      featMat[(i-1)*n_points+1:n_points,7,j]=pad[cbind(select_row+2,select_col)]-center
      featMat[(i-1)*n_points+1:n_points,8,j]=pad[cbind(select_row+1,select_col)]-center
    }
    
    ### step 2. apply the modelList over featMat
    predMat <- test(modelList, featMat)
    ### step 3. recover high-resolution from predMat and save in HR_dir
    HRimg<-Image(predMat,colormode = Color)
    save(HRimg, file=pathHR)
    
    
  }
}