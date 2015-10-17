#This app will utilize subsetted training data from Kaggle Competition - San Francisco Crime Classification

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Title
    titlePanel("San Francisco Crime Map"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            helpText("Choose the categories of crimes to display on the map as well as the year"),
            checkboxGroupInput("checkGroup", 
                               label = h3("Crime Categories"), 
                               choices = list("Warrants" = 'WARRANTS', "Vandalism" = 'VANDALISM',
                                              "Prostitution" = 'PROSTITUTION', "Bribery" = 'BRIBERY'),
                               selected = c('WARRANTS','VANDALISM','PROSTITUTION','BRIBERY')),
            sliderInput("range", 
                        label = "Year of interest:",
                        min = 2003, max = 2015, value = 2003)
        ),
        
        # Show a plot of the generated distribution of crimes on a map of SF
        mainPanel(
            plotOutput("locPlot"),
            h3('Overview'),
            p('This uses subsetted data from the Kaggle Competition, San Francisco Crime Classifcation. This app is a
              used for a quick visualization of four of the crime types listed in the data. You can change the
              crimes listed in the map as well as the year where the crimes occured.')
        )
    )
))