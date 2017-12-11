setwd("~/Downloads/titanicData") #setting the working directory and importing files
train <- read.csv("train.csv", stringsAsFactors=FALSE) #importing train.csv this way as dataset is too big
train$Survived
table(train$Survived) #counts the occurence in each field
prop.table(table(train$Survived)) #return the percent of people survived/dead
test <- read.csv("test.csv", stringsAsFactors = FALSE) #importing test.csv 
test$Survived <- rep(0, 418)
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived) #Creates a new data frame 
write.csv(submit, file = "DeathRegister.csv", row.names = FALSE) #dumps the data frame's data to a file

prop.table(table(train$Sex, train$Survived)) # shows survival and death of people, irrespective of sex
prop.table(table(train$Sex, train$Survived),1) #shows survival and death of people based upon sex

test$Survived <- 0 #creates a column named Survived with default value as 0
test$Survived[test$Sex == 'female'] <- 1 #checks for female as sex and replacing the survived value as 1

library(caret)
deathregister <- read.csv('DeathRegister.csv')
gender <- read.csv('gender_submission.csv')
confusionMatrix(deathregister$Survived,gender$Survived)
