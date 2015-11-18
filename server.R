library(shiny)
library(datasets)

# Perform this at startup so that it can be used throughout the appplication

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Here we define the server logic
shinyServer(function(input, output) {
  
# Paste together the text since the formula will take verbatim this as code
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })

# We perform a similar task as above yet to fit a regression model to it 
  formulaTextReg <- reactive({
    paste("mpg ~", "as.integer(", input$variable, ")")
  })

# The output lets us change the title of the Plots  
  output$caption <- renderText({
    formulaText()
  })

# Generating a boxplot with mpg ~ desired variable and include outliers if selected 
  output$mpgBoxPlot <- renderPlot({
    boxplot(as.formula(formulaText()), ylab = 'mpg', xlab = input$variable,
            data = mpgData, outline = input$outliers, col = input$color
            )
  })

# Generating a plot with mpg ~ desired variable fitting a regression line  
  output$mpgPlot <- renderPlot({
    with(mpgData, {
      plot(as.formula(formulaTextReg()), ylab = "mpg", xlab = input$variable)
      abline(fit(), col=input$color)
    })
  })

# Generate a regression model   
  fit <- reactive({
    lm(as.formula(formulaTextReg()), data=mpgData)
  })

# Generate a summary of the regression model    
  output$fit <- renderPrint({
    summary(fit())
  })
  
  }
)