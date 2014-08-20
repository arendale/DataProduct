

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Developing Data Products: Quoting diamonds price"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      h2("Diamond parameters"),
      helpText(p("Diamonds are precious. This application is to help you find the price of certain diamond.
               The only thing you need to do is typing in the parameters of diamonds and it will predict
               the price for you based on thousands of diamonds in database. You may wonder what these 
                 parameters are. They are"), 
               code("carat"), code("cut"), code("color"), code("clarity"),
               code("depth"), code("table"), code("x"), code("y"), code("z"),
               p("That sounds a lot. But don't worry, I will explain them one by one."),
               h3("carat"),
               p(strong("Carat"),"is the unit of mass for diamonds. 1 carat is 0.2 gram or 0.007055 oz. Usually the weight
                 of diamond is only a few carats."),
               br(),
               h3("cut"),
               p("The", strong("cut"), "of diamonds are classified into 5 levels:", code("Ideal"), code("Premium"),
                 code("Very Good"), code("Good"), code("Fair"), "in descending order."),
               br(),
               h3("color"),
               p("The perfect diamond is purely colorless. Diamonds are graded according to their colors on
                 scale from", strong("D"), "to", strong("Z"), ".", strong("D"), "denotes", strong("colorless"), ".", 
                 "I have no clue why it starts from", strong("D"), ".", "Unfortunately, in our database, we only have diamonds
                 from", strong("D"), "to", strong("J"), "."),
               br(),
               h3("clarity"),
               p(strong("clarity"), "measures diamonds' internal flaws called", em("inclusions"), ". The clearest diamond is
                 rated as", strong("FL"), "(stands for", em("flawless"), ").", "There are eight grades can be predicted in
                 app:", strong("IF"), strong("VVS1"), strong("VVS2"), strong("VS1"), strong("VS2"), strong("SI1"), strong("SI2"),
                 strong("I1"), "in descending order."),
               br(),
               h3("depth, table, x, y, z"),
               p("After introducing 4", strong("C"), "s,", "now we move on to dimensions.", "The picture below describes the meaning of
                 each variable. For more details, please check out", a("this website", href="http://www.diamondse.info/"), "."),
               img(src = "diamonds.png", height = 200, width = 400),
               br(),
               h2("Prediction Algorithm"),
               p("In case you may wonder how the prediction works behind the stage, the algorithm applied here is called", 
                 a("Random Forest", href="http://en.wikipedia.org/wiki/Random_forest"), ".", "The original dataset from package", 
                 code("ggplot2"), "has about 50000 observations. To speed up the prediciton, I sampled 1000 observations from it."))
      ),
    
    # Show a plot of the generated distribution
    mainPanel(
      numericInput("carat", 
                   label = h3("The carat of your diamond:"), 
                   value = 0.00, min = 0, step = 0.01),  
      helpText("This app works better for diamonds below 10 carats. The accuracy is 0.01 carat."),
      br(),
      selectInput("cut", label = h3("Select cut of your diamond:"), 
                  choices = list("Ideal" = "Ideal", "Premium" = "Premium",
                                 "Very Good" = "Very Good", "Good" = "Good", "Fair" = "Fair"),
                  selected = "Ideal"),
      br(),
      selectInput("color", label = h3("Select color of your diamond:"), 
                  choices = list("D" = "D", "E" = "E", "F" = "F", "G" = "G",
                                 "H" = "H", "I" = "I", "J" = "J"), selected = "D"),
      br(),
      selectInput("clarity", label = h3("Select clarity of your diamond:"), 
                  choices = list("IF" = "IF", "VVS1" = "VVS1", "VVS2" = "VVS2", "VS1" = "VS1", 
                                 "VS2" = "VS2", "SI1" = "SI1", "SI2" = "SI2", "I1" = "I1"), selected = "IF"), 
      br(),
      h3("The dimensions of your diamond:"),
      numericInput("depth", 
                   label = h4("Depth in %"), 
                   value = 0, min = 0, max = 100, step = 0.1),   
      numericInput("table", 
                   label = h4("Table in %"), 
                   value = 0, min = 0, max = 100, step = 0.1),   
      numericInput("x", 
                   label = h4("X in mm"), 
                   value = 0.00, step = 0.01),   
      numericInput("y", 
                   label = h4("Y in mm"), 
                   value = 0.00, step = 0.01),   
      numericInput("z", 
                   label = h4("Z in mm"), 
                   value = 0.00, step = 0.01),
      br(),
      br(),
      tags$form(actionButton("action", "Submit"),
                br(),
                br(),
                br(),
                p(h3("Your diamond price: "), h1(textOutput("text1"))),
                br(),
                strong("Error messages:"),
                htmlOutput("text")
      )
      )
  )
))

