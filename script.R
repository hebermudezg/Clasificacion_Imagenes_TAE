require(magick)
#require(keras)

#Obtener las rutas de cada imagen
nombresImagen <- list.files(path = "faces", recursive = TRUE, full.names = TRUE, pattern = ".*[.]pgm")

#cargar la lista de imagenes
img_list <- lapply(nombresImagen, image_read)

#convertir cada imagen en matriz
matriz_imagen <- lapply(img_list, image_data)

#convertir cada matriz en vector
vector_imagen <- lapply(matriz_imagen, as.vector)

#saber si la imagen es o no con gafas.
usa_gafas <- as.integer(grepl(".*glasses.*",nombresImagen))

#crear data frame
dataframe <- data.frame(I(vector_imagen), usa_gafas)

