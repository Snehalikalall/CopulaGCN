library('copula')
library(foreach)
library(doParallel)

data=read.csv("datasemifea.csv", header=FALSE)


#Feature Selecture
cl <- makeCluster(7)   # Number of Cores in Machine
registerDoParallel(cl)
nf=100   # Number of Features to be selected
set.seed(1000)
datas2<-t(data)    # Gene or Feature should be in coloumn
n=nrow(datas2)
count=ncol(datas2)
start.time <- Sys.time()
fea<- matrix(0, nrow=1,ncol =nf)
fea[1,1]=1
for (m in 2:nf)
{
  feas<-fea[1,(m-1)]
  parl<-foreach(j=1:count, .combine=c,.packages='copula') %dopar%
  {
    u<-pobs(cbind(datas2[,feas],datas2[,j]))
    fit.tau<-fitCopula(normalCopula(dim=2, dispstr="ex"), u, method="itau")
    res=(confint(fit.tau)[,2])
  }
  result<-as.matrix(parl) 
  result[fea]<-1
  feamid=which.min(result)
  fea[1,m]<-feamid
}

stopCluster(cl)
end.time <- Sys.time()  
time.taken <- end.time - start.time
time.taken  
registerDoSEQ()
#Selected Feature set
Feaout=fea