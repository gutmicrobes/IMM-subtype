#read the data
setwd("F:/meng/school/2nd_paper/paper_data/2022.8.24/É¸Ñ¡Î¢ÉúÎïNA/colon2")
data <- read.csv("65bacteria+7virus+22cell+1355gene_feature.csv",header = T)
#colnames(data) <- data[1,]
#data <- data[-1,-1:-2]

#divide the data into two parts as train data and test data
set.seed(1)
train <- sample(nrow(data), nrow(data)*0.5)
test <- c(1:nrow(data))[-train]
train_data <- data[train,]
test_data <- data[test,]

library(glmnet)
x <- as.matrix(data[,c(3:1357)])
y <- as.matrix(data[,c(2)])
fit <- glmnet(x, y, family="binomial", alpha=1)
plot(fit)
set.seed(1)
cv.fit <- cv.glmnet(x, y, family="binomial", alpha=1, type.measure = "class", nfolds = 10)
plot(cv.fit)
bestlam1 <- cv.fit$lambda.min
bestlam2 <- cv.fit$lambda.1se
lasso.coef <- predict(fit, type = "coefficients", s = bestlam1)[1:1355, ]
lasso.coef[lasso.coef != 0]

write.csv(lasso.coef[lasso.coef != 0],"lasso_gene_result.csv")
name2 <- read.csv("lasso_gene_result.csv")
data_bac <- data[name2$name] 
write.csv(data_bac,"22cell+18gene.csv")
