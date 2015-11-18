library(shiny) 

shinyUI(pageWithSidebar( 
  headerPanel("Relationship of factors affecting miles per gallon (mpg)"), 
  sidebarPanel(
    selectInput("variable", "Input Variable:",
                c("Number of cylinders" = "cyl", "Displacement (cu.in.)" = "disp",
                  "Gross horsepower" = "hp", "Rear axle ratio" = "drat",
                  "Weight (lb/1000)" = "wt", "1/4 mile time" = "qsec",
                  "V/S" = "vs", "Transmission" = "am",
                  "Number of forward gears" = "gear", "Number of carburetors" = "carb") 
                ),
    checkboxInput("outliers", "Show outliers", FALSE),
    selectInput("color", "Choose color:", c("Red" = "#E41A1C","Blue" = "#377EB8","Green" = "#4DAF4A", "Purple" = "#984EA3",
                                            "Orange" = "#FF7F00", "Yellow" = "#FFFF33", "Brown" = "#A65628", "Pink" = "#F781BF",
                                            "Grey" = "#999999"))
    ),
  
  mainPanel(
    h3(textOutput("caption")),
    
    tabsetPanel(type = "tabs", 
                tabPanel("BoxPlot", plotOutput("mpgBoxPlot")),
                tabPanel("Regression Model", plotOutput("mpgPlot")),
                tabPanel("Fit Summary", verbatimTextOutput("fit"))
                
    )
  )
  )
)
