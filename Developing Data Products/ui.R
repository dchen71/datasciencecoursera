#This app will utilize subsetted training data from Kaggle Competition - San Francisco Crime Classification

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Title
    titlePanel("San Francisco Crime Classifier"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            helpText("Choose the categories of crimes to display on the map"),
            checkboxGroupInput("checkGroup", 
                               label = h3("Checkbox group"), 
                               choices = list("Choice 1" = 1, "Choice 2" = 2,
                                              "Choice 2" = 3, "Choice 3" = 4),
                               selected = 1)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
))