library(shiny)
library(shinydashboard)

dashboardPage(skin = "red", 
  dashboardHeader(title = "Statisoft"),
  
  # creando el menu 
  dashboardSidebar(
    sidebarMenu(
      menuItem("Selección", tabName = "train", icon = icon("fas fa-chart-line")),
      menuItem("Funcionamiento", tabName = "Funcio", icon = icon("fas fa-cogs")),
      menuItem("Modelo Estadístico", tabName = "modelo", icon = icon("fas fa-chart-line")),
      menuItem("Nosotros", tabName = "about", icon = icon("fas fa-users"))
     
    )),

  # stilo de la pagina
  dashboardBody(tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  
  # creando el seleccionador de imagen ( se llama train)
  tabItems(
    tabItem(tabName = "train",
            box(title = "Selección de imagen",
                fileInput('train_dir', label = 'Seleccione la imagen para clasificar')
               ),
            tabItem(tabName = "train",
                    box(title = "Imagen seleccionada",
                        plotOutput("viz")
                    )),
            # vamos a mostrar la clasificacion
            tabItem(tabName = "Selección",
                    box(
                      width = 4, background = "red",
                      title = "La probabilidad de ser alguien con gafas de sol:",
                        textOutput("prob")
                    ),
                    box(
                      width = 4
                    ),
                    
                    box(
                      width = 4, background = "light-blue",
                      title = "La persona se clasifica como:",
                        textOutput("viz2")
                    ))
    ),
    
    

    # Inicial la seccion Funcio *************************************
    
    tabItem(tabName = "Funcio",
            box(width = 15, solidHeader = TRUE, background = "light-blue", 
              tags$h4("Funcionamiento de la aplicación",
                      style = "font-family: 'Arial Narrow';
                      font-weight: 500;
                      text-align: center;
                      color: #000000;")),
            box(width = 15, solidHeader = TRUE,
            tags$h5("
                    La aplicación Shiny permite al usuario ingresar cualquier tipo de formato de imagen y predecir si en esta imagen hay una persona con gafas de sol (gafas oscuras).
                    ",
                    style = "font-family: 'Arial';
                      font-weight: 6;
                      text-align: center;
                      color: #000000;")
                   ),
            
    box(width = 15, solidHeader = TRUE,
        tags$h5("
                    La aplicación acepta los formatos de imágenes mas  usados como son, jpg, png, pgm, entre otros, la imagen puede estar a color o en escala de grises, y esta puede ser de cualquier tamaño o cantidad de píxeles.  
                        ",
                style = "font-family: 'Arial';
                      font-weight: 6;
                      text-align: center;
                      color: #000000;")),
    
    box(width = 15, solidHeader = TRUE,
        tags$h5("
                    Una vez cargada la imagen, la aplicación calculará la probabilidad de que en la imagen haya una persona con gafas de sol y la clasificará.
                    ",
                style = "font-family: 'Arial';
                      font-weight: 6;
                      text-align: center;
                      color: #000000;")),
    
    
    
    box(width = 15, solidHeader = TRUE,
        tags$h5("La probabilidad se mostrara en porcentaje y la clasificación solo puede tomar dos valores           
                 1) La persona tiene gafas de sol  o 
                 2) La persona no tiene gafas de sol.  
                    ",
                style = "font-family: 'Arial';
                      font-weight: 6;
                      text-align: center;
                      color: #000000;")
    ),
    
    box(width = 15, solidHeader = TRUE, background = "yellow",
        tags$h5("Para más información consulte la pestaña (Modelo Estadístico)",
                style = "font-family: 'Arial';
                      font-weight: 6;
                      text-align: center;
                      color: #000000;")
    )
    
    
    ),
    

        
    ### Seccion modelo
    tabItem(tabName ="modelo",
            tags$iframe(style='height:550px; width:100%; marginheight.0; marginwidth:0', 
                        src='informe_metodologia_clasificacion_imagenes.pdf')  #la imagen debe estar en la carpeta www pero no se pone en el src
    ),
    

    
  ## seccion nosotros ***************************
    tabItem(tabName = "about",
            tags$h4("¿Quienes somos?",
                    style = "font-family: 'Arial Narrow';
                    font-weight: 500;
                    text-align: center;
                    color: #616263;"
            ),
            br(),
            
            tags$h5("John Bryan Yepez Herrera - jbyepezh@unal.edu.co",
                    style = "font-family: 'Arial';
                    font-weight: 10;
                    text-align: center;
                    color: #616263;"
            ),
            
            
            tags$h5("Heber Esteban Bermúdez González - hebermudezg@unal.edu.co",
                    style = "font-family: 'Arial';
                    font-weight: 10;
                    text-align: center;
                    color: #616263;"
            ),
            
            

            
            tags$h5("Simon Zapata Gutierrez - sizapatagu@unal.edu.co",
                    style = "font-family: 'Arial';
                    font-weight: 10;
                    text-align: center;
                    color: #616263;"
            ),
            
            br(),
            br(),

            box(width = 15, solidHeader = TRUE, background = "red",
            tags$h5("Somos un grupo de Ingenieros y Estadísticos de la Universidad Nacional de Colombia, dueños de la empresa StatiSoft Corporation, que será una las mas importantes firmas de servicios profesionales del mundo, incluyendo auditoría, finanzas, contabilidad, estudios actuariales, asesoramiento y desarollo de software.",
                    style = "font-family: 'Arial';
              font-weight: 10;
              text-align:justify;
              color: #000000;"
            ))
                
            )
    
    )
      
    
  ))