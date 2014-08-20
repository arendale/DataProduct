

library(shiny)
library(caret)
library(randomForest)
library(ggplot2)
data(diamonds)
diamonds <- diamonds[sample(nrow(diamonds), 1000, replace=FALSE), ]
modFit <- randomForest(price~., data=diamonds)
# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
    checkCarat <- reactive( {
      if(input$carat <= 0) {
        print ("Carat must be positive. Try again.")
      }
    })
    checkDepth <- reactive( {
      if(input$depth <= 0) {
        print ("Depth percentage must be positive. Try again.")
      }      
    })
    checkTable <- reactive( {
      if(input$table <= 0) {
        print ("Table percentage must be positive. Try again.")
      }      
    })
    checkX <- reactive( {
      if(input$x <= 0) {
        print ("X must be positive. Try again.")
      }      
    })
    checkY <- reactive( {
      if(input$y <= 0) {
        print ("Y must be positive. Try again.")
      }      
    })
    checkZ <- reactive( {
      if(input$z <= 0) {
        print ("Z must be positive. Try again.")
      }      
    })
    pred <- reactive( {
      urDiamond <- data.frame(carat=input$carat,
                              cut = factor(input$cut, c("Fair", "Good", "Very Good", "Premium", "Ideal"), ordered=TRUE),
                              color = factor(input$color, c("D", "E", "F", "G", "H", "I", "J"), ordered=TRUE),
                              clarity = factor(input$clarity, c("I1", "SI2", "SI1", "VS2", "VS1", "VVS2", "VVS1", "IF"), ordered=TRUE),
                              depth=input$depth,
                              table=input$table,
                              x=input$x,
                              y=input$y,
                              z=input$z
                              )
      if(urDiamond$carat > 0 && urDiamond$depth > 0 && urDiamond$table >0 && 
           urDiamond$x > 0 && urDiamond$y > 0 && urDiamond$z > 0) {
        price <- predict(modFit, urDiamond)
        return(price)
      }
      else return(0)
    })
   output$text <- renderUI({
     if(input$action) {
       HTML(paste(checkCarat(), checkDepth(), checkTable(),
                  checkX(), checkY(), checkZ(), sep = '<br/>'))
     }
   })
  observe({
     if (input$action == 0)
       return()
       
       isolate({
         output$text1 <- renderText({           
            paste("$", round(pred(), 2))
       })
     })
     
#    if(input$action) {
#      tmp <- pred()
#      paste("$", round(tmp, 2))      
#    }
 })  
})

