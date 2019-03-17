library(keras)
library(EBImage)
library(magick)

pictures <- list.files(path = "faces", recursive = TRUE, full.names = TRUE, pattern = ".*[.]pgm")

model <- load_model_hdf5("model")

#Leer imagen, se hace con magick
imagen <- image_read(pictures[44])

prueba <- array(resize(toRGB(as_EBImage(imagen)),100,100), dim = c(1,100,100,3))

model %>% predict_classes(prueba)

model %>% predict_proba(prueba)
