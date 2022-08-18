
# library
library(popdemo)

# load custom functions for data loading and matrix construction

source("./R/fun_matrix_load.R")

# parameter loading and matrix construction

path<-"./data/MeanParam.csv" 
name<-"average"

matrix_load(name=name,path=path) 

# mat.m = deterministic matrix
# mat.s = stochastic matrix

# select stochastic matrix

list.mat <- mat.s.average

#Check primitivity, irreducibility, ergodicity
#output indicates how many matrices do not comply

which(sapply(X=list.mat, FUN=function(x){isPrimitive(A=x)})=="FALSE")
which(sapply(X=list.mat, FUN=function(x){isIrreducible(A=x)})=="FALSE")
which(sapply(X=list.mat, FUN=function(x){isErgodic(A=x)})=="FALSE")

# PROJECTION

# create the initial vector with only one adult

ini.vec<-c(0,0,0,0,0,0,0,0,0,0,0,1) 

#50 year projection

proj <- project(list.mat, ini.vec, time = 100) 

# Fig4

plot(proj,log="y",xlab= "Time (years)", ylab="Population size (individuals)")+for (i in 1:10){
  proji <- project(list.mat, ini.vec, time = 100) 
  lines(proji,col=i)
}

#Average growth rate 
stoch(list.mat, c("lambda", "var"), vector = ini.vec,
      iterations = 2000, discard = 100)

# stage projection

windows()
par(mfrow=c(3,1))

# seeds

proj <- project(list.mat, ini.vec, time = 100) 

plot(vec(proj)[,1],type="l",main="Seeds",col="grey",log="y", ylab="Nr. of Seeds") 

for (i in 1:10){
  proji <- project(list.mat, ini.vec, time = 100) 
  lines(vec(proji)[,1],col="grey",log="y")
}

# juveniles

proj <- project(list.mat, ini.vec, time = 100) 
plot(rowSums(vec(proj)[,2:8]),type="l",main="Juveniles",col="red",log="y", ylab="Nr. of Juveniles") 

for (i in 1:10){
  proji <- project(list.mat, ini.vec, time = 100) 
  lines(rowSums(vec(proji)[,2:8]),col="red",log="y")
}

# adults

proj <- project(list.mat, ini.vec, time = 100) 
plot(rowSums(vec(proj)[,9:12]),type="l",main="Adults",log="y", ylab="Nr. of Adults")

for (i in 1:10){
  proji <- project(list.mat, ini.vec, time = 100) 
  lines(rowSums(vec(proji)[,9:12]),log="y")
}


