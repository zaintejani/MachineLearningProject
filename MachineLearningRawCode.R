### RAW CODE FOR MACHINE LEARNING PROJECT ###

## Loading the caret and randomForest packages for machine learning functions
library(caret); library(randomForest); library(e1071)

## Importing test and train data into R
train<-read.csv("pml-training.csv", na.strings=c(""," ","NA"))
test<-read.csv("pml-testing.csv", na.strings=c(""," ","NA"))

## Removing NAs and irrelevant data
train2 <- train[, !apply(train, 2, function(x) any(is.na(x)))]
train2<-train2[,-c(1:7)]

## Creating sample testing and training sets using a data partition
inTrain<-createDataPartition(y=train2$classe, p=0.75, list=FALSE)
ttrain<-train2[inTrain,]
ttest<-train2[-inTrain,]

## Training the model using the randomForest function on the ttrain set
model<-randomForest(formula=classe~., data=ttrain)
model

## Using the model to predict the sample test case, ttest
a<-predict(model, newdata=ttest)
confusionMatrix(a, reference=ttest$classe)

## Processing the test data in the same fashion as the training data
test2 <- test[, !apply(test, 2, function(x) any(is.na(x)))]
test2<-test2[,-c(1:7)]

## Applying the model to the test data, and outputting predictions
b<-predict(model, newdata=test2)
b