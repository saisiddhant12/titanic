setwd("~/Downloads/titanicData") #setting the working directory and importing files
train <- read.csv("train.csv", stringsAsFactors=FALSE) #importing train.csv this way as dataset is too big
train$Survived
table(train$Survived) #counts the occurence in each field
prop.table(table(train$Survived)) #return the percent of people survived/dead
test <- read.csv("test.csv", stringsAsFactors = FALSE) #importing test.csv 
test$Survived <- rep(0, 418)
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "DeathRegister.csv", row.names = FALSE)