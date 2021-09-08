copulacellmatrix <- function(lspcadata,p){
library(foreach)
library(doParallel)
library('copula')
 
#data=a matrix format, Cells should be in colomn, Genes should be in row in data
#p=Number of cores. 
 
datals=as.matrix(lspcadata)
cl <- makeCluster(p)
registerDoParallel(cl)
set.seed(1000)
d<-datals
n=nrow(d)
count=ncol(d)
theta=-0.5
fc=claytonCopula(theta,dim=2)
start.time <- Sys.time()
# cell cell similarity matrix
mat=matrix(0,ncol(d),ncol(d))
for(i in 1:(ncol(d)-1)){
  parl<-foreach(j=1:ncol(d), .combine=c,.packages='copula') %dopar%
    {
      u<-pobs(cbind(d[,i],d[,j]))
      a=pCopula(u,fc)
      res=mean(a)
      
    }
  result<-as.matrix(parl)
  mat[i,]=result
}
stopCluster(cl)
end.time <- Sys.time()  
time.taken <- end.time - start.time
time.taken  
registerDoSEQ()

return(mat) 
}
