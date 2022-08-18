
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

# select deterministic matrix

mat <- mat.m.average

#Check primitivity
isPrimitive(mat)


#Check irreducibility and ergodicity
isIrreducible(mat)

isErgodic(mat)

#1. Deterministic projections


# create the initial vector with only one adult
ini.vec <- c(0,
             0,0,0,0,0,0,0,
             0,0,0,1) 

ini.vec <- ini.vec/sum(ini.vec) #scales the vector to sum to 1

#100 year projection

proj <- project(mat, ini.vec, time = 100) 

plot(proj,log="y") # total projection

# projection for each stage
lines(vec(proj)[,1])
lines(vec(proj)[,2])
lines(vec(proj)[,3])
lines(vec(proj)[,4])
lines(vec(proj)[,5])
lines(vec(proj)[,6])
lines(vec(proj)[,7])
lines(vec(proj)[,8])
lines(vec(proj)[,9])
lines(vec(proj)[,10])
lines(vec(proj)[,11])
lines(vec(proj)[,12])

##Asymptotic dynamics##

# eigenvalues

eigs(mat,"all")

sta.str <- eigs(mat, "ss") # stable structure

plot(sta.str,type="b") # pot stable structure
plot(sta.str[-c(1)],type="b") # without seeds

ini.vec.sta <- sta.str # create an initial vector with stable structure
projw <- project(mat, ini.vec.sta, time = 100) 

plot(proj,log="y",xlab= "Time (years)", ylab="Population size (individuals)") 
lines(0:100, projw, lty = 2)


##Transient dynamics##

#Standardisations 

projTD<- project(mat, ini.vec, time = 100, 
                 standard.A = TRUE, standard.vec = TRUE) 
projW <- project(mat, ini.vec.sta, time = 100, 
                 standard.A = TRUE, standard.vec = TRUE) 
plot(projTD, log = "y")
lines(projW , lty = 2)

#Transient indices

( r1 <- reac(mat, ini.vec) )  

( i1 <- inertia(mat, ini.vec) ) 


points(c(1, 100), c(r1, i1), pch = 3, col = "red")


#Sensitivity analysis

matSens<-sens(mat)

#Elasticity analysis

matElas<-elas(mat)

