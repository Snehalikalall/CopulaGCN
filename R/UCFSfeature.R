UCFSfeature <- function(lspcadata,data,p,nf){
library(foreach)
library(doParallel)
library('prodlim')
 library('copula')
 
 #data=a matrix format, Cells sholud be in rwo, Genes should be in coloumn in data
 #nf=Number of feature to be selected.
#p=Number of cores. 
 
datals=as.matrix(lspcadata)
cl <- makeCluster(p)
registerDoParallel(cl)
nf=nf
set.seed(1000)
datas2<-t(datals)
n=nrow(datas2)
count=ncol(datas2)
start.time <- Sys.time()
# Feature by CBFS parallel 
fea<- matrix(0, nrow=1,ncol =nf)
fea[1,1]=1
theta=-0.5
fc=claytonCopula(theta,dim=2)
for (m in 2:nf)
{
  feas<-fea[1,(m-1)]
  parl<-foreach(j=1:count, .combine=c,.packages='copula') %dopar%
    {
      u<-pobs(cbind(datas2[,feas],datas2[,j]))
      a=pCopula(u,fc)
      res=mean(a)
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


#take main data to match feature number with lspca data feature, cells in row, genes in coloumn
dataorg=as.matrix(t(data))
datasemfea<-as.data.frame(lspcadata)
index<-row.match(datasemfea,dataorg)
feafinal<-as.matrix(index[as.matrix(fea)])
  
UCFSdata=data[,feafinal] # Feature reduced Data with Copula based feature selection
UCFSresult<- list("Feadata" = UCFSdata, "Features" = feafinal)
return(UCFSresult) 
}
