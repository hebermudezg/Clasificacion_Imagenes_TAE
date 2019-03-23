# TAE_Clasificacion_Imagenes

# Resumen
En este informe se aborda la creación de un modelo de clasificación para predecir en imágenes
de personas si estas tiene gafas de sol (gafas oscuras), como también la creación de una
aplicación dinámica para la implementación del modelo.
Se crea una aplicación shiny en el lenguaje estadı́stico R, donde el usuario puede cargar una
imagen de cualquier formato o tamaño ya sea a color o en escala de grises y la aplicación
permite saber si la persona de la imagen tiene gafas de sol o no, como también se muestra la
probabilidad hallada por el modelo para hacer esta clasificación.

# Introducción
Para crear el modelo de clasificación de imágenes se decidió implementar un modelo de redes
neuronales convolucionales en el software estadı́stico R, donde se hizo uso de la librerı́a keras
para este objetivo.
El modelo toma la imagen ingresada por el usuario y la redimensiona para convertirla en
una matriz de 3 dimensiones, con dimensiones 100x100x3 (ancho y largo en pı́xeles, y las 3
componentes RGB) para ser evaluada en el modelo predictivo y arojar la calasificación. (Ver
Metodologı́a)

NOTA 1: El código del este trabajo se puede consultar en el siguiente repositorio
https://github.com/hebermudezg/TAE_Clasificacion_Imagenes

NOTA 2: La aplicación shiny se puede consultar en:
https://colnalitycs.shinyapps.io/StatiSoft_clasificar_Imagen/
