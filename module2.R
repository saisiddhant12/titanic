setwd("~/Kaggle/Titanic")
train <- read.csv("train.csv")
test <- read.csv("test.csv")
summary(train$Age) #gives you the statistics of age of every passenger

#lets introduce a new variable named child that is initialised to 1 if the person is below the age of 18
train$Child <- 0
train$Child[train$Age < 18] <- 1 # replaces 0 to 1 if its a child

aggregate(Survived ~ Child + Sex, data=train, FUN=sum) # the command aggregate uses Survived as target variable and takes the subsets(Child and Sex) to consideration and train as the dataFrame and finally what function should I apply, here SUM function applies to PeopleSurvived
aggregate(Survived ~ Child + Sex, data=train, FUN=length)# the command calculates total people irrespective of death/survival
aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)}) #percent of people survived

#Most females survived but, very few male child are surviving

train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0

submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)
write.csv(submit, file = "DeathRegister1.csv", row.names = FALSE)

library(caret)
deathregister <- read.csv('DeathRegister1.csv')
gender <- read.csv('gender_submission.csv')
confusionMatrix(deathregister$Survived,gender$Survived)