# TOTAL WEEKLY SALES OF IMPORT AND DOMESTIC NON VQA RED & WHITE TABLE WINE 
# WITHIN MUNICIPALITY OF VANCOUVER IN UNITS AND LITRES
# FROM WEEK ENDING APRIL 4, 2009 TO WEEK ENDING MAY 28, 2011
# Fast Read from CSV file: read_csv
# Using ggplot() of ggplot2 package for data visualization
# install.packages("readr")
# install.packages("ggplot2")
library(readr) 
# wine<-read_csv("http://web.pdx.edu/~crkl/WISE2016/data/Vancouver_Non_VQA_Sls_Apr1toMay31.csv",na="NA")
wine<-read_csv("C:/Course16/WISE2016/data/Vancouver_Non_VQA_Sls_Apr1toMay31.csv",na="NA")
dim(wine)
names(wine)
summary(wine)

# alc<-wine$`Alcohol Percent`
# sweet<-wine$`Product Sweetness Code`
# age<-wine$`Julian Week No`
# loc<-factor(wine$`Bottled Location Code`)
# import<-factor(wine$`Domestic/Import Indicator`)

where<-wine$`Store Category Sub Name`    # import from ...
where<-ifelse(substr(where,1,6)=="FRANCE","FRANCE",where)   # combine all france wines
where<-ifelse(substr(where,1,7)=="GERMANY","GERMANY",where) # combine all germany wines
big5<-c("AUSTRALIA","FRANCE","ITALY","UNITED STATES","OTHERS")
where5<-ifelse(!is.element(where,big5),"OTHERS",where)
wine$where<-factor(where5,levels=big5)
wine$what<-factor(wine$`Store Category Minor Name`)   # Red or White
wine$quantity<-wine$`Total Weekly Selling Unit`

# price analysis
wine$price<-wine$`Current Display Price`
wine$price_level<-cut(wine$price,breaks=c(-Inf,50,100,1000,Inf),labels=c("Low","Medium","High","Expensive"))

t1<-with(wine,table(where,price_level))
t1
barplot(t1)

t2<-with(wine,table(what,price_level))
t2
barplot(t2)

boxplot(price~price_level,data=wine)
with(wine,hist(price))

library(ggplot2)

ggplot(data=wine,aes(x=price_level,fill=where))+geom_bar()
ggplot(data=wine,aes(x=price_level,fill=what))+geom_bar(position="dodge")
ggplot(data=wine,aes(x=price_level,y=price))+geom_boxplot()+theme_classic()

varsel<-c("what","where","quantity","price","price_level")
wine100<-subset(wine,price<100 & quantity>0,varsel) # not including returned 

# histogram
ggplot(data=wine100,aes(x=price))+geom_histogram(fill="blue")
h1<-ggplot(data=wine100,aes(x=price,fill=what))+geom_histogram()
h1
h2<-ggplot(data=wine100,aes(x=price,fill=where))+geom_histogram()
h2
h3<-ggplot(data=wine100,aes(x=price,fill=where))+geom_histogram(position="dodge")
h3
h4<-h2 + facet_grid(where ~ .)
h4
h4+ggtitle("Histogram of Displayed Price")+ylab("Frequency")+xlab("Price per Bottle in $")
#  scale_fill_brewer("Wine Type"),palette="Set1")
# density
ggplot(data=wine100,aes(x=price))+geom_density(fill="blue")
d1<-ggplot(data=wine100,aes(x=price,fill=where))+geom_density()
d1
d2<-ggplot(data=wine100,aes(x=price,fill=where))+geom_density(position="identity",alpha=0.5)
d2
d3<-d2 + facet_grid(where ~ .)
d3
d3+ggtitle("Density Distribution of Displayed Price")+ylab("Probability Density")+
  xlab("Price per Bottle in $")
#  scale_fill_brewer("Country",palette="Set1")

# demand analysis
model1<-lm(quantity~price,data=wine100)
summary(model1)
model2<-lm(log(quantity)~log(price),data=wine100)
summary(model2)

g1<-ggplot(data=wine100,aes(x=log(price),y=log(quantity),col=what))+geom_point(alpha=0.5)
g1
g2<-g1 + geom_smooth(method="lm",col="blue",size=1)  # running loess could be a problem!
g2
g3<-g2 + facet_grid(. ~ what)
g3
g4<-g2 + facet_grid(where ~ .)
g4
g4+ggtitle("Demand Function for Table Wine in Vancouver BC")+theme_bw()
