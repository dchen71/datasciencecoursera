#This app will utilize subsetted training data from Kaggle Competition - San Francisco Crime Classification

library(shiny)

# Define server logic required for the app
shinyServer(function(input, output) {
    #Loads libraries
    library(ggmap)
    library(ggplot2)
    library(dplyr)
    library(lubridate)
    
    #Initializes data
    data = read.csv("subset.csv")

    #Convert dates into year value
    data$Dates = year(data$Dates)
    
    #Setup maps of San Francisco
    map = get_map(location="sanfrancisco",zoom=12,source="osm")
        
    output$locPlot = renderPlot({
        map_crime = function(crime_df, crime, year) {
            filtered = filter(crime_df, Category %in% crime)
            filtered = filter(filtered, Dates %in% year)
            plot = ggmap(map, extent='device') + 
                geom_point(data = filtered, aes(x = X, y = Y, color=Category))
            return(plot)
        }
        
        #Plots based on crimes selected in checkGroup
        if(length(input$checkGroup) != 0)
            map_crime(data, c(input$checkGroup), input$range)
        else{
            ggmap(map, extent='device')
        }
    })
})