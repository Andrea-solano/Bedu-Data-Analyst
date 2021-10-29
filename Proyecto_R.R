#------------Intento 1 dashboard

library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(forcats)
#library(glyphicon)
#install.packages("glyphicon")
#library(opencontracts)
#proyecto/ODS/dashboard1
#---------- Se agregan los datos
getwd()
setwd("c:/R/proyecto/ODS/dashboard1")
dir()
dashdata<-read.csv("complete_data")
pobreza<- read.csv("pobreza_ajustado.csv")
dashdata
#---------------------------------------------------------
#Limpieza de datos
i<-0
for(i in 5:24) {
  p1 <- pobreza[,i]
  pobreza[,i]<- as.double(p1)
}
pobreza$"X2019" <- NULL

#---------------------------------------------------

ui<-dashboardPage( title="Andrea Solano",skin="red",
                   
        dashboardHeader(title="ODS",
        dropdownMenu(type="messages",messageItem(from="Andrea","dashdata"),
                     messageItem(from="Andrea","pobreza")
                                   ),           
        
        dropdownMenu(type="notifications",
                     notificationItem(text="ODS")
                     ),
        dropdownMenu(type="tasks",
                     taskItem(value=100,text="Natalidad",
                        color="blue" ),
                     taskItem(value=100,text="Internet",color="red")
                     ,
                     taskItem(value=40,text="Pobreza",color="green")
                     )
        
    ),
    dashboardSidebar(
        sidebarSearchForm("searchText","buttonSearch","Buscar",
                          icon = shiny::icon("handshake-o"))
        ,
       sidebarMenu(id="sidebarID",
                    menuItem("Análisis de datos",tabName= "dash1"),
                   #Crea primera ventana
                    menuSubItem("Natalidad"),
                   menuItem("Pobreza",tabName= "pobreza"),
                   #Entrada de la primera ventana
                   #Para desplegar un menÃº: opciones dentro del menu
                    menuItem("Bases de datos",id = "chartsID",
                             menuSubItem("BD Natalidad/Internet", tabName = "datos", icon = shiny::icon("eye")),
                             menuSubItem("BD pobreza", tabName = "datos1", icon = shiny::icon("eye"))
                             #por defecto pone lÃ­neas, tu puedes cambiar icono
                          
                    )
        )
       
        
        
    ),
    dashboardBody(
        #tabItem 
        tabItems(tabItem(tabName = "datos", 
                         #tabName se llama en subventana1
                         DT::dataTableOutput("datos")
                         #nombre datos en server
                         
        )),
        tabItems(tabItem(tabName = "datos1", 
                         #tabName se llama en subventana1
                         DT::dataTableOutput("datos1")
                         #nombre datos en server
                         
        )),
        tabItem(tabName = "dash1", 
                fluidRow(
                    column(width=9,  
                           #valueBox("ODS","Objetivos de Desarrollo Sostenible",
                                    #icon=icon("eye"),color="yellow"),
                           infoBox(
                                   "Fueron creados en 2015, con el objetivo de",
                                   "erradicar la pobreza, proteger el planeta y asegurar la prosperidad para todos como parte de una nueva agenda de desarrollo sostenible. Cada objetivo tiene metas específicas que deben alcanzarse en los próximos 15 años.",
                                   color="green",
                                    width=12 ,icon=icon("eye"))
                           #3 recuadros superiores, width tamaÃ±o
                            #recordar que el ancho total es 12 y default  4
                    ),
                    column(width=1, imageOutput("figura", width="50%",height="50px")),
                    #Agregar imÃ¡gen
                    #CÃ³mo cambiar tamaÃ±o de la imagen
                    fluidRow(box(title="Grupo de Ingresos por Región",fill="yellow",
                                 plotOutput("dash1"),
                                 width=12, status="primary",
                                 color="green",
                                 solidHeader=TRUE)))
                    #Recordar que tiene tamaÃ±o max
                    #solidHeader todo el encabezado de color
                    ),
        infoBox("Media de la Tasa de Natalidad MUNDIAL ",
                "21.46993",
                color="green",
                width=9,icon=icon("alarm")),
        
        tabItem(tabName = "dash0", 
                fluidRow(
                    fluidRow(box(title="Tasa de Natalidad",plotOutput("dash0"),
                                 width=12, status="primary", 
                                 solidHeader=TRUE)))
                #Recordar que tiene tamaÃ±o max
                #solidHeader todo el encabezado de color
        ),
        
        tabItem(tabName = "dash1_2", 
                fluidRow(
                    fluidRow(box(title="Boxplot- Tasa de Natalidad por Regiones",
                                 plotOutput("dash1_2"),
                                 width=12, status="primary", 
                                 solidHeader=TRUE)))
                #Recordar que tiene tamaÃ±o max
                #solidHeader todo el encabezado de color
        ),
        infoBox("Media por Región"," Africa - 34.27    
                America-16.31    Asia - 19.51     Europa - 10.69  
                Medio Oriente - 21.26     Oceania - 22.14",
                color="green",
                width=9,icon=icon("alarm")),
        tabItem(tabName = "dash2", 
                fluidRow(
                    
                    fluidRow(box(title="Diagrama de densidad",
                                 plotOutput("dash1_1"),
                                 width=12, status="primary", 
                                 solidHeader=TRUE)))
                #Recordar que tiene tamaÃ±o max
                #solidHeader todo el encabezado de color
        ),
        
        
        #--------------
        valueBox("Internet","Porcentaje de la población CON acceso a Internet",
                 icon=icon("eye"),color="yellow",width=12),
        
        infoBox("Media de % de población con acceso a Internet MUNDIAL",
                "42.08%",
                color="green",
                width=9,icon=icon("alarm")),
        
        tabItem(tabName = "dash1_1", 
                fluidRow(
                    
                    fluidRow(box(title="Porcentaje de la población CON acceso a Internet por regiones",
                                 plotOutput("dash2"),
                                 width=12, status="primary", 
                                 solidHeader=TRUE)))
                #Recordar que tiene tamaÃ±o max
                #solidHeader todo el encabezado de color
        ),
        tabItem(tabName = "dash3", 
                fluidRow(
                     fluidRow(box(title="Grupo de Ingresos",plotOutput("dash3"),
                   width=12, status="primary", 
                                 solidHeader=TRUE)))
                #Recordar que tiene tamaÃ±o max
                #solidHeader todo el encabezado de color
        ),
        tabItem(tabName = "dash4", 
                fluidRow(
                    fluidRow(box(title="Boxplot",plotOutput("dash4"),
                                 width=12, status="primary", 
                                 solidHeader=TRUE)))
                #Recordar que tiene tamaÃ±o max
                #solidHeader todo el encabezado de color
        ),
        valueBox("","",
                 icon=icon("eye"),color="yellow",width=12),
        
        tabItem(tabName = "dash5", 
                fluidRow(
                    fluidRow(box(title="Tasa de Natalida/Penetración de Internet",plotOutput("dash5"),
                                 width=12, status="primary", 
                                 solidHeader=TRUE)))
        ),
        tabItem(tabName = "dash6", 
                fluidRow(
                    fluidRow(box(title="Correlación?",plotOutput("dash6"),
                                 width=12, status="primary", 
                                 solidHeader=TRUE)))
        ),
        tabItem(tabName = "dash7", 
                fluidRow(
                    fluidRow(box(title="Correlación?",plotOutput("dash7"),
                                 width=12, status="primary", 
                                 solidHeader=TRUE)))
        ),
        infoBox("Correlación entre Natalidad e Internet",
                "-0.8155886",
                color="red",
                width=9,icon=icon("eye")),
        
        valueBox("Pobreza","",
                 icon=icon("eye"),color="yellow",width=12),
        
        infoBox("El 46% de la población vive bajo el umbral de pobreza",
                color="red",
                width=10,icon=icon("")),
        
       tabItem(tabName = "dash8", 
                fluidRow(
                  fluidRow(box(title="Pobreza por Región",plotOutput("dash8"),
                               width=12, status="primary", 
                               solidHeader=TRUE)))
        ),
        tabItem(tabName = "dash9", 
                fluidRow(
                  fluidRow(box(title="Pobreza por Región",plotOutput("dash9"),
                               width=12, status="primary", 
                               solidHeader=TRUE)))
        )
        

    
) #dash body


) #General
#----------------------------------------------------------
server <- function(input, output) { 
    #El nombre datos se ocupa en Body
    output$datos<-DT::renderDataTable(dashdata)

    output$datos1<-DT::renderDataTable(pobreza)
    
    output$figura <- renderImage({
        return(list(src = "www/img.png",contentType = "image/png")) })
        
    output$pob_internet <- renderImage({
        return(list(src = "www/02pob_internet.png",contentType = "image/png")) })
    
    output$dash0 <- renderPlot( 
        
        ggplot(data=dashdata,aes(x=Tasa.Natalidad,fill=Region))+
        geom_histogram(color="Black")+
        xlab("Tasa de natalidad")+ylab("Numero de países")+
        facet_grid(Region~., scales="free")+
        ggtitle("Tasa de Natalidad por Regiones")+ 
        theme(
            axis.title.x=element_text(color="DarkGreen",size=15),
            axis.title.y=element_text(color="DarkGreen",size=10),
            axis.text.x=element_text(size=10),
            axis.text.y=element_text(size=8),
            legend.title=element_text(size=10),
            legend.text=element_text(size=8),
            plot.title=element_text(color="DarkBlue",size=20,hjust=0.7)
    )
    )
   # % de la pob con acceso a Internet
    output$dash2<-renderPlot({dash2})
    output$dash2 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Penetracion.Internet,fill=Region))+
        geom_histogram(color="Black")+
            xlab("")+ylab("Numero de países")+
            facet_grid(Region~., scales="free")+
            ggtitle("% de pob con acceso a Internet por Regiones")+ 
            theme(
                axis.title.x=element_text(color="DarkGreen",size=15),
                axis.title.y=element_text(color="DarkGreen",size=10),
                axis.text.x=element_text(size=10),
                axis.text.y=element_text(size=8),
                legend.title=element_text(size=8),
                legend.text=element_text(size=5),
                plot.title=element_text(color="DarkBlue",size=15)
            )
            )
    output$dash1_1<-renderPlot({dash1_1})
    output$dash1_1 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Tasa.Natalidad,fill=Region))+
            geom_density(color="Black",alpha=0.3)+
            xlab("Tasa de natalidad")+ylab("Numero de países")+
            facet_grid(Region~., scales="free")+
            ggtitle("Tasa de Natalidad por Regiones")+ 
            theme(
                axis.title.x=element_text(color="DarkGreen",size=15),
                axis.title.y=element_text(color="DarkGreen",size=10),
                axis.text.x=element_text(size=10),
                axis.text.y=element_text(size=8),
                legend.title=element_text(size=10),
                legend.text=element_text(size=8),
                plot.title=element_text(color="DarkBlue",size=20,hjust=0.7)
      )
    )
    output$dash1_2<-renderPlot({dash1_2})
    output$dash1_2 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Tasa.Natalidad,fill=Region))+
        geom_boxplot(color="Black",alpha=0.6)+
            xlab("Tasa de natalidad")+ylab("")+
            facet_grid(Region~., scales="free")+
            ggtitle("")+ 
            theme(
                axis.title.x=element_text(color="DarkGreen",size=15),
                axis.title.y=element_text(color="DarkGreen",size=10),
                axis.text.x=element_text(size=10),
                axis.text.y=element_text(size=8),
                legend.title=element_text(size=10),
                legend.text=element_text(size=8),
                plot.title=element_text(color="DarkBlue",size=20,hjust=0.7)
            )
        
        
    )
    output$dash3<-renderPlot({dash3})
    output$dash3 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Penetracion.Internet,fill=Grupo.Ingresos))+
            geom_histogram(color="Black")+
            xlab("% de pob acceso a Internet")+ylab("Numero de países")+
            facet_grid(Region~., scales="free")+
            ggtitle("")+ 
            theme(
                axis.title.x=element_text(color="DarkGreen",size=15),
                axis.title.y=element_text(color="DarkGreen",size=10),
                axis.text.x=element_text(size=10),
                axis.text.y=element_text(size=8),
                legend.title=element_text(size=10),
                legend.text=element_text(size=8),
                plot.title=element_text(color="DarkBlue",size=15)
            )
    )
    output$dash1<-renderPlot({dash1})
    output$dash1 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Grupo.Ingresos,fill=Region))+
            geom_bar(color="Black",alpha=0.9)+
            xlab("Grupo de Ingresos")+ylab("Países")+
            ggtitle("")+ 
            coord_flip()+
            theme(
                axis.title.x=element_text(color="DarkGreen",size=11),
                axis.title.y=element_text(color="DarkGreen",size=11),
                axis.text.x=element_text(size=10,angle=20,color="Black"),
                axis.text.y=element_text(size=8,color="Black"),
                legend.title=element_text(size=12,color="DarkBlue"),
                legend.text=element_text(size=8),
                plot.title=element_text(color="DarkRed",size=15,hjust=0.8)
            )
    )
    output$dash4<-renderPlot({dash4})
    output$dash4 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Penetracion.Internet,fill=Region))+
        geom_boxplot(color="Black",alpha=0.6)+
            xlab("Pob con acceso a Internet")+ylab("")+
            facet_grid(Region~., scales="free")+
            ggtitle("")+ 
            theme(
                axis.title.x=element_text(color="DarkGreen",size=15),
                axis.title.y=element_text(color="DarkGreen",size=10),
                axis.text.x=element_text(size=10),
                axis.text.y=element_text(size=8),
                legend.title=element_text(size=10),
                legend.text=element_text(size=8),
                plot.title=element_text(color="DarkBlue",size=20,hjust=0.7)
            )
    )
    output$dash5<-renderPlot({dash5})
    output$dash5 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Tasa.Natalidad,y=Penetracion.Internet,
                                      color=Grupo.Ingresos))+
        geom_point(size=2)+
            geom_smooth(alpha=0.3)+
            xlab("Tasa de Natalidad")+ylab("Penetración de Internet")+
            ggtitle("")+ 
            theme(
                axis.title.x=element_text(color="DarkGreen",size=11),
                axis.title.y=element_text(color="DarkGreen",size=11),
                axis.text.x=element_text(size=10),
                axis.text.y=element_text(size=8),
                legend.title=element_text(size=12,color="DarkBlue"),
                legend.text=element_text(size=8),
                plot.title=element_text(color="DarkRed",size=15,hjust=0.5)
            )
    )
    output$dash6<-renderPlot({dash6})
    output$dash6 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Tasa.Natalidad,y=Penetracion.Internet,
                                 color=Grupo.Ingresos))+
            geom_point(size=2)+
            xlab("Tasa de Natalidad")+ylab("Penetración de Internet")+
            ggtitle("")+ 
            theme(
                axis.title.x=element_text(color="DarkGreen",size=11),
                axis.title.y=element_text(color="DarkGreen",size=11),
                axis.text.x=element_text(size=10),
                axis.text.y=element_text(size=8),
                legend.title=element_text(size=12,color="DarkBlue"),
                legend.text=element_text(size=8),
                plot.title=element_text(color="DarkRed",size=15,hjust=0.5)
            )
    )
    output$dash7<-renderPlot({dash7})
    output$dash7 <- renderPlot( 
        ggplot(data=dashdata,aes(x=Tasa.Natalidad,y=Penetracion.Internet,
                                 color=Region))+
            geom_point(size=2)+
            xlab("Tasa de Natalidad")+ylab("Penetración de Internet")+
            ggtitle("")+ 
            theme(
                axis.title.x=element_text(color="DarkGreen",size=11),
                axis.title.y=element_text(color="DarkGreen",size=11),
                axis.text.x=element_text(size=10),
                axis.text.y=element_text(size=8),
                legend.title=element_text(size=12,color="DarkBlue"),
                legend.text=element_text(size=8),
                plot.title=element_text(color="DarkRed",size=15,hjust=0.5)
            )
    )
    output$dash8<-renderPlot({dash8})
    output$dash8 <- renderPlot( 
      ggplot(data=pobreza,aes(x=X2000,
                              color=Region))+
        geom_histogram(size=2,fill="black")+
        xlab("Pobreza año 2000")+ylab("países")+
        ggtitle("")+ 
        theme(
          axis.title.x=element_text(color="DarkGreen",size=08),
          axis.title.y=element_text(color="DarkGreen",size=11),
          axis.text.x=element_text(size=10),
          axis.text.y=element_text(size=8),
          legend.title=element_text(size=12,color="DarkBlue"),
          legend.text=element_text(size=8),
          plot.title=element_text(color="DarkRed",size=15,hjust=0.8)
        )
    )
    output$dash9<-renderPlot({dash9})
    output$dash9 <- renderPlot( 
      ggplot(data=pobreza,aes(x=country,y=X2000,color=Region))+
        geom_point(size=2,fill="black")+
        xlab("Países año 2000")+ylab("Índice de pobreza")+
        facet_grid(~Region, scales="free")+
        ggtitle("")+ 
        theme(
          axis.title.x=element_text(color="DarkGreen",size=15),
          axis.title.y=element_text(color="DarkGreen",size=11),
          axis.text.x=element_text(size=0,NULL),
          axis.text.y=element_text(size=8),
          legend.title=element_text(size=12,color="DarkBlue"),
          legend.text=element_text(size=8),
          plot.title=element_text(color="DarkRed",size=15,hjust=0.8)
        )
      
    )
    output$imgpob <- renderImage({
      return(list(src = "www/imgpob.png",contentType = "image/png")) })
}


shinyApp(ui, server)
 