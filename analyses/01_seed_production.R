#Library
library (ggplot2)
library(MASS)
library(car)
library(plyr)

#Carga datos
data<-as.data.frame(read.csv("./data/ConeCount.csv",sep=";"))

str(data)

# Probability distribution test

# normal
qqp(data$GreenCones,"norm")

# lognomral
qqp(data$GreenCones,"lnorm")

# negbinom
nbinom <- fitdistr(data$GreenCones, "negative binomial")
qqp(data$GreenCones, "nbinom", size = nbinom$estimate[[1]], mu = nbinom$estimate[[2]])

# poisson
poisson<-fitdistr(data$GreenCones, "Poisson")
qqp(data$GreenCones,"pois",lambda=poisson$estimate)


qqp(log(data$GreenCones+1),"norm")

# glm nb

glmAge <- glm.nb(data=data, GreenCones~log(Age))
anova(glmAge,test="Chisq")
summary(glmAge)

#Plot
theme_set(theme_bw())

cones_age<-ggplot(data, aes(x = Age, y =GreenCones)) + 
  geom_point() + 
  geom_line(aes(y=predict(glmAge,type="response")))+
  geom_vline(xintercept = c(7,15,24,45),linetype="dotted")+
  labs(x="Age", y="Green Cones")

cones_age
ggsave("./output/fig2.png")

# year-by-year simulation

pred<-data.frame(Age=7:90) 
pred$GreenCones<-predict(glmAge,newdata = pred,type="response")

pred$AgeCat<- cut(pred$Age,breaks = c(6,14,23,44,90),labels=c("adult1","adult2","adulto","adult4"))

predCatSeeds<-ddply(pred,.(AgeCat),summarise,
                       mean=mean(GreenCones*103.9),
                       sd=sd(GreenCones*103.9),
                       min=min(GreenCones*103.9),
                       max=max(GreenCones*103.9))

write.csv(predCatSeeds,"./output/Table1.csv")

