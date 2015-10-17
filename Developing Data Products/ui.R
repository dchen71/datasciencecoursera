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
                               label = h3("Crime Categories"), 
                               choices = list("Warrants" = 'WARRANTS', "Vandalism" = 'VANDALISM',
                                              "Prostitution" = 'PROSTITUTION', "Bribery" = 'BRIBERY'),
                               selected = c('WARRANTS','VANDALISM','PROSTITUTION','BRIBERY'))
        ),
        
        # Show a plot of the generated distribution of crimes on a map of SF
        mainPanel(
            plotOutput("locPlot")
        )
    )
))