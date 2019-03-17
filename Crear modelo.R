# Convolutional Neural Networks

# Load packages
library(keras)
library(EBImage)
library(magick)

# Read Images
pic1 <- list.files(path = "faces", recursive = TRUE, full.names = TRUE, pattern = ".*[.]pgm")

trainSize <- 420

# data train
trainImg <- list()
for (i in 1:trainSize) {trainImg[[i]] <- image_read(pic1[i])}
train <- lapply(trainImg, as_EBImage)
train <- lapply(train, toRGB)


#data test 
testImg <- list()
for (i in (trainSize+1):length(pic1)) {testImg[[i-trainSize]] <- image_read(pic1[i])}
test <- lapply(testImg, as_EBImage)
test <- lapply(test, toRGB)

# # Explore
 print(train[[12]])
 summary(train[[12]])
 display(train[[12]])
 plot(train[[12]])
# 
# #par(mfrow = c(---, ---))
# for (i in 1:15) plot(train[[i]])
# par(mfrow = c(1,1))

# Resize & combine
for (i in 1:length(train)) {train[[i]] <- resize(train[[i]], 100, 100)}
for (i in 1:length(test)) {test[[i]] <- resize(test[[i]], 100, 100)}

str(train)

train <- combine(train)
display(tile(train, 24), title='Pictures')

test <- combine(test)
display(tile(test, 36), title = 'Pics')

# Reorder dimension
train <- aperm(train, c(4, 1, 2, 3))
test <- aperm(test, c(4, 1, 2, 3))

# Response
testy <- as.integer(grepl(".*glasses.*",pic1))
trainy <- testy[1:trainSize]
testy <- testy[(trainSize+1):length(pic1)]

# One hot encoding
trainLabels <- to_categorical(trainy)
testLabels <- to_categorical(testy)

# Model
model <- keras_model_sequential()

keras_model

model %>%
         layer_conv_2d(filters = 32, 
                       kernel_size = c(3,3),
                       activation = 'relu',
                       input_shape = c(100, 100, 3)) %>%
         layer_conv_2d(filters = 32,
                       kernel_size = c(3,3),
                       activation = 'relu') %>%
         layer_max_pooling_2d(pool_size = c(2,2)) %>%
         layer_dropout(rate = 0.25) %>%
         layer_conv_2d(filters = 64,
                       kernel_size = c(3,3),
                       activation = 'relu') %>%
         layer_conv_2d(filters = 64,
                       kernel_size = c(3,3),
                       activation = 'relu') %>%
         layer_max_pooling_2d(pool_size = c(2,2)) %>%
         layer_dropout(rate = 0.25) %>%
         layer_flatten() %>%
         layer_dense(units = 256, activation = 'relu') %>%
         layer_dropout(rate=0.25) %>%
         layer_dense(units = 2, activation = 'softmax') %>%
         
         compile(loss = 'categorical_crossentropy',
                 optimizer = optimizer_sgd(lr = 0.01,
                                           decay = 1e-6,
                                           momentum = 0.0,
                                           nesterov = T),
                 metrics = c('accuracy'))
summary(model)

# Fit model
history <- model %>%
         fit(test,
             testLabels,
             epochs = 1,
             batch_size = 32,
             validation_split = 0.2,
             validation_data = list(train, trainLabels))
plot(history)

# Evaluation & Prediction - train data
model %>% evaluate(train, trainLabels)
pred <- model %>% predict_classes(train)
a <- table(Predicted = pred, Actual = trainy)

prob <- model %>% predict_proba(train)
cbind(prob, Predicted_class = pred, Actual = trainy)

# Evaluation & Prediction - test data
model %>% evaluate(test, testLabels)
pred <- model %>% predict_classes(test)
b <- table(Predicted = pred, Actual = testy)

prob <- model %>% predict_proba(test)
cbind(prob, Predicted_class = pred, Actual = testy)

# Save model
save_model_hdf5(model, "model")

# Load model
model <- load_model_hdf5("model")

# Predicciones sobre una imagen
prueba1 <- array(combine(resize(toRGB(as_EBImage(image_read(pic1[44]))),100,100)), dim = c(1,20,20,3))
model %>% predict_classes(prueba1)
