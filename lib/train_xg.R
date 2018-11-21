
find_parameters <-function(parameter){
  list ( objective        = "reg:linear",
         #booser              = "gbtree",
         eta                 = parameter$eta,
         max_depth           = parameter$depth,
         subsample           = 0.5,
         gamma = 0
  )
}



train_x <- function(c,par){
library(xgboost)
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
return(list(train_time=train_time,models_final=models_final))
}