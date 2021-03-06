# Xavier X. Sala-I-Martin: I Just Ran Two Million Regression (AER, 1997)
# Growth Convergence of 72 countries with 41 variables
# Ridge Regression
# OLS: min SSE(b) = sum((Y-b0-Xb)^2)
# Ridge: min SSE(b) + lambda*||b||
# setwd("C:/Course16/WISE2016/R")
growth <- read.csv("C:/Course16/WISE2016/data/FLS-data.csv")
summary(growth)

# working with data matrices (not standardized)
X <- as.matrix(growth[,-1])
Y <- as.matrix(growth[,1])

# Ridge Regression
library(MASS)
m<-lm.ridge(y ~ .,data=growth,lambda=seq(0,0.1,0.0001))
select(m)
s<-m$lambda[which.min(m$GCV)]
r1<-lm.ridge(y ~ .,data=growth,lambda=s)
r1

library(lars)
# for linear regression (not for logit)
# can do stepwise and cv 
# can do ridge and cv
# can do lasso and cv

# forward stepwise regression
m0 <- lars(X,Y,type="step",trace=T,normalize=F)
summary(m0)
plot(m0)
m0.coef<-coef(m0,s=which.min(m0$Cp))
m0.coef[m0.coef!=0]
# cross-validation to pick lambda step
# set.seed(2016) for 3-fold CV (note: total obs. is 72 only)
m0cv <- cv.lars(X,Y,K=3,type="step",normalize=F)
best<-which.min(m0cv$cv)
best
m0cv$index[best]
# m0cv.coef<-coef(m0,s=m0cv$index[which.min(m0cv$cv)])
m0cv.coef<-coef(m0,s=which.min(m0cv$cv))
m0cv.coef[m0cv.coef!=0]

# ridge regression
m1 <- lars(X,Y,type="lar",trace=T,normalize=F)
summary(m1)
plot(m1)
m1.coef<-coef(m1,s=which.min(m1$Cp))
m1.coef[m1.coef!=0]
# cross-validation to pick lambda step
m1cv <- cv.lars(X,Y,K=3,type="lar",normalize=F)
best<-which.min(m1cv$cv)
best
m1cv$index[best]
# m1cv.coef<-coef(m1,s=m1cv$index[which.min(m1cv$cv)])
m1cv.coef<-coef(m1,s=which.min(m1cv$cv))
m1cv.coef[m1cv.coef!=0]

# lasso
m2 <- lars(X,Y,type="lasso",trace=T,normalize=F)
summary(m2)
plot(m2)
m2.coef<-coef(m2,s=which.min(m2$Cp))
m2.coef[m2.coef!=0]
# cross-validation to pick lambda step
m2cv <- cv.lars(X,Y,type="lasso",trace=T,normalize=F)
best<-which.min(m2cv$cv)
best
m2cv$index[best]

m2cv.coef<-coef(m2,s=m2cv$index[which.min(m2cv$cv)])
m2cv.coef<-coef(m2,s=which.min(m2cv$cv))
m2cv.coef[m2cv.coef!=0]

# compare with stepwise regression results
# variables selected may be different:
# Step: 
# Ridge:
# LASSO: 


