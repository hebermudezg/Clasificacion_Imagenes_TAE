# hay que cargar todas las librerias aqui
library(shiny)
library(keras)
library(EBImage)
library(magick)

shinyServer(function(input, output, session) {
  
  model <- load_model_hdf5("model")
  
  d2 <- reactive({  # deberia ir en un evento reactivo
    pictures <- input$train_dir  # esto es la direccion de la imagen que se lee en la  ui
    if(! is.null(pictures)){
      pictures <- pictures$datapath
    }
    else{
      pictures <- "faces/an2i/an2i_left_angry_open.pgm"
    }
    pictures2 <- image_read(pictures) # la leo aqui para imprimirla
    
  })  # aqui cierro el evento reactivo. 
  
 prueba <- reactive({
   prueba <- array(resize(toRGB(as_EBImage(d2())),100,100), dim = c(1,100,100,3))
 })
  
  output$viz <- renderPlot({
    plot(d2())
  })
  
  output$prob <- renderText({
    
    #Probabilidad de que use gafas
    p <- model %>% predict_proba(prueba())
    paste(round(p[1,2]*100, 2),'%')
  })
  
  output$viz2 <- renderText({
    
    
    
    #Predicción de si usa gafas, 1 si usa, 0 si no
    clase <- model %>% predict_classes(prueba())
    
    if(clase==1){
      a <- "La persona tiene gafas de sol"
    }else{
      a <- "La persona NO tiene gafas de sol"
    }
    print(a)
  })
  
  
})
