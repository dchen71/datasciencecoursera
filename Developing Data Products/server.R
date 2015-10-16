#This app will utilize subsetted training data from Kaggle Competition - San Francisco Crime Classification


library(shiny)

# Define server logic required for the app
shinyServer(function(input, output) {
    output$locPlot = renderPlot({
        #Loads libraries
        library(ggmap)
        library(ggplot2)
        library(dplyr)
        
        #Initializes data
        train = read.csv("Data/train.csv")
        map = get_map(location="sanfrancisco",zoom=12,source="osm")
        
        #Function to plot graph of locations of crime for visualization purposes
        map_crime = function(crime_df, crime) {
            filtered = filter(crime_df, Category %in% crime)
            plot = ggmap(map, extent='device') + 
                geom_point(data = filtered, aes(x = X, y = Y, color=Category, alpha=0.5))
            return(plot)
        }
        
        #Plots based on prostitution
        map_crime(train, c('PROSTITUTION'))
    })
})