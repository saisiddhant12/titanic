setwd("~/Downloads/titanicData/")
train <- read.csv("train.csv")
test <- read.csv("test.csv")

library(RColorBrewer)
library(rpart)
library(rattle)
library(rpart.plot)

fit <- rpart(Survived ~ Sex, data=train, method="class")
plot(fit)
text(fit)
fancyRpartPlot(fit)

fitt <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
             data=train,
             method="class") #rpart does repeatative partition
fancyRpartPlot(fitt)

# Making a prediction and write a submission file
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

# Let's unleash the decision tree and let it grow to the max
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=2, cp=0))
fancyRpartPlot(fit)

# Now let's make a prediction and write a submission file
Prediction <- predict(fit, test, type = "class")
submit <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfullgrowntree.csv", row.names = FALSE)

# Manually trim a decision tree
fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=2, cp=0.005))
new.fit <- prp(fit,snip=TRUE)$obj
fancyRpartPlot(new.fit)
library(caret)
genderModel <- read.csv("gender_submission.csv")
confusionMatrix(submit$Survived,gender$Survived)
